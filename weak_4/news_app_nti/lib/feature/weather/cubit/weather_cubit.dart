import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_nti/feature/weather/data/repo/weather_repo.dart';
import 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());
  WeatherRepo repo = WeatherRepo();
  Future<void> fetchWeather(double lat, double lon) async {
    emit(WeatherLoading());
    try {
      final weather = await repo.getWeather(lat: lat, lon: lon);
      if (weather != null) {
        emit(WeatherLoaded(weather));
      } else {
        emit(WeatherError("Failed to fetch weather data"));
      }
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }
}
