import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../widgets/add_text_button.dart';
import '../widgets/city_card.dart';
import 'city_page.dart';
import '../models/city.dart';
import '../widgets/sims_bottom_nav.dart'; // Importuj swoją nową nawigację

class CitiesPage extends StatefulWidget {
  const CitiesPage({super.key});

  @override
  State<CitiesPage> createState() => _CitiesPageState();
}

class _CitiesPageState extends State<CitiesPage> {
  List<City> cities = [];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _onTapped(int index) {
    if (index == 2) {
      _showAddCityDialog(); // Otwórz dialog dodawania miasta po kliknięciu plusa
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
    // Inne przyciski mogą być nieaktywne lub mieć inne funkcje, jeśli chcesz
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return _buildCityList(context); // Twój widok domów
      case 1:
        return Center(child: Text("Tutaj będą Statystyki"));
      case 3:
        return Center(child: Text("Tutaj będzie Generator"));
      case 4:
        return Center(child: Text("Tutaj będzie Kronika"));
      default:
        return _buildCityList(context);
    }
  }
  
  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? citiesJson = prefs.getString('cities');
    if (citiesJson != null) {
      List<dynamic> citiesList = jsonDecode(citiesJson);
      setState(() {
        cities = citiesList.map((cityJson) => City.fromJson(cityJson)).toList();
      });
    }
  }

  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String citiesJson = jsonEncode(cities.map((city) => city.toJson()).toList());
    await prefs.setString('cities', citiesJson);
  }

  void _deleteCity(City cityToDelete) {
    setState(() {
      cities.remove(cityToDelete);
    });
    _saveData();
  }

  Future<void> _showEditCityDialog(City city) async {
    final TextEditingController nameController = TextEditingController(text: city.name);

    final String? updatedName = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edytuj nazwę miasta'),
          content: TextField(
            controller: nameController,
            autofocus: true,
            decoration: InputDecoration(hintText: 'Nazwa miasta'),
          ),
          actions: [
            TextButton(
              child: Text('Anuluj'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
              ),
              onPressed: () {
                Navigator.of(context).pop(nameController.text);
              },
              child: Text('Zapisz'),
            ),
          ],
        );
      },
    );

    if (updatedName != null && updatedName.isNotEmpty) {
      setState(() {
        city.name = updatedName;
      });
      _saveData(); // Zapisz od razu po edycji
    }
  }

  Future<void> _showAddCityDialog() async {
    final TextEditingController nameController = TextEditingController();

    final String? cityName = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Nazwij swoje miasto'),
          content: TextField(
            controller: nameController,
            autofocus: true,
            decoration: InputDecoration(hintText: 'Nazwa miasta'),
          ),
          actions: [
            TextButton(
              child: Text('Anuluj'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
              ),
              onPressed: () {
                Navigator.of(context).pop(nameController.text);
              },
              child: Text('Dodaj'),
            ),
          ],
        );
      },
    );

    if (cityName != null && cityName.isNotEmpty) {
      setState(() {
        cities.add(City(name: cityName, population: 0));
      });
      _saveData(); // Zapisz od razu po dodaniu nowego miasta
    }
  }

  @override
  Widget build(BuildContext context) {
    // SCAFFOLD: To "Rusztowanie". Daje Ci dach (AppBar), podłogę i miejsce na treść.
    return Scaffold(
      
      // --- GŁÓWNA ZAWARTOŚĆ (To Twoje płótno) ---
      body: _buildBody(),
      bottomNavigationBar: SimsBottomNav(
        currentIndex: _selectedIndex, // Na tej stronie zawsze podświetlony będzie pierwszy przycisk (Domy)
        onTap: _onTapped, // Przekazujesz funkcję obsługującą kliknięcia
      ),
    );
  }

  Widget _buildCityList(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        // Column układa rzeczy jeden pod drugim (pionowo)
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // Wyśrodkuj wszystko
          children: [
            
            // TU DODAJESZ SWOJE ELEMENTY (Dzieci Kolumny):
            SizedBox(height: 60),
      
            Text(
              "Simsly",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 48,
                letterSpacing: 5.0,
              )
            ),
      
            Text("Zarządzaj swoją Simsową populacją",
              style: GoogleFonts.quicksand(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
            
            Divider(
              height: 60,
              thickness: 2,
              color: Theme.of(context).colorScheme.outline,
              indent: 25,
              endIndent: 25,
            ),
      
            for (var cityObject in cities) ...[
              CityCard(city: cityObject, 
                onTap: () {
                  Navigator.of( context).push(
                    MaterialPageRoute(
                      builder: (context) => CityPage(city: cityObject,), 
                    ),
                  );
                },
                onDelete: () {
                  _deleteCity(cityObject);
                },
                onEdit: () {
                  // Przykładowa logika edycji - tutaj możesz dodać dialog do zmiany nazwy
                  _showEditCityDialog(cityObject);
                },
              ),
              SizedBox(height: 20),
            ],
          ],
        ),
      ),
    );
  }
}