import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/core/blocs/weatherBloc/weather_bloc.dart';
import 'package:learn_bloc/core/models/weather.model.dart';

class WeatherSearchDetail extends StatefulWidget {
  final WeatherModel weatherModel;

  WeatherSearchDetail({Key key, @required this.weatherModel}) : super(key: key);

  @override
  _WeatherSearchDetailState createState() => _WeatherSearchDetailState();
}

class _WeatherSearchDetailState extends State<WeatherSearchDetail> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    BlocProvider.of<WeatherBloc>(context)
      ..add(
        GetDetailedWeather(cityName: widget.weatherModel.cityName),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather Detail"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoading) {
              return buildLoading();
            }
            if (state is WeatherLoaded) {
              return buildColumnWithData(context, state.weatherModel);
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Column buildColumnWithData(BuildContext context, WeatherModel weatherModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          weatherModel.cityName,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          // Display the Celsius temperature with 1 decimal place
          "${weatherModel.temperatureCelsius} °C",
          style: TextStyle(fontSize: 80),
        ),
        Text(
          // Display the Fahrenheit temperature with 1 decimal place
          "${weatherModel.temperatureFarenheit} °F",
          style: TextStyle(fontSize: 80),
        ),
      ],
    );
  }
}
