import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/city_card.dart';
import 'city_page.dart';
import '../models/city.dart';
import '../widgets/bottom_nav.dart';
import 'stats_page.dart';
import 'generator_page.dart';
import 'diary_page.dart';
import '../services/data_service.dart';


class CitiesPage extends StatefulWidget {
  const CitiesPage({super.key});

  @override
  State<CitiesPage> createState() => _CitiesPageState();
}

class _CitiesPageState extends State<CitiesPage> {

  @override
  void initState() {
    super.initState();
    DataService.loadData().then((_) {
      setState(() {});
    });
  }

  void _onTapped(int index) {
    switch (index) {
      case 0:
        break;
      case 1:
        Navigator.of(context).push(
          MaterialPageRoute(
            
            builder: (context) => StatsPage(isGlobal: true, returnRoute: "/"),
          ),
        );
      case 2:
        _showAddCityDialog();
      case 3:
        Navigator.of(context).push(
           MaterialPageRoute(builder: (context) => GeneratorPage(returnRoute: "/")),
        );
      case 4:
        Navigator.of(context).push(
           MaterialPageRoute(builder: (context) => DiaryPage(returnRoute: "/")),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildCityList(context), // Po prostu wyświetlamy listę, bez switcha!
      bottomNavigationBar: CustomBottomNav(
        currentIndex: 0, // Tu zawsze jesteśmy na "0" (Główna)
        onTap: _onTapped,
      ),
    );
  }
  


  void _deleteCity(City cityToDelete) {
    setState(() {
      DataService.cities.remove(cityToDelete);
    });
    DataService.saveData(); // Zapisz zmiany po usunięciu miasta
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
      DataService.saveData(); // Zapisz od razu po edycji
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
            decoration: InputDecoration(labelText: 'Nazwa miasta'),
          ),
          actions: [
            TextButton(
              child: Text('Anuluj'),
              onPressed: () {
                Navigator.of(context).pop(null);
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
              ),
              onPressed: () {
                final input = nameController.text.trim();
                if (input.isNotEmpty) {
                  Navigator.of(context).pop(input);
                }
                else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Nazwa miasta nie może być pusta!",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onError,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      backgroundColor: Theme.of(context).colorScheme.error,
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                }
              },
              child: Text('Dodaj'),
            ),
          ],
        );
      },
    );
    
    Future.delayed(const Duration(milliseconds: 500), () {
      nameController.dispose();
    });

    if (cityName != null && cityName.isNotEmpty) {
      setState(() {
        DataService.cities.add(City(name: cityName, population: 0));
      });
      DataService.saveData(); // Zapisz od razu po dodaniu nowego miasta
    }
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
      
            for (var cityObject in DataService.cities) ...[
              CityCard(city: cityObject, 
                onTap: () {
                  Navigator.of( context).push(
                    MaterialPageRoute(
                      builder: (context) => CityPage(city: cityObject),
                      settings: RouteSettings(name: "/city"), // Ustawiamy nazwę trasy na unikalną dla tego miasta 
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