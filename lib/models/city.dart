import 'sim.dart';

class City {
  final String name;
  final int population;

  List<Sim> residents = [];

  City({required this.name , required this.population});

  void addResident(Sim sim) {
    residents.add(sim);
  }
}