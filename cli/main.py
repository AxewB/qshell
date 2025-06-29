import argparse
import sys
from argparse import ArgumentError, ArgumentParser
from re import sub

from services import theme, wallpaper
from utils.paths import Paths

SERVICES = {"theme": theme, "wallpaper": wallpaper}


def main():
    # Создаем необходимые директории
    Paths.ensure_dirs_exists()

    parser = argparse.ArgumentParser(
        prog="AxewB shell script provider.",
        description="Script provider for AxewB Quickshell",
    )

    subparsers = parser.add_subparsers(
        dest="mod",
        help="Module to work with",
        required=True,
    )

    # Создаем парсеры для каждого модуля
    for key, service in SERVICES.items():
        service_parser = subparsers.add_parser(key, help=f"{key} module")
        service.get_parser(service_parser)

    args = parser.parse_args()

    # Запускаем main функцию нужного модуля
    SERVICES[args.mod].main(args)

    if args.mod not in SERVICES.keys():
        raise ValueError("Wrong module name")


if __name__ == "__main__":
    main()
