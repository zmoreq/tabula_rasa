import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namer_app/widgets/add_button.dart';
import '../models/house.dart';
import '../models/city.dart';
import '../widgets/house_card.dart';

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

  void _addHouse() {
    setState(() {
      widget.city.houses.add(House(name: "Dom ${widget.city.houses.length + 1}", city: widget.city));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(
        child: Column(
          children: [
              Text(
                widget.cityName,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 48,
                  letterSpacing: 5.0,
                )
              ),
        
              Text("Tutaj możesz zarządzać swoim miastem",
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

              AddButton(onPressed: _addHouse, label: "Dodaj nowy dom"),
              SizedBox(height: 20),
              for (var houseObject in widget.city.houses) 
                HouseCard(
                  house: houseObject,
                  onTap: () {
                    print("Tapped on ${houseObject.name} in ${widget.cityName}");
                  },
                  onDelete: () {
                    setState(() {
                      widget.city.houses.remove(houseObject);
                    });
                  },
                  onEdit: () {
                    print("Edit ${houseObject.name} in ${widget.cityName}");
                  },
                ),
          ],
        ),
      ),
    );
  }
}