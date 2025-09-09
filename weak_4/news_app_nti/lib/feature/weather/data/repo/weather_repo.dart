import 'package:news_app_nti/core/network/api_responce.dart';
import 'package:news_app_nti/core/network/api_helper.dart';
import 'package:news_app_nti/feature/weather/data/model/weather_model.dart';

class WeatherRepo {
  final ApiHelper apiHelper = ApiHelper();

  WeatherRepo();

  Future<WeatherModel?> getWeather({
    required double lat,
    required double lon,
  }) async {
    try {
      ApiResponse response = await apiHelper.getRequest(
        endPoint: "https://api.openweathermap.org/data/2.5/weather",
        queryParameters: {
          "lat": lat,
          "lon": lon,
          "appid": "39ef56aa87e0f9d833e66cd9111de959",
          "units": "metric",
        },
        isFormData: false,
      );

      if (response.statusCode == 200 && response.data != null) {
        return WeatherModel.fromJson(response.data);
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      print("WeatherRepo Error: $e");
      return null;
    }
  }
}
