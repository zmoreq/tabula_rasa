import 'house.dart';

class City {
  String name;
  final int population;

  List<House> houses = [];

  City({required this.name , required this.population});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'population': population,
      'houses': houses.map((house) => house.toJson()).toList(),
    };
  }

  factory City.fromJson(Map<String, dynamic> json) {
    City parsedCity = City(
      name: json['name'] ?? "Nieznane miasto", 
      population: json['population'] ?? 0,
    );

    // KROK 2: Ładujemy domy i przypisujemy je do tego jednego, konkretnego miasta
    if (json['houses'] != null) {
      parsedCity.houses = (json['houses'] as List<dynamic>)
          // Zauważ, że podajemy `parsedCity`, a nie tworzymy nowego City()!
          .map((houseJson) => House.fromJson(houseJson, parsedCity))
          .toList(); // .toList() gwarantuje nam otwartą, modyfikowalną listę
    }

    // Zwracamy poskładane miasto
    return parsedCity;
  }

  void addHouse(House house) {
    houses.add(house);
  }

  void removeHouse(House house) {
    houses.remove(house);
  }

}