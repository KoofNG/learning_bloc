import 'package:learn_bloc/core/models/weather.model.dart';

abstract class WeatherRepository {
  /* 
    Fetch a particular city weather condition
  */
  Future<WeatherModel> fetchWeather(String cityName);

  /* 
    Fetch the detailed weather condition of a city
  */
  Future<WeatherModel> fetchDetailedWeather(String cityName);
}
