import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SimsBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const SimsBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        labelTextStyle: WidgetStateProperty.all(GoogleFonts.quicksand(fontSize: 12)),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer, // lub surfaceContainer
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
        showSelectedLabels: true,
        showUnselectedLabels: false,
        // Trik wizualny: Jeśli wybrano Plusa (index 2), nie podświetlamy niczego innego
        currentIndex: currentIndex == 2 ? 0 : currentIndex, 
        onTap: onTap,
        items: [
          // 0. GŁÓWNA (Kontekstowa)
          BottomNavigationBarItem(
            icon: Icon(PhosphorIcons.house()),
            activeIcon: Icon(PhosphorIcons.house(PhosphorIconsStyle.bold)),
            label: 'Główna', // Możesz zmienić na "Miasto" lub "Dom" dynamicznie, jeśli chcesz
          ),
          // 1. STATYSTYKI
          BottomNavigationBarItem(
            icon: Icon(PhosphorIcons.chartBar()),
            activeIcon: Icon(PhosphorIcons.chartBar(PhosphorIconsStyle.bold)),
            label: 'Statystyki',
          ),
          // 2. PLUS (ŚRODEK)
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                PhosphorIcons.plus(PhosphorIconsStyle.bold), 
                color: Theme.of(context).colorScheme.onSecondaryContainer
              ),
            ),
            label: 'Dodaj',
          ),
          // 3. GENERATOR
          BottomNavigationBarItem(
            icon: Icon(PhosphorIcons.magicWand()),
            activeIcon: Icon(PhosphorIcons.magicWand(PhosphorIconsStyle.bold)),
            label: 'Generator',
          ),
          // 4. KRONIKA
          BottomNavigationBarItem(
            icon: Icon(PhosphorIcons.book()),
            activeIcon: Icon(PhosphorIcons.book(PhosphorIconsStyle.bold)),
            label: 'Kronika',
          ),
        ],
      ),
    );
  }
}