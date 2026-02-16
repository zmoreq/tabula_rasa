import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart'; // Pamiętaj o imporcie!
import '../models/house.dart';
import '../models/city.dart';
import '../widgets/house_card.dart';
// import '../widgets/add_text_button.dart'; // To może być już niepotrzebne, skoro masz plusa na dole
import '../widgets/sims_bottom_nav.dart'; // Importuj swoją nową nawigację

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

  void _addHouse() {
    setState(() {
      widget.city.houses.add(
          House(name: "Dom ${widget.city.houses.length + 1}", city: widget.city));
    });
    // Opcjonalnie: Przełącz widok na listę domów po dodaniu
    setState(() {
      _selectedIndex = 0; 
    });
  }

  // Funkcja obsługująca kliknięcia w pasek
  void _onItemTapped(int index) {
    if (index == 2) {
      // --- LOGIKA ŚRODKOWEGO PRZYCISKU (PLUS) ---
      // Tutaj wywołujemy akcję zamiast zmiany strony
      _addHouse(); 
      // W przyszłości tu dasz: _showAddOptions(context);
    } else {
      // --- LOGIKA POZOSTAŁYCH PRZYCISKÓW ---
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  // To buduje wnętrze strony w zależności od wybranej zakładki
  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return _buildHouseList(); // Twój widok domów
      case 1:
        return Center(child: Text("Tutaj będą Statystyki"));
      case 3:
        return Center(child: Text("Tutaj będzie Generator"));
      case 4:
        return Center(child: Text("Tutaj będzie Kronika"));
      default:
        return _buildHouseList();
    }
  }

  // Wydzieliłem Twój stary widok do osobnej metody dla czystości
  Widget _buildHouseList() {
    return SingleChildScrollView( // Dodałem scrolla, żeby lista nie ucięła się na dole
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 20), // Odstęp od góry
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
            Divider(
              height: 60,
              thickness: 2,
              color: Theme.of(context).colorScheme.outline,
              indent: 25,
              endIndent: 25,
            ),
            // Usunąłem AddButton stąd, bo masz go teraz w pasku na dole!
            
            // Pętla wyświetlająca domy
            for (var houseObject in widget.city.houses)
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0), // Odstęp między kartami
                child: HouseCard(
                  house: houseObject,
                  onTap: () {
                    print("Tapped on ${houseObject.name}");
                  },
                  onDelete: () {
                    setState(() {
                      widget.city.houses.remove(houseObject);
                    });
                  },
                  onEdit: () {
                    print("Edit ${houseObject.name}");
                  },
                ),
              ),
             SizedBox(height: 80), // Ważne: Pusty odstęp na dole, żeby ostatni dom nie chował się za czymś
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar może zostać pusty lub z ustawieniami
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(PhosphorIcons.gear(
              PhosphorIconsStyle.bold
            )),
            onPressed: () {}, // Tu będą ustawienia
          )
        ],
      ),
      
      body: _buildBody(), // Wyświetlamy odpowiedni ekran

      // --- TUTAJ JEST TWOJA NOWA NAWIGACJA ---
      bottomNavigationBar: SimsBottomNav(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped, // Przekazujesz funkcję z CityPage
      ),
    );
  }
}