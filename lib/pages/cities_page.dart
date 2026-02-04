import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/add_button.dart';
import '../widgets/city_card.dart';
import 'city_page.dart';
import '../models/city.dart';

class CitiesPage extends StatefulWidget {
  const CitiesPage({super.key});

  @override
  State<CitiesPage> createState() => _CitiesPageState();
}

class _CitiesPageState extends State<CitiesPage> {
  List<City> cities = [
    City(name: "Płock", population: 52),
  ];
  
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
    }
  }

  @override
  Widget build(BuildContext context) {
    // SCAFFOLD: To "Rusztowanie". Daje Ci dach (AppBar), podłogę i miejsce na treść.
    return Scaffold(
      
      // --- GŁÓWNA ZAWARTOŚĆ (To Twoje płótno) ---
      body: SingleChildScrollView(
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
        
              AddButton(
                onPressed: () {
                  _showAddCityDialog(); 
                },
                label: "Dodaj nowe miasto",
              ),
        
              SizedBox(height: 30),
        
              for (var cityObject in cities) ...[
                CityCard(city: cityObject, 
                  onTap: () {
                    Navigator.of( context).push(
                      MaterialPageRoute(
                        builder: (context) => CityPage(cityName: cityObject.name),
                      ),
                    );
                  },
                ),
                SizedBox(height: 20),
              ],
            ],
          ),
        ),
      ),
    );
  }
}