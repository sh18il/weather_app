import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/model/weather_model.dart';
import '../viewmodel/service_controller.dart';

class WeatherPage extends StatelessWidget {
  WeatherPage({super.key});
  String _getBackgroundImage(String weatherDescription) {
    if (weatherDescription.contains("Clear")) {
      return "assets/images/broken.jpeg";
    } else if (weatherDescription.contains("broken")) {
      return "assets/images/thunderstorm.jpg";
    } else if (weatherDescription.contains("Clouds")) {
      return "assets/images/cloud.jpg";
    } else if (weatherDescription.contains("Rain")) {
      return "assets/images/rain.jpg";
    } else if (weatherDescription.contains("Thunderstorm")) {
      return "assets/images/thunderstorm.jpg";
    } else if (weatherDescription.contains("Mist")) {
      return "assets/images/mist.webp";
    } else {
      return "assets/images/roken.jpeg";
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _searchController =
        TextEditingController(text: "kerala");
    final provider = Provider.of<WeatherProvider>(context, listen: false);
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Gap(50),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                    width: 200,
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Enter city name',
                        hintStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: Colors.white,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(
                            style: BorderStyle.solid,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )),
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
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
                      child:
                          Lottie.asset("assets/Animation - 1723132358628.json"),
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
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: height * 0.08,
                                    child: Row(
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              ' ${weatherDescription ?? ""}',
                                              style: TextStyle(
                                                  fontSize: 26,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              ' ${data?.weather[0].description ?? ""}',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Gap(
                                  height * 0.04,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      Gap(
                                        height * 0.07,
                                      ),
                                      WeatherDetailsRow(
                                        value:
                                            '${provider.kelvinToCelsius(data?.main.tempMax ?? 0).toStringAsFixed(1)} °C',
                                        text: "temp",
                                        Icon: Icon(Icons.thermostat,
                                            color: Colors.white),
                                      ),
                                      Gap(25),
                                      WeatherDetailsRow(
                                          value:
                                              '${provider.kelvinToCelsius(data?.main.tempMin ?? 0).toStringAsFixed(1)} °C',
                                          text: "Temp min",
                                          Icon: Icon(Icons.thermostat,
                                              color: Colors.white)),
                                      Gap(25),
                                      WeatherDetailsRow(
                                        value:
                                            '${data?.main.humidity ?? "null"}%',
                                        text: "Humidity",
                                        Icon: Icon(Icons.water_drop,
                                            color: Colors.white),
                                      ),
                                      Gap(25),
                                      WeatherDetailsRow(
                                        value: "${data?.clouds.all ?? ""}%",
                                        text: "Cloudy",
                                        Icon: Icon(Icons.cloud,
                                            color: Colors.white),
                                      ),
                                      Gap(25),
                                      WeatherDetailsRow(
                                        value: "${data?.wind.speed ?? ""}km/h",
                                        text: "Wind",
                                        Icon: Icon(Icons.air,
                                            color: Colors.white),
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
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset("assets/Animation - 1723132912863.json"),
                          Gap(20),
                          Text(
                            'Search City',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatTime(int offset) {
    final offsetInHours = offset / 3600;
    final nowUtc = DateTime.now().toUtc();
    final localTime = nowUtc.add(Duration(hours: offsetInHours.toInt()));
    final formatter = DateFormat('hh:mm a - EEEE, d MMM "yy');
    return formatter.format(localTime);
  }
}

class WeatherDetailsRow extends StatelessWidget {
  WeatherDetailsRow({
    super.key,
    required this.value,
    required this.text,
    required this.Icon,
  });

  final String value;

  final String text;
  final Icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        Row(
          children: [
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            Gap(5),
            Icon
          ],
        )
      ],
    );
  }
}
