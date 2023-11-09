class Weather {
  Weather({
    required this.cityname,
    required this.maincondition,
    required this.temprature,
  });

  factory Weather.fromJson(Map<dynamic, dynamic> json) {
    return Weather(
      cityname: json['name'],
      maincondition: json['weather'][0]['main'],
      temprature: json['main']['temp'],
    );
  }

  final String cityname;
  final String maincondition;
  final double temprature;
}
