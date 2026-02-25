import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/city.dart';

class DataService {
  static List<City> cities = [];

  static Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? citiesJson = prefs.getString('cities');
    if (citiesJson != null) {
      List<dynamic> citiesList = jsonDecode(citiesJson);
      cities = citiesList.map((cityJson) => City.fromJson(cityJson)).toList();
    }
  }

  static Future<void> saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String citiesJson = jsonEncode(cities.map((city) => city.toJson()).toList());
    await prefs.setString('cities', citiesJson);
  }
}