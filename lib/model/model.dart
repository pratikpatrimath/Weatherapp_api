class WeatherModel {
  final currentWeather;
  final hourlyWeather;
  WeatherModel(this.currentWeather, this.hourlyWeather);
  factory WeatherModel.fromJson(Map<String, dynamic> data) {
    final currentWeather = data['current_weather'] as Map<String, dynamic>;
    final hourlyWeather = data['hourly'] as Map<String, dynamic>;
    return WeatherModel(currentWeather, hourlyWeather);
  }
}

class CurrentWeather {
  final double temperature;
  final double windspeed;
  final double weathercode;
  final int winddirection;
  final int isDay;
  CurrentWeather(
      {required this.temperature,
      required this.windspeed,
      required this.weathercode,
      required this.winddirection,
      required this.isDay});

  factory CurrentWeather.fromJson(Map<String, dynamic> data) {
    final temperature = data['temperature_2m'] as double;
    final windspeed = data['windspeed_10m'] as double;
    final weathercode = data['weathercode'] as double;
    final winddirection = data['winddirection_10m'] as int;
    final isDay = data['isday'] as int;

    return CurrentWeather(
        temperature: temperature,
        windspeed: windspeed,
        weathercode: weathercode,
        winddirection: winddirection,
        isDay: isDay);
  }
}

class HourlyCast {
  final List<String> time;
  final List<double> temperature;
  HourlyCast({required this.time, required this.temperature});

  factory HourlyCast.fromJson(Map<String, dynamic> data) {
    final List<String> time = data['time'] as List<String>;
    final List<double> temperature = data['temperature_2m'] as List<double>;
    return HourlyCast(time: time, temperature: temperature);
  }
}
