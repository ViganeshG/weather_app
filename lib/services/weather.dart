import 'package:flutter/material.dart';
import 'package:weather_app/services/location.dart';
import 'package:weather_app/services/networking.dart';

const apiKey = '118c3c621fbdc7e0abeeba5405416549';
const openWeatherMapUrl = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        "$openWeatherMapUrl?q=$cityName&appid=$apiKey&units=metric");
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();

    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return 'images/storm.png';
    } else if (condition < 400) {
      return 'images/rain.png';
    } else if (condition < 600) {
      return 'images/umbrella.png';
    } else if (condition < 700) {
      return 'images/snow.png';
    } else if (condition < 800) {
      return 'images/fog.png';
    } else if (condition == 800) {
      return 'images/sun.png';
    } else if (condition <= 804) {
      return 'images/cloud.png';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'Its A Warm Weather';
    } else if (temp > 20) {
      return 'Bit Colder Today';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
