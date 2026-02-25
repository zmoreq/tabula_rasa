import 'city.dart';
import 'resident.dart';

class House {
  String name;
  final City city;
  int days;
  List<Resident> residents = [];
  int maxResidents = 8;
  int get population => residents.length;

  House({required this.name, required this.city, this.days = 0});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'city': city.name, // Zapisujemy tylko nazwę miasta
      'residents': residents.map((resident) => resident.toJson()).toList(),
      'days': days,
    };
  }

  factory House.fromJson(Map<String, dynamic> json, City city) {
    House house = House(
      name: json['name'],
      city: city,
      days: json['days'] ?? 0,
    );
    if (json['residents'] != null) {
      List<dynamic> residentsList = json['residents'];
      house.residents = residentsList.map((residentJson) => Resident.fromJson(residentJson, city, house)).toList();
    }
    return house;
  }

  void addResident(Resident resident) {
    residents.add(resident);
  }
  
  void removeResident(Resident resident) {
    residents.remove(resident);
  }

  List<Resident> getResidents() {
    return residents;
  }

  List<Resident> getResidentsByAge(int age) {
    return residents.where((resident) => resident.age == age).toList();
  }

  void incrementDays() {
    days++;
  }

  void decrementDays() {
    if (days > 0) {
      days--;
    }
  }

}