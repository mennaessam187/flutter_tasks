import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_nti/core/utils/colors.dart';
import 'package:news_app_nti/feature/Search/search_screen.dart';
import 'package:news_app_nti/feature/home/home_screen.dart';
import 'package:news_app_nti/feature/home/mainScreen.dart';
import 'package:news_app_nti/feature/news/cubit/newsCubit/news_cubit.dart';
import 'package:news_app_nti/feature/weather/cubit/weather_cubit.dart';
import 'package:news_app_nti/feature/welcome/view/splache_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NewsCubit()),
        BlocProvider(
          create: (context) =>
              WeatherCubit()..fetchWeather(30.5877893, 31.4798788),
        ),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColor.backgroundColor,
          fontFamily: 'Schibsted_Grotesk',
        ),
        home: SplacheScreen(),
        routes: {
          "search": (context) => SearchScreen(),
          "home": (context) => HomeScreen(),
          "mains": (context) => MainScreen(),
        },
      ),
    );
  }
}
