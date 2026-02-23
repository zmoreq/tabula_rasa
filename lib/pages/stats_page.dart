import 'package:flutter/material.dart';
import '../models/city.dart';
import '../widgets/bottom_nav.dart';
import 'generator_page.dart';
import 'cities_page.dart';
import 'diary_page.dart';

class StatsPage extends StatefulWidget {
  final City? city; // Opcjonalne: jeśli null, pokazujemy staty globalne
  final bool isGlobal;
  final String returnRoute;

  const StatsPage({super.key, this.city, this.isGlobal = false, required this.returnRoute});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  
  void _onTapped(int index) {
    switch (index) {
      case 0:
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => CitiesPage()),
          (route) => false, // Usuwa wszystkie poprzednie strony z stosu
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
          return; // Pozwól na normalne zachowanie przycisku "wstecz"
        }
        if (widget.returnRoute == "/") {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => CitiesPage()),
            (route) => false, // Usuwa wszystkie poprzednie strony z stosu
          );
        } else {
          Navigator.of(context).popUntil(ModalRoute.withName(widget.returnRoute)); // Inaczej szukaj po etykiecie
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Statystyki")),
        body: Center(
          child: Text(widget.city != null 
              ? "Statystyki miasta: ${widget.city!.name}" 
              : "Statystyki Globalne"),
        ),
        // Navbar też tu dodajemy, żeby zachować ciągłość!
        bottomNavigationBar: CustomBottomNav(
          currentIndex: 1, // Bo to statystyki
          onTap: _onTapped, // Przekazujesz funkcję z StatsPage
        ),
      ),
    );
  }
}