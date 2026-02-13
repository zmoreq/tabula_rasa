import 'city.dart';
import 'sim.dart';

class House {
  String name;
  final City city;
  int days;
  List<Sim> residents = [];
  int get population => residents.length;

  House({required this.name, required this.city, this.days = 0});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'city': city.name, // Zapisujemy tylko nazwę miasta
      'residents': residents.map((sim) => sim.toJson()).toList(),
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
      house.residents = residentsList.map((simJson) => Sim.fromJson(simJson, city, house)).toList();
    }
    return house;
  }

  void addResident(Sim sim) {
    residents.add(sim);
  }
  
  void removeResident(Sim sim) {
    residents.remove(sim);
  }
}