import os
from pathlib import Path

import platformdirs


class Paths:
    base_dir: Path = platformdirs.user_config_path("axewbshell")
    wallpaper_dir: Path = base_dir / "wallpapers"
    theme: Path = base_dir / "theme.json"
    wallpaper: Path = base_dir / "wallpaper.json"

    @classmethod
    def ensure_dirs_exists(cls):
        cls.base_dir.mkdir(parents=True, exist_ok=True)
        cls.wallpaper_dir.mkdir(parents=True, exist_ok=True)
