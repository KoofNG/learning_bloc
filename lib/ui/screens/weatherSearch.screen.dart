import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/core/blocs/weatherBloc/weather_bloc.dart';
import 'package:learn_bloc/core/models/weather.model.dart';
import 'package:learn_bloc/ui/screens/weatherSearchDetail.screen.dart';
import 'package:learn_bloc/ui/widgets/inputField.widget.dart';

class WeatherSearchPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Weather Search'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        alignment: Alignment.center,
        child: BlocListener<WeatherBloc, WeatherState>(
          listener: (context, state) {
            if (state is WeatherError) {
              _scaffoldKey.currentState.showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherInitial) {
                return buildInitialInput(context);
              }
              if (state is WeatherLoading) {
                return buildLoading();
              }
              if (state is WeatherLoaded) {
                return buildColumnWithData(context, state.weatherModel);
              }
              if (state is WeatherError) {
                return buildInitialInput(context);
              }
              return SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  Widget buildInitialInput(BuildContext context) {
    return Center(
      child: CityInputField(
        onSubmitted: (value) {
          // ignore: close_sinks
          final WeatherBloc weatherBloc = BlocProvider.of<WeatherBloc>(context);
          weatherBloc.add(
            GetWeather(cityName: value),
          );
        },
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
          "${weatherModel.temperatureCelsius} °C",
          style: TextStyle(fontSize: 80),
        ),
        RaisedButton(
          child: Text('See Details'),
          color: Colors.lightBlue[100],
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: BlocProvider.of<WeatherBloc>(context),
                  child: WeatherSearchDetail(
                    weatherModel: weatherModel,
                  ),
                ),
              ),
            );
          },
        ),
        CityInputField(
          onSubmitted: (value) {
            // ignore: close_sinks
            final WeatherBloc weatherBloc = BlocProvider.of<WeatherBloc>(context);
            weatherBloc.add(
              GetWeather(cityName: value),
            );
          },
        ),
      ],
    );
  }
}
