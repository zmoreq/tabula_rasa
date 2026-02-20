import 'city.dart';
import 'house.dart';
class Resident {
  final String name;
  final String lastName;
  final int age;
  final City city;
  final House house;

  Resident({required this.name, required this.lastName, required this.age, required this.city, required this.house });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'lastName': lastName,
      'age': age,
      'city': city.name, // Zapisujemy tylko nazwę miasta
      'house': house.name, // Zapisujemy tylko nazwę domu
    };
  }

  factory Resident.fromJson(Map<String, dynamic> json, City city, House house) {
    return Resident(
      name: json['name'],
      lastName: json['lastName'],
      age: json['age'],
      city: city,
      house: house,
    );
  }
}