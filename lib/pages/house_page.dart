import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart'; // Pamiętaj o imporcie!
import '../models/house.dart';
import 'stats_page.dart';
import 'generator_page.dart';
import 'diary_page.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/resident_tile.dart';
import '../models/resident.dart';

class HousePage extends StatefulWidget {
  final House house;
  String get houseName => house.name;

  HousePage({
    required this.house,
  });

  @override
  State<HousePage> createState() => _HousePageState();
}

class _HousePageState extends State<HousePage> {
  int _selectedIndex = 0;

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
        _addSampleResidents();
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

  void _addSampleResidents() {
    setState(() {
      widget.house.addResident(Resident(name: "Anna", lastName: "Nowak-Kowalska", age: 28, city: widget.house.city, house: widget.house));
      widget.house.addResident(Resident(name: "Jan", lastName: "Kowalski", age: 31, city: widget.house.city, house: widget.house));
      widget.house.addResident(Resident(name: "Piotr", lastName: "Kowalski", age: 14, city: widget.house.city, house: widget.house));
    });
  }

  Widget _buildHouseList() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
            bottom: 40,
            left: 20, 
            right: 20
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(32),
            ),
          ),
            child: Column(
              children: [
                Text(
                  widget.houseName,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 42,
                    letterSpacing: 5.0,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(
                        PhosphorIcons.minus(PhosphorIconsStyle.bold),
                        size: 26,
                        color: Theme.of(context).colorScheme.onPrimary),
                      style: IconButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.onPrimary.withValues(alpha: 0.15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      padding: EdgeInsets.all(12),
                      onPressed: () {
                        setState(() {
                          widget.house.decrementDays();
                        });
                      },
                    ),
                    Column(
                      children: [
                        Text(
                          "DZIEŃ",
                          style: GoogleFonts.quicksand(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3.0,
                            color: Theme.of(context).colorScheme.onPrimary.withValues(alpha: 0.8),
                          ),
                        ),
                        Text(
                          "${widget.house.days}",
                          style: GoogleFonts.quicksand(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(
                        PhosphorIcons.plus(PhosphorIconsStyle.bold),
                        size: 26,
                        color: Theme.of(context).colorScheme.onPrimary
                        ),
                      style: IconButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.onPrimary.withValues(alpha: 0.15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      padding: EdgeInsets.all(12),
                      onPressed: () {
                        setState(() {
                          widget.house.incrementDays();
                          for (var resident in widget.house.residents) {
                            resident.incrementDays();
                          }
                        });
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 20),
          for (var residentObject in widget.house.residents)
            ResidentTile(
              resident: residentObject,
              onTap: () {
                // Tu możesz dodać logikę do wyświetlania szczegółów mieszkańca
              },
              onDelete: () {
                setState(() {
                  widget.house.removeResident(residentObject);
                });
              },
            ),
           SizedBox(height: 80), // Ważne: Pusty odstęp na dole, żeby ostatni mieszkaniec nie chował się za czymś
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar może zostać pusty lub z ustawieniami
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        actions: [
          IconButton(
            icon: Icon(PhosphorIcons.gear(
              PhosphorIconsStyle.bold
            ), ),
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