import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/model/weather_model.dart';
import '../viewmodel/service_controller.dart';

class WeatherPage extends StatelessWidget {
  WeatherPage({super.key});

  final TextEditingController _searchController =
      TextEditingController(text: "malappuram");

  String _getBackgroundImage(String weatherDescription) {
    if (weatherDescription.contains("Clear")) {
      return "assets/images/broken.jpeg";
    } else if (weatherDescription.contains("broken")) {
      return "assets/images/thunderstorm.jpg";
    } else if (weatherDescription.contains("Clouds")) {
      return "assets/images/cloud.jpg";
    } else if (weatherDescription.contains("Rain")) {
      return "assets/images/rain.jpg";
    } else if (weatherDescription.contains("thunderstorm")) {
      return "assets/images/thunderstorm.jpg";
    } else {
      return "assets/images/roken.jpeg";
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeatherProvider>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 184, 125, 36),
      body: Column(
        children: [
          Gap(50),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 200,
                child: TextFormField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Enter city name',
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  provider.fetchWeather(_searchController.text.trim());
                },
              ),
            ],
          ),
          Expanded(
            child: Consumer<WeatherProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (provider.error != null) {
                  return Center(
                    child: Text('Error: ${provider.error}'),
                  );
                } else if (provider.weatherData != null) {
                  WeatherResponse? data = provider.weatherData;
                  String? weatherDescription = data?.weather[0].main;
                  String backgroundImage =
                      _getBackgroundImage(weatherDescription ?? "");

                  return Container(
                    child: ListView(
                      children: [
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Gap(height * 0.13),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    '${provider.kelvinToCelsius(data?.main.temp ?? 0).toStringAsFixed(1)} °C',
                                    style: TextStyle(
                                      fontSize: 60,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Gap(16),
                                  Text(
                                    ' ${data?.name.toString() ?? ""}',
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Gap(16),
                                  Text(
                                    ' ${formatTime(data?.timezone ?? 0)}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              Gap(25)
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(backgroundImage),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Column(
                            children: [
                              Gap(25),
                              Container(
                                height: height * 0.07,
                                child: Row(
                                  children: [
                                    Text(
                                      ' ${weatherDescription ?? ""}',
                                      style: TextStyle(
                                          fontSize: 26, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              Gap(
                                height * 0.07,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Gap(
                                      height * 0.07,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Temp max",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '${provider.kelvinToCelsius(data?.main.tempMax ?? 0).toStringAsFixed(1)} °C',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                            ),
                                            Gap(5),
                                            Icon(Icons.thermostat,
                                                color: Colors.white),
                                          ],
                                        )
                                      ],
                                    ),
                                    Gap(25),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Temp min",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '${provider.kelvinToCelsius(data?.main.tempMin ?? 0).toStringAsFixed(1)} °C',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                            ),
                                            Gap(5),
                                            Icon(Icons.thermostat,
                                                color: Colors.white),
                                          ],
                                        )
                                      ],
                                    ),
                                    Gap(25),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Humidity",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '${data?.main.humidity ?? "null"}%',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                            ),
                                            Gap(5),
                                            Icon(Icons.water_drop,
                                                color: Colors.white),
                                          ],
                                        )
                                      ],
                                    ),
                                    Gap(25),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Cloudy",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "${data?.clouds.all ?? ""}%",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                            ),
                                            Gap(5),
                                            Icon(Icons.cloud,
                                                color: Colors.white),
                                          ],
                                        )
                                      ],
                                    ),
                                    Gap(25),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Wind",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "${data?.wind.speed ?? ""}km/h",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                            ),
                                            Gap(5),
                                            Icon(Icons.air,
                                                color: Colors.white),
                                          ],
                                        )
                                      ],
                                    ),
                                    Gap(25),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: Text('No data available'),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  String formatTime(int offset) {
    final offsetInHours = offset / 3600;
    final nowUtc = DateTime.now().toUtc();
    final localTime = nowUtc.add(Duration(hours: offsetInHours.toInt()));
    final formatter = DateFormat('hh:mm a - EEEE, d MMM yyyy');
    return formatter.format(localTime);
  }
}
