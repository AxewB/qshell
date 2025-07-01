from pathlib import Path

import platformdirs


class Paths:
    base_dir: Path = platformdirs.user_config_path("axewbshell")

    # services
    theme: Path = base_dir / "theme.json"
    wallpaper_dir: Path = base_dir / "wallpapers"
    wallpaper: Path = base_dir / "wallpaper.json"

    # cache
    cache_dir: Path = platformdirs.user_cache_path("axewbshell")
    weather_cache: Path = cache_dir / "weather.json"

    @classmethod
    def ensure_dirs_exists(cls):
        cls.base_dir.mkdir(parents=True, exist_ok=True)
        cls.cache_dir.mkdir(parents=True, exist_ok=True)
        cls.wallpaper_dir.mkdir(parents=True, exist_ok=True)
