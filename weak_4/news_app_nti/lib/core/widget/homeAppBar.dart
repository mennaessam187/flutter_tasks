import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_nti/core/utils/colors.dart';
import 'package:news_app_nti/feature/weather/cubit/weather_cubit.dart';
import 'package:news_app_nti/feature/weather/cubit/weather_state.dart';

class Homeappbar extends StatelessWidget {
  const Homeappbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColor.appbarbackground),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 32,
          right: 32,
          bottom: 10,
          top: 30,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Good Morning",
                  style: TextStyle(
                    color: AppColor.blacklightFontColor,
                    fontSize: 14,
                  ),
                ),
                Text(
                  "Menna Essam",
                  style: TextStyle(
                    color: AppColor.blacklightFontColor,
                    fontSize: 14,
                  ),
                ),
                Text(
                  "Sun 9 April, 2023",
                  style: TextStyle(
                    color: AppColor.blackFontColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            BlocBuilder<WeatherCubit, WeatherState>(
              builder: (context, state) {
                return state is WeatherLoaded
                    ? Row(
                        children: [
                          Icon(Icons.sunny, color: Colors.yellow[900]),
                          Row(
                            children: [
                              Text(
                                "${state.weather.description}",
                                style: TextStyle(
                                  color: AppColor.blacklightFontColor,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "${state.weather.temp.toString()}°",
                                style: TextStyle(
                                  color: AppColor.blacklightFontColor,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}
