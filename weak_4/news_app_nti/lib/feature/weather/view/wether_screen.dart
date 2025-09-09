import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_app_nti/core/utils/colors.dart';
import 'package:news_app_nti/core/utils/icons.dart';
import 'package:news_app_nti/core/widget/elevation_button.dart';
import 'package:news_app_nti/core/widget/homeAppBar.dart';
import 'package:news_app_nti/core/widget/weatherColumn.dart';
import 'package:news_app_nti/feature/weather/cubit/weather_cubit.dart';
import 'package:news_app_nti/feature/weather/cubit/weather_state.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WeatherCubit()..fetchWeather(30.5877893, 31.4798788),
      child: SafeArea(
        child: Column(
          children: [
            Homeappbar(),
            SizedBox(height: 29),
            BlocBuilder<WeatherCubit, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is WeatherLoaded) {
                  return Padding(
                    padding: EdgeInsetsGeometry.only(left: 32, right: 32),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              state.weather.cityName,
                              style: const TextStyle(fontSize: 32),
                            ),
                            Text("-", style: const TextStyle(fontSize: 32)),
                            Text(
                              state.weather.country,
                              style: const TextStyle(fontSize: 32),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${state.weather.temp}",
                              style: const TextStyle(fontSize: 32),
                            ),
                            SvgPicture.asset(Appicons.sun),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              state.weather.main1,
                              style: const TextStyle(fontSize: 32),
                            ),
                            Text("-", style: const TextStyle(fontSize: 32)),
                            Text(
                              state.weather.description,
                              style: const TextStyle(fontSize: 32),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Feels like",
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColor.blacklightFontColor,
                              ),
                            ),
                            SizedBox(width: 3),
                            Text(
                              state.weather.feelsLike.toString(),
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColor.blacklightFontColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          height: 200,
                          child: GridView.count(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            childAspectRatio: 2,
                            crossAxisCount: 2,
                            children: [
                              Columnwe(
                                title: "Fahrenheit",
                                image: Appicons.foh,
                                //°
                                titlevalue:
                                    "${state.weather.tempInFahrenheit.toStringAsFixed(1)}°",
                              ),

                              Columnwe(
                                title: "Pressure",
                                image: Appicons.press,
                                titlevalue: "${state.weather.pressure} mp/h",
                              ),
                              Columnwe(
                                title: "UV Index",
                                image: Appicons.uv,
                                titlevalue: "0.2",
                              ),
                              Columnwe(
                                title: "Humidity",
                                image: Appicons.humidity,
                                titlevalue: "${state.weather.humidity}%",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (state is WeatherError) {
                  return Center(child: Text(state.message));
                }
                return const Center(
                  child: Text("Press button to fetch weather"),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 90, right: 90),
              child: MyElevatedButton(
                children: Row(
                  children: [
                    Text("Change Location"),
                    SizedBox(width: 5),
                    SvgPicture.asset(Appicons.location),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
