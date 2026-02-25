import 'sim_traits.dart';
import 'city.dart';
import 'house.dart';

class Resident {
  String name;
  String lastName;

  int age;
  int days;

  final City city;
  final House house;

  SimTraits traits;

  Resident({
    required this.name,
    required this.lastName,
    required this.age,
    this.days = 0,
    required this.city,
    required this.house,
    SimTraits? traits,
  }) : traits = traits ?? SimTraits();

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'lastName': lastName,
      'age': age,
      'days': days,
      'city': city.name, // Zapisujemy tylko nazwę miasta
      'house': house.name,
      'traits': traits.toJson(),
    };
  }

  factory Resident.fromJson(Map<String, dynamic> json, City city, House house) {
    return Resident(
      name: json['name'],
      lastName: json['lastName'],
      age: json['age'],
      days: json['days'],
      city: city,
      house: house,
      traits: json['traits'] != null ? SimTraits.fromJson(json['traits']) : SimTraits(),
    );
  }

  bool isAdult() {
    return age >= 18;
  }

  void incrementDays() {
    days++;
    if (days == 4) {
      age++;
      days = 0;
    }
  }

  void decrementDays() {
    if (days > 0) {
      days--;
    } else if (age > 0) {
      age--;
      days = 3; // Cofamy do ostatniego dnia poprzedniego roku
    }
  }
}