import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:weather_app/model/weather_model.dart';

class WeatherService {
  Dio dio = Dio();

  Future<WeatherResponse> fetchingData(String city) async {
    final apiKey = '71ced824c06aeece5832d666f4f632a8';
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
