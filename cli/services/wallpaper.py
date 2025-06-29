import json
from argparse import ArgumentParser
from pathlib import Path

from utils.paths import Paths


class Wallpaper:
    def __init__(self) -> None:
        self.root_dir = Paths.wallpaper_dir
        self.config = Paths.wallpaper
        self.image_extensions = [".jpeg", ".png", ".jpg"]

        self.subdirs: list[Path] = [
            subdir for subdir in self.root_dir.iterdir() if subdir.is_dir()
        ]

        self.wallpapers: list[Path] = self._get_all_wallpapers()

    # def _load_history(self) -> list[Path]:
    #     with open(self.config, "r") as file:
    #         data = json.load(file)

    #     print(data)

    #     pass

    def _get_all_wallpapers(self) -> list[Path]:
        # В исходной директории
        dir_walls = [
            wall
            for wall in self.root_dir.iterdir()
            if wall.is_file() and wall.suffix.lower() in self.image_extensions
        ]

        # В поддиректориях
        subdir_walls: list[Path] = []
        for subdir in self.subdirs:
            subdir_walls.extend(
                [
                    wall
                    for wall in subdir.iterdir()
                    if wall.is_file() and wall.suffix.lower() in self.image_extensions
                ]
            )

        return [*dir_walls, *subdir_walls]

    def get_all_wallpapers(self) -> list[dict[str, str]]:
        return [{"name": wall.stem, "path": str(wall)} for wall in self.wallpapers]

    def get_subdirs(self) -> list[dict[str, str]]:
        return [{"name": subdir.name, "path": str(subdir)} for subdir in self.subdirs]

    def get_wallpapers_from_root_dir(self) -> list[dict[str, str]]:
        return self._get_wallpapers_from_dir(self.root_dir)

    def get_wallpapers_from_sub_dir(self, subdir: str) -> list[dict[str, str]]:
        dir = self.root_dir / subdir
        subdir_names = [d.name for d in self.subdirs]

        if subdir not in (subdir_names):
            raise RuntimeError(
                f"There is no such subdirectory as {subdir}. Found: {subdir_names}"
            )

        return self._get_wallpapers_from_dir(dir)

    def _get_wallpapers_from_dir(self, dir: Path) -> list[dict[str, str]]:
        if not dir.is_dir():
            raise RuntimeError(f"{dir} is not directory")

        return [
            {"name": wall.stem, "path": str(wall)}
            for wall in dir.iterdir()
            if wall.is_file() and wall.suffix in self.image_extensions
        ]

    def set_wallpaper(self, wall_name: str) -> None:
        wall = Path([wall for wall in self.wallpapers if (wall.name == wall_name)][0])
        if not wall:
            raise RuntimeError(
                "There is no such image in wallpapers directory or it's subdirectories"
            )

        with open(self.config, "w") as file:
            file.write(json.dumps({"name": wall.stem, "path": str(wall)}))


def get_parser(parser: ArgumentParser | None):
    if parser is None:
        parser = ArgumentParser(
            "Wallpaper module",
            "Module for getting paths to directories and images for wallpapers",
        )

    getSetGroup = parser.add_mutually_exclusive_group(required=True)
    getSetGroup.add_argument("-g", "--get", choices=["walls", "dirs", "root", "subdir"])
    getSetGroup.add_argument("-s", "--set", action="store_true", default=False)

    parser.add_argument("path", type=str, default="root")


def get_wall(wallpaper: Wallpaper, args):
    result: list[dict[str, str]] = []
    if args.get == "walls":
        result = wallpaper.get_all_wallpapers()
    elif args.get == "dirs":
        result = wallpaper.get_subdirs()
    elif args.get == "root":
        result = wallpaper.get_wallpapers_from_root_dir()
    elif args.get == "subdir":
        result = wallpaper.get_wallpapers_from_sub_dir(args.path)

    print(json.dumps(result))


def set_wall(wallpaper: Wallpaper, args):
    wallpaper.set_wallpaper(args.path)


def main(args):
    wallpaper = Wallpaper()

    if args.get:
        get_wall(wallpaper, args)

    if args.set:
        set_wall(wallpaper, args)
