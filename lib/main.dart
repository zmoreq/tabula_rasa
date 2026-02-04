import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'util.dart';
import 'theme.dart';
import 'pages/cities_page.dart';

// 1. START: Tu system "włącza" aplikację.
void main() {
  runApp(const MyApp());
}

// 2. MyApp: Główny widget aplikacji.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //final brightness = View.of(context).platformDispatcher.platformBrightness;
    TextTheme textTheme = createTextTheme(context, 'Quicksand', 'Fredoka');
    MaterialTheme theme = MaterialTheme(textTheme);

    return MaterialApp(
      title: 'Simsly',
      theme: theme.light(),
      darkTheme: theme.dark(),
      themeMode: ThemeMode.dark, // Użyj trybu systemowego (jasny/ciemny)
      home: CitiesPage(),
    );
  }
}