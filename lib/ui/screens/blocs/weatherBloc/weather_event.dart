part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

/* This event gets a weather condition */
class GetWeather extends WeatherEvent {
  final String cityName;

  GetWeather({@required this.cityName});

  @override
  List<Object> get props => [cityName];
}

/* This event get a detailed weather condition */
class GetDetailedWeather extends WeatherEvent {
  final String cityName;

  GetDetailedWeather({@required this.cityName});

  @override
  List<Object> get props => [cityName];
}
