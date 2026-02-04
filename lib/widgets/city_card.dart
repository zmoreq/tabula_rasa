import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/city.dart';

class CityCard extends StatelessWidget {
  final City city;
  final VoidCallback? onTap;

  CityCard({
    required this.city,
    this.onTap,
  });

void _showCityOptions(BuildContext context) {
  showModalBottomSheet(
    context: context,
    // Żeby panel miał zaokrąglone rogi na górze (jak Twoja karta)
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      // SafeArea sprawia, że panel nie wejdzie na pasek nawigacji (ten na dole iPhone'a)
      return SafeArea(
        child: Wrap( // Wrap dopasowuje wysokość do zawartości (nie zajmie całego ekranu)
          children: [
            // Opcja 1: Edycja
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edytuj nazwę'),
              onTap: () {
                Navigator.of(context).pop(); // Zamykamy panel
                print("Kliknięto Edytuj dla ${city.name}"); // Tu kiedyś będzie logika
              },
            ),
            
            // Opcja 2: Statystyki
            ListTile(
              leading: const Icon(Icons.bar_chart),
              title: const Text('Zobacz statystyki'),
              onTap: () {
                Navigator.of(context).pop();
                print("Kliknięto Statystyki dla ${city.name}");
              },
            ),

            // Opcja 3: Usuwanie (często daje się kolor czerwony)
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Usuń miasto', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.of(context).pop();
                print("Kliknięto Usuń dla ${city.name}");
              },
            ),
          ],
        ),
      );
    },
  );
}
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      height: 125,
      
      child: Card(
        color: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          splashColor: Colors.black.withAlpha(50),
          child: Column(
            children: [
              Expanded(
                child: Image.network(
                  'https://picsum.photos/400/200',
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              ),
              
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          city.name,
                          style: GoogleFonts.fredoka(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            letterSpacing: 5,
                            color: Theme.of(context).colorScheme.surface,
                        
                          )
                        ),
                        Container(
                          height: 1,
                          width: 225,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        )
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        _showCityOptions(context);
                      },
                      constraints: BoxConstraints(),
                      style: IconButton.styleFrom(
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap
                      ),
                      icon: Icon(
                        Icons.more_vert,
                        color: Theme.of(context).colorScheme.surface,
                        
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}