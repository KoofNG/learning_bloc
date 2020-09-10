import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/core/blocs/weatherBloc/weather_bloc.dart';
import 'package:learn_bloc/core/services/weather.repository.dart';
import 'package:learn_bloc/ui/screens/weatherSearch.screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learn Bloc',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        create: (context) => WeatherBloc(WeatherDataRepository()),
        child: WeatherSearchPage(),
      ),
    );
  }
}
