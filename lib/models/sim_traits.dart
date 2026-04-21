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

  static const Map<String, Color> _colorMap = {
    'brown': Colors.brown,
    'blue': Colors.blue,
    'green': Colors.green,
    'grey': Colors.grey,
    'red': Colors.red,
    'black': Colors.black,
    'white': Colors.white,
    'orange': Colors.orange,
    'blond': Color(0xFFF9A825), // Colors.yellow.shade700
  };

  static String? _colorToString(Color? color) {
    if (color == null) return null;
    for (var entry in _colorMap.entries) {
      if (entry.value == color) return entry.key;
    }
    return null;
  }

  static Color? _stringToColor(dynamic value) {
    if (value == null) return null;
    if (value is String) return _colorMap[value];
    // fallback dla starych zapisów (int)
    if (value is num) {
      int colorInt = value.toInt();
      for (var entry in _colorMap.entries) {
        if (entry.value.toARGB32() == colorInt) return entry.value;
      }
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    return {
      'eyeColor': _colorToString(eyeColor),
      'hairColor': _colorToString(hairColor),
      'aspiration': aspiration,
      'zodiacSign': zodiacSign,
    };
  }

  factory SimTraits.fromJson(Map<String, dynamic> json) {
    return SimTraits(
      eyeColor: _stringToColor(json['eyeColor']),
      hairColor: _stringToColor(json['hairColor']),
      aspiration: json['aspiration'] ?? "Nieznana",
      zodiacSign: json['zodiacSign'],
    );
  }
}