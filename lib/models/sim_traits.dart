import 'package:flutter/material.dart';

class SimTraits {
  Color? eyeColor;
  Color? hairColor;
  String aspiration;
  String? zodiacSign;

  SimTraits({
    this.eyeColor,
    this.hairColor,
    this.aspiration = "Nieznana",
    this.zodiacSign,
  });

  // Zapisywanie do JSON
  Map<String, dynamic> toJson() {
    return {
      'eyeColor': eyeColor?.toARGB32(),
      'hairColor': hairColor?.toARGB32(),
      'aspiration': aspiration,
      'zodiacSign': zodiacSign,
    };
  }

  // Odczytywanie z JSON
  factory SimTraits.fromJson(Map<String, dynamic> json) {
    Color? parseColor(dynamic colorData) {
      if (colorData == null) return null; // Brak koloru
      
      if (colorData is int) {
        return Color(colorData); // IDEALNY SCENARIUSZ (Nowy kod)
      } 
      
      if (colorData is String) {
        // SCENARIUSZ BŁĘDU (Stary zapis). 
        // Zamiast wysadzać apkę (as int), po prostu resetujemy kolor na null.
        return null; 
      }
      
      return null;
    }
    return SimTraits(
      eyeColor: parseColor(json['eyeColor']),
      hairColor: parseColor(json['hairColor']),
      aspiration: json['aspiration'] ?? "Nieznana",
      zodiacSign: json['zodiacSign'],
    );
  }
}