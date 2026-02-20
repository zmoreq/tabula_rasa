import 'package:flutter/material.dart';
import '../models/city.dart';
import '../widgets/bottom_nav.dart';
import 'diary_page.dart';
import 'stats_page.dart';
import 'cities_page.dart';

class GeneratorPage extends StatefulWidget {
  final City? city; // Opcjonalne: jeśli null, pokazujemy staty globalne
  final bool isGlobal;
  final String returnRoute;

  const GeneratorPage({super.key, this.city, this.isGlobal = false, required this.returnRoute});

  @override
  State<GeneratorPage> createState() => _GeneratorPageState();
}

class _GeneratorPageState extends State<GeneratorPage> {
  
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
        break;
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
        Navigator.of(context).popUntil(ModalRoute.withName(widget.returnRoute));
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Generator")),
        body: Center(
          child: Text(widget.city != null 
              ? "Generator miasta: ${widget.city!.name}" 
              : "Generator Globalny"),
        ),
        // Navbar też tu dodajemy, żeby zachować ciągłość!
        bottomNavigationBar: CustomBottomNav(
          currentIndex: 3, // Bo to generator
          onTap: _onTapped,
        ),
      ),
    );
  }
}