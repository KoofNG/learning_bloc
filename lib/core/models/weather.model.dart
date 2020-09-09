import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class WeatherModel extends Equatable {
  final String cityName;
  final String temperatureCelsius;
  final String temperatureFarenheit;

  WeatherModel({
    @required this.cityName,
    @required this.temperatureCelsius,
    this.temperatureFarenheit,
  });

  @override
  List<Object> get props => [
        cityName,
        temperatureCelsius,
        temperatureFarenheit,
      ];

  @override
  int get hashCode => cityName.hashCode + temperatureCelsius.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherModel &&
          runtimeType == other.runtimeType &&
          cityName + temperatureCelsius == other.cityName + temperatureCelsius;

  @override
  bool get stringify => true;
}
