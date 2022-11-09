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
  String? weatherIcon;
  String? cityName;
  String? weatherMessage;
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
        return;
      }
      double temp = weatherData['main']['temp'];
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
      body: Container(
        // decoration: BoxDecoration(
        //   // image: DecorationImage(
        //   //   image: const AssetImage('images/main.jpg'),
        //   //   fit: BoxFit.cover,
        //   //   colorFilter: ColorFilter.mode(
        //   //       Colors.white.withOpacity(0.8), BlendMode.dstATop),
        //   // ),
        // ),
        // constraints: const BoxConstraints.expand(),
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
                    Text(
                      '$cityName ',
                      style: TextStyle(
                          fontFamily: 'MavenPro',
                          fontSize: 35,
                          color: Colors.white.withOpacity(0.9)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      DateFormat('MMMEd').format(DateTime.now()),
                      style: TextStyle(
                          fontFamily: 'MavenPro',
                          fontSize: 15,
                          color: Colors.white.withOpacity(0.9)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Image.asset(
                      weatherIcon.toString(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '$temperature°',
                      style: TextStyle(
                          fontFamily: 'MavenPro',
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.white.withOpacity(0.9)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '$weatherMessage',
                      style: TextStyle(
                          fontFamily: 'MavenPro',
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.white.withOpacity(0.9)),
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
              //       child: SizedBox(
              //         width: 300,
              //         height: 100,
              //         child: Text(
              //           "It is $temperature°C in $cityName  ",
              //           textAlign: TextAlign.justify,
              //           style: kMessageTextStyle,
              //         ),
              //       ),
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
