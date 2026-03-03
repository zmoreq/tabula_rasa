import 'house.dart';

class City {
  String name;
  
  List<House> houses = [];

  City({required this.name });

  int get population {
    return houses.fold(0, (sum, house) => sum + house.population);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'houses': houses.map((house) => house.toJson()).toList(),
    };
  }

  factory City.fromJson(Map<String, dynamic> json) {
    City parsedCity = City(
      name: json['name'] ?? "Nieznane miasto"
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