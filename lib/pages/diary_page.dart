import 'package:flutter/material.dart';
import '../models/city.dart';
import '../widgets/bottom_nav.dart';
import 'generator_page.dart';
import 'stats_page.dart';
import 'cities_page.dart';

class DiaryPage extends StatefulWidget {
  final City? city; // Opcjonalne: jeśli null, pokazujemy staty globalne
  final bool isGlobal;
  final String returnRoute;

  const DiaryPage({super.key, this.city, this.isGlobal = false, required this.returnRoute});

  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {

  

  void _onTapped(int index) {
    switch (index) {
      case 0:
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => CitiesPage()),
          (route) => false, // Usuwa wszystkie poprzednie strony z stosu
        );
      case 1:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => StatsPage(isGlobal: true, returnRoute: widget.returnRoute),
          ),
        );
      case 2:
        break;
      case 3:
        Navigator.of(context).push(
           MaterialPageRoute(builder: (context) => GeneratorPage(returnRoute: widget.returnRoute)),
        );
      case 4:
        break;
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
        Navigator.of(context).popUntil(ModalRoute.withName(widget.returnRoute));
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Kronika")),
        body: Center(
          child: Text(widget.city != null 
              ? "Kronika miasta: ${widget.city!.name}" 
              : "Kronika Globalna"),
        ),
        // Navbar też tu dodajemy, żeby zachować ciągłość!
        bottomNavigationBar: CustomBottomNav(
          currentIndex: 4, // Bo to kronika
          onTap: _onTapped, // Przekazujesz funkcję z DiaryPage
        ),
      ),
    );
  }
}