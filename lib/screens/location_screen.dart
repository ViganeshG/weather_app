// ignore_for_file: library_private_types_in_public_api, unused_local_variable
import 'package:dart_date/dart_date.dart';
import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import 'package:weather_app/services/weather.dart';
import "city_screen.dart";
import 'package:intl/intl.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int? temperature;
  int? humidity;
  double? wind;
  String? weatherIcon;
  String? cityName;
  String? weatherMessage;
  double? windKmh;
  int? windDirection;

  // String? timeString;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = null;
        weatherMessage = "Unable to update weather data";
        cityName = "";
        windKmh = 0;

        return;
      }
      double temp = weatherData['main']['temp'];
      int humidity = weatherData['main']['humidity'];
      double wind = weatherData['wind']['speed'];
      int windDirection = weatherData['wind']['deg'];
      windKmh = wind * 3.6;

      temperature = temp.toInt();
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      weatherMessage = weather.getMessage(temperature!);
      cityName = weatherData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: size.height * 0.75,
                width: size.width,
                padding: const EdgeInsets.only(top: 20),
                margin: const EdgeInsets.only(right: 10, left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.red,
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(235, 161, 235, 0),
                      Color.fromARGB(133, 80, 202, 239),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: [0.2, 0.85],
                  ),
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 45),
                    ),
                    Text(
                      '$cityName ',
                      style: TextStyle(
                          fontFamily: 'MavenPro',
                          fontSize: 45,
                          fontWeight: FontWeight.w700,
                          color: Colors.white.withOpacity(0.9)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      DateFormat('MMMEd').format(DateTime.now()),
                      style: TextStyle(
                          fontFamily: 'MavenPro',
                          fontSize: 20,
                          color: Colors.white.withOpacity(0.9)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Image.asset(
                      weatherIcon.toString(),
                    ),
                    Text(
                      '$weatherMessage',
                      style: TextStyle(
                          fontFamily: 'MavenPro',
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                          color: Colors.white.withOpacity(0.9)),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '$temperature°',
                      style: const TextStyle(
                          fontFamily: 'MavenPro',
                          fontSize: 60,
                          fontWeight: FontWeight.w800,
                          color: Colors.white),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Image.asset(
                                'images/wind.png',
                                width: size.width * 0.15,
                              ),
                              Text(
                                '$windKmh Km/h',
                                style: const TextStyle(
                                    fontFamily: 'Hubballi',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'Wind',
                                style: TextStyle(
                                    fontFamily: 'Hubballi',
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Image.asset(
                                'images/windsock.png',
                                width: size.width * 0.15,
                              ),
                              Text(
                                '$windDirection°',
                                style: const TextStyle(
                                    fontFamily: 'Hubballi',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'Wind Direction',
                                style: TextStyle(
                                    fontFamily: 'Hubballi',
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Image.asset(
                                'images/humidity.png',
                                width: size.width * 0.15,
                              ),
                              Text(
                                '$humidity %',
                                style: const TextStyle(
                                    fontFamily: 'Hubballi',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'Humidity',
                                style: TextStyle(
                                    fontFamily: 'Hubballi',
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: <Widget>[
              //     IconButton(
              //       onPressed: () {
              //         var weatherData = weather.getLocationWeather();
              //         updateUI(weatherData);
              //       },
              //       icon: const Icon(
              //         Icons.near_me,
              //         size: 35,
              //       ),
              //     ),
              //     IconButton(
              //       onPressed: () async {
              //         var typedName = await Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //             builder: (context) {
              //               return CityScreen();
              //             },
              //           ),
              //         );
              //         if (typedName != null) {
              //           var weatherData =
              //               await weather.getCityWeather(typedName);
              //           updateUI(weatherData);
              //         }
              //       },
              //       icon: const Icon(
              //         Icons.location_city,
              //         size: 35,
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(
              //   height: 50,
              // ),
              // Container(
              //   alignment: Alignment.center,
              //   child: Card(
              //     elevation: 6,
              //     child: InkWell(
              //       splashColor: Colors.blue.withAlpha(30),
              //       onTap: () {
              //         debugPrint('Card tapped.');
              //       },
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
