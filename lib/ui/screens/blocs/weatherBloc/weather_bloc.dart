import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:learn_bloc/core/models/weather.model.dart';
import 'package:learn_bloc/core/services/weather.repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherDataRepository weatherDataRepository;

  WeatherBloc({
    @required this.weatherDataRepository,
  }) : super(WeatherInitial());

  WeatherState get initialState => WeatherInitial();

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    yield WeatherLoading();

    if (event is GetWeather) {
      try {
        final WeatherModel weatherModel =
            await weatherDataRepository.fetchWeather(event.cityName);
        yield WeatherLoaded(weatherModel);
      } on NetworkError {
        yield WeatherError('Couldn\'t fetch weather.');
      }
    }

    if (event is GetDetailedWeather) {
      try {
        final WeatherModel weatherModel =
            await weatherDataRepository.fetchDetailedWeather(event.cityName);
        yield WeatherLoaded(weatherModel);
      } on NetworkError {
        yield WeatherError('Couldn\'t fetch weather details.');
      }
    }
  }
}
