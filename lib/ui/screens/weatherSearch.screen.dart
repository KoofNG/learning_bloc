import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/core/blocs/weatherBloc/weather_bloc.dart';
import 'package:learn_bloc/core/models/weather.model.dart';
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
                return buildInitialInput();
              }
              if (state is WeatherLoading) {
                return buildLoading();
              }
              if (state is WeatherLoaded) {
                return buildColumnWithData(context, state.weatherModel);
              }
              if (state is WeatherError) {
                return buildInitialInput();
              }
              return SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  Widget buildInitialInput() {
    return Center(
      child: CityInputField(),
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
          // Display the temperature with 1 decimal place
          "${weatherModel.temperatureCelsius} °C",
          style: TextStyle(fontSize: 80),
        ),
        RaisedButton(
          child: Text('See Details'),
          color: Colors.lightBlue[100],
          onPressed: () {
            // Navigator.of(context).push(MaterialPageRoute(
            //   builder: (_) => WeatherDetailPage(
            //     masterWeather: weather,
            //   ),
            // ));
          },
        ),
        CityInputField(),
      ],
    );
  }
}
