import 'package:flutter/material.dart';
import '../models/city.dart';
import '../widgets/bottom_nav.dart';
import 'generator_page.dart';
import 'cities_page.dart';
import 'diary_page.dart';
import '../services/data_service.dart';

class StatsPage extends StatefulWidget {
  final City? city;
  final bool isGlobal;
  final String returnRoute;

  const StatsPage({super.key, this.city, this.isGlobal = false, required this.returnRoute});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {

  City? selectedCity;
  
  void _onTapped(int index) {
    switch (index) {
      case 0:
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => CitiesPage()),
          (route) => false,
        );
      case 1:
        break;
      case 2:
        break;
      case 3:
        Navigator.of(context).push(
           MaterialPageRoute(builder: (context) => GeneratorPage(returnRoute: widget.returnRoute)),
        );
      case 4:
        Navigator.of(context).push(
           MaterialPageRoute(builder: (context) => DiaryPage(returnRoute: widget.returnRoute)),
        );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (didPop) {
          return;
        }
        if (widget.returnRoute == "/") {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => CitiesPage()),
            (route) => false,
          );
        } else {
          Navigator.of(context).popUntil(ModalRoute.withName(widget.returnRoute)); // Inaczej szukaj po etykiecie
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Statystyki")),

        body: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  ChoiceChip(
                    label: Text("Wszystko"),
                    selected: selectedCity == null,
                    selectedColor: Theme.of(context).colorScheme.tertiaryContainer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelStyle: TextStyle(
                      color: selectedCity == null 
                          ? Theme.of(context).colorScheme.onTertiaryContainer 
                          : Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                    onSelected: (bool selected) {
                      setState(() {
                        selectedCity = null; // Resetujemy filtr
                      });
                    },
                  ),
                  SizedBox(width: 10),
                  
                  ...DataService.cities.map((city) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      
                      child: ChoiceChip(
                        label: Text(city.name),
                        selected: selectedCity == city,
                        selectedColor: Theme.of(context).colorScheme.tertiaryContainer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        labelStyle: TextStyle(
                          color: selectedCity == city 
                              ? Theme.of(context).colorScheme.onTertiaryContainer 
                              : Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                        onSelected: (bool selected) {
                          setState(() {
                            selectedCity = city; // Ustawiamy konkretne miasto
                          });
                        },
                      ),
                    );
                  }),
                ],
              )
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 130,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          "BRAK",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 130,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          "BRAK",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 130,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          "BRAK",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: CustomBottomNav(
          currentIndex: 1, // Bo to statystyki
          onTap: _onTapped, // Przekazujesz funkcję z StatsPage
        ),
      ),
    );
  }
}