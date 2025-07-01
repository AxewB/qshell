import json
import math
from argparse import ArgumentParser
from enum import Enum
from typing import Literal

from materialyoucolor.dynamiccolor.material_dynamic_colors import MaterialDynamicColors
from materialyoucolor.hct import Hct
from materialyoucolor.quantize import ImageQuantizeCelebi
from materialyoucolor.scheme.scheme_android import SchemeAndroid
from materialyoucolor.scheme.scheme_content import SchemeContent
from materialyoucolor.scheme.scheme_expressive import SchemeExpressive
from materialyoucolor.scheme.scheme_fidelity import SchemeFidelity
from materialyoucolor.scheme.scheme_fruit_salad import SchemeFruitSalad
from materialyoucolor.scheme.scheme_monochrome import SchemeMonochrome
from materialyoucolor.scheme.scheme_neutral import SchemeNeutral
from materialyoucolor.scheme.scheme_rainbow import SchemeRainbow
from materialyoucolor.scheme.scheme_tonal_spot import SchemeTonalSpot
from materialyoucolor.scheme.scheme_vibrant import SchemeVibrant
from materialyoucolor.score.score import Score
from materialyoucolor.utils.color_utils import rgba_from_argb
from PIL import Image

from utils.paths import Paths


def rgba_to_hex(rgba):
    return "#{:02X}{:02X}{:02X}{:02X}".format(*map(round, rgba))


SCHEMES = {
    "scheme_vibrant": SchemeVibrant,
    "scheme_tonal_spot": SchemeTonalSpot,
    "scheme_rainbow": SchemeRainbow,
    "scheme_neutral": SchemeNeutral,
    "scheme_monochrome": SchemeMonochrome,
    "scheme_fruit_salad": SchemeFruitSalad,
    "scheme_fidelity": SchemeFidelity,
    "scheme_expressive": SchemeExpressive,
    "scheme_content": SchemeContent,
    "scheme_android": SchemeAndroid,
}


class ThemeSourceType(Enum):
    COLOR = "color"
    IMAGE = "image"


class Theme:
    def __init__(
        self,
        scheme: str,
        is_dark: bool,
        source: str,
        contrast: int,
        source_type: Literal["image", "color"] | None,
    ) -> None:
        self.scheme: str = scheme
        self.contrast = contrast
        self.is_dark = is_dark
        self.source_type = source_type
        self.source = source
        self.prefix = "m3"

        self.quality = self._get_quality()
        self.palette = None

    def _get_quality(self):
        width = 0
        height = 0

        with Image.open(self.source) as img:
            width, height = img.size

        width = width / 1920
        height = height / 1080

        quality = (width + height) * 100

        return math.ceil(quality)

    def _get_colors(self):
        if self.source_type == "image":
            image = Paths.wallpaper_dir / self.source
            quantized = ImageQuantizeCelebi(str(image), self.quality, 128)
            return Score.score(quantized)[0]
        elif self.source_type == "color":
            return int("0xFF" + str(self.source), 16)
        else:
            raise ValueError("Wrong source type. Must be ")

    def save_to_file(self):
        path = Paths.theme
        jsonData = json.dumps(self.__dict__)

        with open(path, "w") as file:
            file.write(jsonData)

    def generate_palette(self):
        palette = {}

        selected = self._get_colors()
        color = rgba_to_hex(rgba_from_argb(selected))[:-2]
        scheme_class = SCHEMES[self.scheme]

        dynamic_palette = scheme_class(
            Hct.from_int(selected), self.is_dark, self.contrast
        )
        color_names = vars(MaterialDynamicColors).keys()

        for color in color_names:
            attr = getattr(MaterialDynamicColors, color)
            if hasattr(attr, "get_hct"):
                attr_color = rgba_to_hex(attr.get_hct(dynamic_palette).to_rgba())[:-2]
                palette[self.prefix + color] = attr_color

        self.palette = palette


def get_parser(parser: ArgumentParser | None):
    if parser is None:
        parser = ArgumentParser(
            "Theme module",
            "Module for creating palette for shell using HEX color or image",
        )
    parser.add_argument(
        "-s",
        "--scheme",
        default="scheme_tonal_spot",
        type=str,
        choices=[
            "scheme_vibrant",
            "scheme_tonal_spot",
            "scheme_rainbow",
            "scheme_neutral",
            "scheme_monochrome",
            "scheme_fruit_salad",
            "scheme_fidelity",
            "scheme_expressive",
            "scheme_content",
            "scheme_android",
        ],
        help="Scheme of the palette.",
    )
    parser.add_argument("-ct", "--contrast", default=0, type=int)
    parser.add_argument("-d", "--dark", action="store_true", default=False)

    source_group = parser.add_mutually_exclusive_group(required=True)
    source_group.add_argument(
        "-c", "--color", help="Color as base for palette", type=str
    )
    source_group.add_argument(
        "-i", "--image", help="Image as base for palette", type=str
    )


def main(args):
    theme = Theme(
        scheme=args.scheme,
        is_dark=args.dark,
        source=args.image or args.color,
        source_type="color" if args.color else "image" if args.image else None,
        contrast=args.contrast,
    )
    theme.generate_palette()
    theme.save_to_file()
