import 'dart:math';

import 'package:learn_bloc/core/models/weather.model.dart';
import 'package:learn_bloc/core/services/interfaces/weather.interface.dart';

class WeatherDataRepository extends WeatherRepository {
  double cachedTempCelsius = 0.0;

  @override
  Future<WeatherModel> fetchDetailedWeather(String cityName) {
    return Future.delayed(
      Duration(seconds: 2),
      () {
        final random = Random();

        if (random.nextBool()) {
          throw NetworkError();
        }
        cachedTempCelsius = 20 + random.nextInt(15) + random.nextDouble();

        return WeatherModel(
          cityName: cityName,
          temperatureCelsius: cachedTempCelsius.toString(),
        );
      },
    );
  }

  @override
  Future<WeatherModel> fetchWeather(String cityName) {
    return Future.delayed(
      Duration(seconds: 2),
      () {
        return WeatherModel(
          cityName: cityName,
          temperatureCelsius: cachedTempCelsius.toString(),
          temperatureFarenheit: (cachedTempCelsius * 1.8 + 32).toString(),
        );
      },
    );
  }
}

class NetworkError extends Error {}
