
import 'house.dart';

class City {
  String name;
  final int population;

  List<House> houses = [];

  City({required this.name , required this.population, this.houses = const []});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'population': population,
      'houses': houses.map((house) => house.toJson()).toList(),
    };
  }

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      name: json['name'],
      population: json['population'],
      houses: (json['houses'] as List<dynamic>).map((houseJson) => House.fromJson(houseJson, City(name: json['name'], population: json['population']))).toList(),
    );
  }

}