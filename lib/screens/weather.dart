// ignore_for_file: prefer_const_constructors, prefer_if_null_operators

import 'package:flutter/material.dart';
import 'package:weather_app/model/model.dart';

import '../client/client.dart';

class Weather extends StatefulWidget {
  const Weather({super.key});

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  WeatherModel? weatherModel;
  List<Widget>? Hourly_cast;
  List<Widget>? Hourly_cast_time;
  List<Widget>? Hourly_cast_windspeed;
  List<dynamic>? hourly_temp;
  List<dynamic>? hourly_date;
  List<dynamic>? hourly_wind;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0x212121),
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Pune",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold)),
                  const Text(
                    'Current Weather',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Icon(
                    Icons.sunny,
                    color: Colors.amber,
                    size: 64,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                      "${weatherModel?.currentWeather["temperature"] != null ? weatherModel?.currentWeather["temperature"] : 0}°C",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold)),
                  ElevatedButton(
                      onPressed: () async {
                        print('call btn');
                        weatherModel = await WeatherApiClient().request();
                        print(weatherModel);
                        hourly_temp =
                            weatherModel?.hourlyWeather["temperature_2m"];
                        hourly_wind =
                            weatherModel?.hourlyWeather["windspeed_10m"];
                        hourly_date = weatherModel?.hourlyWeather["time"];
                        Hourly_cast = hourly_temp
                            ?.map((e) => Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    "$e °C",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ))
                            .toList();
                        Hourly_cast_time = hourly_date
                            ?.map((e) => Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text("$e",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ))
                            .toList();
                        Hourly_cast_windspeed = hourly_wind
                            ?.map((e) => Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text("$e km/h",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ))
                            .toList();
                        setState(() {});
                      },
                      child: Text('Call API')),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 60),
                        child: Text('Time',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 70),
                        child: Text('Temp',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text('WSpeed',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold))),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0x212121)),
                    margin: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: Hourly_cast_time == null
                              ? [Text('No data')]
                              : Hourly_cast_time!,
                        ),
                        Column(
                            children: Hourly_cast == null
                                ? [Text('No Data')]
                                : Hourly_cast!),
                        Column(
                            children: Hourly_cast_windspeed == null
                                ? [Text('No Data')]
                                : Hourly_cast_windspeed!),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
