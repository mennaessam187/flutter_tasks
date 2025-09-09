/*
{
    "coord": {
        "lon": 31.4799,
        "lat": 30.5878
    },
    "weather": [
        {
            "id": 800,
            "main": "Clear",
            "description": "clear sky",
            "icon": "01n"
        }
    ],
    "base": "stations",
    "main": {
        "temp": 25.32,
        "feels_like": 25.47,
        "temp_min": 25.32,
        "temp_max": 25.32,
        "pressure": 1007,
        "humidity": 60,
        "sea_level": 1007,
        "grnd_level": 1006
    },
    "visibility": 10000,
    "wind": {
        "speed": 1.99,
        "deg": 300,
        "gust": 2.4
    },
    "clouds": {
        "all": 0
    },
    "dt": 1756934341,
    "sys": {
        "country": "EG",
        "sunrise": 1756956746,
        "sunset": 1757002455
    },
    "timezone": 10800,
    "id": 359493,
    "name": "Zagazig",
    "cod": 200
}
*/
class WeatherModel {
  final String cityName;
  final double temp;
  final String description;
  final String icon;
  final double feelsLike;
  final String country;
  final String main1;
  final double windSpeed;
  final int pressure;
  final int humidity;
  final double lat;
  final double lon;
  WeatherModel({
    required this.cityName,
    required this.temp,
    required this.description,
    required this.icon,
    required this.country,
    required this.main1,
    required this.feelsLike,
    required this.windSpeed,
    required this.pressure,
    required this.humidity,
     required this.lat,
    required this.lon,
  });
  double get tempInFahrenheit => (temp * 9 / 5) + 32;
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json["name"],
      temp: (json["main"]["temp"] as num).toDouble(),
      description: json["weather"][0]["description"],
      main1: json["weather"][0]["main"],
      icon: json["weather"][0]["icon"],
      country: json["sys"]["country"],
      feelsLike: (json["main"]["feels_like"] as num).toDouble(),
      windSpeed: (json["wind"]["speed"] as num).toDouble(),
      pressure: json["main"]["pressure"],
      humidity: json["main"]["humidity"],
       lat: (json["coord"]["lat"] as num).toDouble(),
      lon: (json["coord"]["lon"] as num).toDouble(),
    );
  }
}
