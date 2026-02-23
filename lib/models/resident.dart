import 'city.dart';
import 'house.dart';

class Resident {
  final String name;
  final String lastName;

  int age;
  int days;

  final City city;
  final House house;
  final String aspiration;

  Resident({required this.name, required this.lastName, required this.age, this.days = 0, required this.city, required this.house, this.aspiration = "Nieznana"});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'lastName': lastName,
      'age': age,
      'days': days,
      'city': city.name, // Zapisujemy tylko nazwę miasta
      'house': house.name, // Zapisujemy tylko nazwę domu
      'aspiration': aspiration,
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
      aspiration: json['aspiration'],
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
}