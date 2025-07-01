# reference: https://open-meteo.com/en/docs
import json
from argparse import ArgumentParser

import openmeteo_requests
import pandas as pd
import requests_cache
from retry_requests import retry

from utils.paths import Paths

URL = "https://api.open-meteo.com/v1/forecast"


class Weather:
    def __init__(
        self,
        latitude: float,
        longitude: float,
        temperature_unit: str,
        timezone: str,
    ):
        self.latitude = latitude
        self.longitude = longitude
        self.temperature_unit = temperature_unit
        self.timezone = timezone

    def get_weekly(self):
        params = {
            "latitude": self.latitude,
            "longitude": self.longitude,
            "temperature_unit": self.temperature_unit,
            "timezone": self.timezone,
            "daily": [
                "weather_code",
                "sunrise",
                "sunset",
                "daylight_duration",
                "temperature_2m_max",
                "temperature_2m_min",
            ],
        }

        response = self._get_weather(params)

        daily = response.Daily()
        daily_weather_code = daily.Variables(0).ValuesAsNumpy().tolist()
        daily_sunrise = daily.Variables(1).ValuesInt64AsNumpy().tolist()
        daily_sunset = daily.Variables(2).ValuesInt64AsNumpy().tolist()
        daily_daylight_duration = daily.Variables(3).ValuesAsNumpy().tolist()
        daily_temperature_2m_max = daily.Variables(4).ValuesAsNumpy().tolist()
        daily_temperature_2m_min = daily.Variables(5).ValuesAsNumpy().tolist()

        daily_data = (
            pd.date_range(
                start=pd.to_datetime(daily.Time(), unit="s", utc=True),
                end=pd.to_datetime(daily.TimeEnd(), unit="s", utc=True),
                freq=pd.Timedelta(seconds=daily.Interval()),
                inclusive="left",
            )
            .strftime("%Y-%m-%d")
            .tolist()
        )

        result = {
            "daily": {
                "date": daily_data,
                "temp_max": daily_temperature_2m_max,
                "temp_min": daily_temperature_2m_min,
                "weather_code": daily_weather_code,
                "sunrise": daily_sunrise,
                "sunset": daily_sunset,
                "daylight_duration": daily_daylight_duration,
            },
        }

        self.print_to_cache(result)

    def get_current(self):
        params = {
            "current": [
                "temperature_2m",
                "rain",
                "showers",
                "snowfall",
                "weather_code",
            ],
            "latitude": self.latitude,
            "longitude": self.longitude,
            "temperature_unit": self.temperature_unit,
            "timezone": self.timezone,
        }
        response = self._get_weather(params)

        current = response.Current()
        current_time = current.Time()
        current_temperature_2m = current.Variables(0).Value()
        current_rain = current.Variables(1).Value()
        current_showers = current.Variables(2).Value()
        current_snowfall = current.Variables(3).Value()
        current_weather_code = current.Variables(4).Value()

        result = {
            "current": {
                "time": current_time,
                "temperature_2m": current_temperature_2m,
                "rain": current_rain,
                "showers": current_showers,
                "snowfall": current_snowfall,
                "weather_code": current_weather_code,
            },
        }

        jsonData = json.dumps(result)

        # будет обрабатываться в самом qml, без записи в файл
        print(jsonData)

    def _get_weather(self, params):
        cache_session = requests_cache.CachedSession(".cache", expire_after=3600)
        retry_session = retry(cache_session, retries=5, backoff_factor=0.2)
        openmeteo = openmeteo_requests.Client(session=retry_session)

        responses = openmeteo.weather_api(URL, params=params)
        return responses[0]  # expecting only one location

    def print_to_cache(self, data: dict):
        with open(Paths.weather_cache, "w") as file:
            file.write(json.dumps(data))


def get_parser(parser: ArgumentParser | None):
    if parser is None:
        parser = ArgumentParser(
            "Weather parser module",
            "Module for getting paths to directories and images for wallpapers",
        )

    parser.add_argument("-t", "--type", choices=["current", "weekly"], required=True)
    parser.add_argument("-la", "--latitude", type=float, required=True)
    parser.add_argument("-lo", "--longitude", type=float, required=True)
    parser.add_argument("-z", "--timezone", default="GMT", type=str)
    parser.add_argument("-u", "--temperature_unit", default="celsius", type=str)


def main(args):
    weather = Weather(
        latitude=args.latitude,
        longitude=args.longitude,
        temperature_unit=args.temperature_unit,
        timezone=args.timezone,
    )

    if args.type == "current":
        weather.get_current()
    if args.type == "weekly":
        weather.get_weekly()
