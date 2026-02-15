import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/house.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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
              leading: Icon(PhosphorIcons.pencil()),
              title: const Text('Edytuj nazwę'),
              onTap: () {
                Navigator.of(context).pop();
                onEdit?.call();
              },
            ),
            
            ListTile(
              leading: Icon(PhosphorIcons.trash(), color: Colors.red),
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Ink(
        height: 85,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).colorScheme.onSecondary,
      
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 10),
                child: Icon( PhosphorIcons.house(
                  PhosphorIconsStyle.bold
                ), size: 43, color: Theme.of(context).colorScheme.primary),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Transform.translate(
                      offset: Offset(-3, 0),
                      child: Text(house.name, style: GoogleFonts.fredoka(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 5.0,
                        color: Theme.of(context).colorScheme.onSecondaryContainer),
                        overflow: TextOverflow.ellipsis
                      ),
                    ),
                    Divider(
                      height: 7,
                      thickness: 2,
                      endIndent: 10,
                      color: Theme.of(context).colorScheme.surfaceTint,
                    ),
                    SizedBox(height: 3),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                      Icon( PhosphorIcons.diamond(PhosphorIconsStyle.bold), size: 19, color: Theme.of(context).colorScheme.primary),
                      SizedBox(width: 10),
                      Text("${house.population}", style: GoogleFonts.fredoka(fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 2, color: Theme.of(context).colorScheme.onSecondaryContainer)),
                      
                      SizedBox(width: 35),
                
                      Icon(PhosphorIcons.clock(PhosphorIconsStyle.bold), size: 19, color: Theme.of(context).colorScheme.primary),
                      SizedBox(width: 10),
                      Text("${house.days}", style: GoogleFonts.fredoka(fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 2, color: Theme.of(context).colorScheme.onSecondaryContainer)),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(PhosphorIcons.dotsThreeVertical(
                  PhosphorIconsStyle.bold
                ), size: 32, color: Theme.of(context).colorScheme.secondary),
                onPressed: () => _showOptions(context),
              ),
            ],
          ),
        )
      ),
    );
  }
}