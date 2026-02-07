import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/house.dart';

class HouseCard extends StatelessWidget {
  final House house;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  HouseCard({
    required this.house,
    required this.onTap,
    required this.onDelete,
    required this.onEdit,

  });

void _showOptions(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return SafeArea(
        child: Wrap(
          children: [

            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edytuj nazwę'),
              onTap: () {
                Navigator.of(context).pop();
                onEdit?.call();
              },
            ),
            
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Usuń dom', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.of(context).pop();
                onDelete?.call();
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
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).colorScheme.onSecondary,

      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon( Icons.home, size: 40, color: Theme.of(context).colorScheme.secondary),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(house.name, style: GoogleFonts.quicksand(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.secondary),
                  overflow: TextOverflow.ellipsis
                ),
                Divider(
                  height: 10,
                  thickness: 1,
                  endIndent: 150,
                ),
                Row(
                  children: [
                  Icon( Icons.people, size: 16, color: Theme.of(context).colorScheme.secondary),
                  SizedBox(width: 5),
                  Text("${house.population}", style: GoogleFonts.quicksand(fontSize: 14, color: Theme.of(context).colorScheme.secondary)),
                  
                  SizedBox(width: 20),

                  Icon(Icons.calendar_today, size: 16, color: Theme.of(context).colorScheme.secondary),
                  SizedBox(width: 5),
                  Text("${house.days}", style: GoogleFonts.quicksand(fontSize: 14, color: Theme.of(context).colorScheme.secondary)),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => _showOptions(context),
          ),
        ],
      )
    );
  }
}