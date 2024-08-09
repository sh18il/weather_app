import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/service/secret_key.dart';

class WeatherService {
  Dio dio = Dio();

  Future<WeatherResponse> fetchingData(String city) async {
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey';

    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = response.data;
        log(jsonData.toString());
        return WeatherResponse.fromJson(jsonData);
      } else {
        throw Exception("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to load data: $e");
    }
  }
}
