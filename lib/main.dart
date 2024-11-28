import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_cubit.dart';
import 'package:weather_app/cubits/get_weather_cubit/get_weather_state.dart';
import 'package:weather_app/views/home_view.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetWeatherCubit(),
      child: BlocBuilder<GetWeatherCubit, WeatherState>(
        builder: (context, state) {
          // تحديد لون الثيم بناءً على حالة الطقس الحالية
          final MaterialColor themeColor = getThemeColor(
            BlocProvider.of<GetWeatherCubit>(context).weatherModel?.condition,
          );

          return MaterialApp(
            theme: ThemeData(
              primarySwatch: themeColor,
              appBarTheme: AppBarTheme(
                backgroundColor: themeColor,
                elevation: 4.0,
                shadowColor: Colors.black,
                iconTheme: const IconThemeData(color: Colors.white),
                titleTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            home: const HomeView(),
          );
        },
      ),
    );
  }
}

// الفنكشن الخاصة بالألوان
MaterialColor getThemeColor(String? condition) {
  if (condition == null) {
    return Colors.blue;
  }
  if ([
    'Sunny',
    'Clear',
  ].contains(condition)) {
    return Colors.orange;
  } else if ([
    'Partly cloudy',
    'Patchy rain possible',
    'Light rain',
    'Light drizzle',
    'Light rain shower',
  ].contains(condition)) {
    return Colors.lightBlue;
  } else if ([
    'Cloudy',
    'Overcast',
    'Mist',
    'Fog',
  ].contains(condition)) {
    return Colors.grey;
  } else if ([
    'Patchy snow possible',
    'Light snow',
    'Patchy light snow',
    'Light snow showers',
  ].contains(condition)) {
    return Colors.cyan;
  } else if ([
    'Blizzard',
    'Patchy heavy snow',
    'Heavy snow',
    'Moderate snow',
    'Moderate or heavy snow showers',
    'Moderate or heavy snow with thunder',
  ].contains(condition)) {
    return Colors.blueGrey;
  } else if ([
    'Thundery outbreaks possible',
    'Patchy light rain with thunder',
    'Moderate or heavy rain with thunder',
  ].contains(condition)) {
    return Colors.purple;
  } else if ([
    'Moderate rain',
    'Moderate rain at times',
    'Heavy rain',
    'Heavy rain at times',
    'Torrential rain shower',
  ].contains(condition)) {
    return Colors.indigo;
  } else if ([
    'Freezing fog',
    'Patchy freezing drizzle possible',
    'Freezing drizzle',
    'Light freezing rain',
    'Moderate or heavy freezing rain',
    'Heavy freezing drizzle',
  ].contains(condition)) {
    return Colors.teal;
  } else if ([
    'Patchy sleet possible',
    'Light sleet',
    'Moderate or heavy sleet',
    'Light sleet showers',
    'Moderate or heavy sleet showers',
  ].contains(condition)) {
    return Colors.deepPurple;
  } else if ([
    'Ice pellets',
    'Light showers of ice pellets',
    'Moderate or heavy showers of ice pellets',
  ].contains(condition)) {
    return Colors.brown;
  } else {
    return Colors.blue;
  }
}
