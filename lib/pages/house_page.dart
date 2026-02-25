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
import '../services/data_service.dart';
import '../widgets/resident_edit_dialog.dart';

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
        if (widget.house.population < widget.house.maxResidents) {
          _showAddResidentDialog();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Maksymalna liczba mieszkańców osiągnięta!")),
          );
        }
        
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

  Future<void> _showAddResidentDialog() async {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController lastNameController = TextEditingController();
    final TextEditingController ageController = TextEditingController();

    final Map<String, dynamic>? residentData = await showDialog<Map<String, dynamic>> (
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Dodaj nowego mieszkańca"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                autofocus: true,
                decoration: InputDecoration(labelText: "Imię"),
              ),
              TextField(
                controller: lastNameController,
                decoration: InputDecoration(labelText: "Nazwisko"),
              ),
              TextField(
                controller: ageController,
                decoration: InputDecoration(labelText: "Wiek"),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(null),
              child: Text("Anuluj"),
            ),
            ElevatedButton(
              onPressed: () {
                final name = nameController.text.trim();
                final lastName = lastNameController.text.trim();
                final age = int.tryParse(ageController.text.trim());

                if (name.isNotEmpty && lastName.isNotEmpty && age != null) {
                  Navigator.of(context).pop({
                    "name": name,
                    "lastName": lastName,
                    "age": age,
                  });
                }
                else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Nazwa mieszkańca, nazwisko i wiek są wymagane!",
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
              child: Text("Dodaj"),
            ),
          ],
        );
      }
    );

    Future.delayed(const Duration(milliseconds: 500), () {
      nameController.dispose();
      lastNameController.dispose();
      ageController.dispose();
    });

    if (residentData != null) {
      setState(() {
        widget.house.addResident(
          Resident(
            name: residentData["name"],
            lastName: residentData["lastName"],
            age: residentData["age"],
            city: widget.house.city,
            house: widget.house,
          ),
        );
      });
      DataService.saveData(); // Zapisz zmiany po dodaniu mieszkańca
    }
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
                          for (var resident in widget.house.residents) {
                            resident.decrementDays();
                          }
                        });
                        DataService.saveData(); // Zapisz zmiany po dekrementacji dni
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
                        DataService.saveData(); // Zapisz zmiany po inkrementacji dni
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 5),
          Text(
            "Residents (${widget.house.population} / 8)",
            style: GoogleFonts.quicksand(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              letterSpacing: 3.0,
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
              )
            ),
          SizedBox(height: 5),
          for (var residentObject in widget.house.residents)
            ResidentTile(
              resident: residentObject,
              onTap: () async {
                final bool? didSave = await showDialog<bool>(
                  context: context,
                  builder: (context) => ResidentEditDialog(resident: residentObject),
                );
                if (didSave == true) {
                  setState(() {});
                  DataService.saveData();
                }
              },
              onDelete: () {
                setState(() {
                  widget.house.removeResident(residentObject);
                });
                DataService.saveData(); // Zapisz zmiany po usunięciu mieszkańca
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