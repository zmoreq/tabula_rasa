import 'package:flutter/material.dart';
import 'package:namer_app/services/stats_service.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../models/city.dart';
import '../widgets/bottom_nav.dart';
import 'generator_page.dart';
import 'cities_page.dart';
import 'diary_page.dart';
import '../services/data_service.dart';

import '../widgets/stat_box.dart';
import 'package:fl_chart/fl_chart.dart';

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

        body: Expanded(
          child: Column(
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
                              selectedCity = city;
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
                      child: StatBox(
                        label: "Populacja",
                        value: StatsService.getTotalPopulation(selectedCity: selectedCity).toString(),
                        icon: PhosphorIcons.users(PhosphorIconsStyle.bold),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: StatBox(
                        label: "Domy",
                        value: StatsService.getTotalHouses(selectedCity: selectedCity).toString(),
                        icon: PhosphorIcons.house(PhosphorIconsStyle.bold),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: StatBox(
                        label: "Średni wiek",
                        value: StatsService.getAverageAge(selectedCity: selectedCity).toString(),
                        icon: PhosphorIcons.calendar(PhosphorIconsStyle.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Więcej statystyk wkrótce!",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                )
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 250,
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // TEKST W ŚRODKU DZIURY
                                  Text(
                                    "Kolor oczu",
                                    style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onSurfaceVariant),
                                  ),
                                  // WYKRES DONUT
                                  PieChart(
                                    PieChartData(
                                      centerSpaceRadius: 50, // TO ROBI DZIURĘ! Im więcej, tym cieńszy pierścień
                                      sectionsSpace: 5, // Odstępy między kawałkami
                                      startDegreeOffset: 0, // Zaczynamy rysować od pionu
                                      sections: [
                                        PieChartSectionData(
                                          color: Colors.blue,
                                          value: StatsService.getEyeColorValueForChart(Colors.blue, selectedCity).toDouble(),
                                          title: StatsService.getEyeColorPercentageForChart(Colors.blue, selectedCity),
                                          radius: 35, // Grubość pierścienia
                                          titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                                        ),
                                        PieChartSectionData(
                                          color: Colors.brown,
                                          value: StatsService.getEyeColorValueForChart(Colors.brown, selectedCity).toDouble(),
                                          title: StatsService.getEyeColorPercentageForChart(Colors.brown, selectedCity),
                                          radius: 35,
                                          titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                                        ),
                                        PieChartSectionData(
                                          color: Colors.green,
                                          value: StatsService.getEyeColorValueForChart(Colors.green, selectedCity).toDouble(),
                                          title: StatsService.getEyeColorPercentageForChart(Colors.green, selectedCity),
                                          radius: 35,
                                          titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        height: 170,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            "Wykresy wkrótce!",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomNav(
          currentIndex: 1, // Bo to statystyki
          onTap: _onTapped, // Przekazujesz funkcję z StatsPage
        ),
      ),
    );
  }
}