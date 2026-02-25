import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../models/house.dart';
import '../models/city.dart';
import '../widgets/house_card.dart';
import 'stats_page.dart';
import 'generator_page.dart';
import 'diary_page.dart';
import '../widgets/bottom_nav.dart'; // Importuj swoją nową nawigację
import 'house_page.dart';

class CityPage extends StatefulWidget {
  final City city;
  String get cityName => city.name;

  CityPage({
    required this.city,
  });

  @override
  State<CityPage> createState() => _CityPageState();
}

class _CityPageState extends State<CityPage> {
  int _selectedIndex = 0; // 0: Domy, 1: Staty, 2: Plus, 3: Generator, 4: Kronika

  void _onTapped(int index) {
    switch (index) {
      case 0:
        Navigator.of(context).popUntil((route) => route.isFirst);
      case 1:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => StatsPage(isGlobal: true, returnRoute: "/city"),
          ),
        );
      case 2:
        _showAddHouseDialog();
      case 3:
        Navigator.of(context).push(
           MaterialPageRoute(builder: (context) => GeneratorPage(returnRoute: "/city")),
        );
      case 4:
        Navigator.of(context).push(
           MaterialPageRoute(builder: (context) => DiaryPage(returnRoute: "/city")),
        );
    }
  }

    Future<void> _showAddHouseDialog() async {
      final TextEditingController nameController = TextEditingController();

      final String? houseName = await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Dodaj nowy dom"),
            content: TextField(
              controller: nameController,
              autofocus: true,
              decoration: InputDecoration(labelText: "Nazwa domu"),
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
                        "Nazwa domu nie może być pusta!",
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
        }
      );

      Future.delayed(const Duration(milliseconds: 500), () {
        nameController.dispose();
      });

      if (houseName != null && houseName.trim().isNotEmpty) {
        setState(() {
          widget.city.addHouse(House(name: houseName, city: widget.city));
        });
      }
    }
    
  Widget _buildHouseList() {
    return SingleChildScrollView( // Dodałem scrolla, żeby lista nie ucięła się na dole
      child: Column(
        children: [
          Container(
            width: double.infinity, // 1. Rozciągnij na całą szerokość
          padding: EdgeInsets.only(
            top: 20, 
            bottom: 40, // Dużo miejsca na dole, żeby zaokrąglenie ładnie wyglądało
            left: 20, 
            right: 20
          ),
          decoration: BoxDecoration(
            // 2. Kolor tła (np. surfaceContainerHigh albo primaryContainer)
            color: Theme.of(context).colorScheme.onPrimary,
            // 3. Zaokrąglenie TYLKO na dole
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(32),
            ),
          ),
            child: Column(
              children: [
                Text(
                  widget.cityName,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 48,
                        letterSpacing: 5.0,
                      ),
                ),
                Text(
                  "Tutaj możesz zarządzać swoim miastem",
                  style: GoogleFonts.quicksand(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          // Pętla wyświetlająca domy
          for (var houseObject in widget.city.houses)
            HouseCard(
              house: houseObject,
              onTap: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => HousePage(house: houseObject),
                    settings: RouteSettings(name: "/house"), // Ustawiamy nazwę trasy na unikalną dla tego domu 
                  ),
                );

                setState(() {}); // Odświeżamy widok po powrocie z HousePage, żeby pokazać ewentualne zmiany
              },
              onDelete: () {
                setState(() {
                  widget.city.removeHouse(houseObject);
                });
              },
              onEdit: () {
                print("Edit ${houseObject.name}");
              },
            ),
           SizedBox(height: 80), // Ważne: Pusty odstęp na dole, żeby ostatni dom nie chował się za czymś
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar może zostać pusty lub z ustawieniami
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        actions: [
          IconButton(
            icon: Icon(PhosphorIcons.gear(
              PhosphorIconsStyle.bold
            )),
            onPressed: () {}, // Tu będą ustawienia
          )
        ],
      ),
      
      body: _buildHouseList(), // Wyświetlamy odpowiedni ekran

      // --- TUTAJ JEST TWOJA NOWA NAWIGACJA ---
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _selectedIndex,
        onTap: _onTapped, // Przekazujesz funkcję z CityPage
      ),
    );
  }
}