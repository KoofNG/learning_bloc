part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

/* Initial state of the screen */
class WeatherInitial extends WeatherState {
  WeatherInitial();

  @override
  List<Object> get props => [];
}

/* When the state of the screen is loading */
class WeatherLoading extends WeatherState {
  WeatherLoading();

  @override
  List<Object> get props => [];
}

/* When the state as data */
class WeatherLoaded extends WeatherState {
  final WeatherModel weatherModel;

  WeatherLoaded(this.weatherModel);

  @override
  List<Object> get props => [weatherModel];
}

/* When the state as error of data*/
class WeatherError extends WeatherState {
  final String message;

  WeatherError(this.message);

  @override
  List<Object> get props => [message];
}
