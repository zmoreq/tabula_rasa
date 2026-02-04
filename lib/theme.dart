import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff615690),
      surfaceTint: Color(0xff615690),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffe7deff),
      onPrimaryContainer: Color(0xff493e76),
      secondary: Color(0xff605b71),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffe6dff9),
      onSecondaryContainer: Color(0xff484458),
      tertiary: Color(0xff7c5263),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffffd9e5),
      onTertiaryContainer: Color(0xff623b4b),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffdf8ff),
      onSurface: Color(0xff1c1b20),
      onSurfaceVariant: Color(0xff48454e),
      outline: Color(0xff79757f),
      outlineVariant: Color(0xffc9c4cf),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff312f36),
      inversePrimary: Color(0xffcbbeff),
      primaryFixed: Color(0xffe7deff),
      onPrimaryFixed: Color(0xff1d1148),
      primaryFixedDim: Color(0xffcbbeff),
      onPrimaryFixedVariant: Color(0xff493e76),
      secondaryFixed: Color(0xffe6dff9),
      onSecondaryFixed: Color(0xff1d192b),
      secondaryFixedDim: Color(0xffcac3dc),
      onSecondaryFixedVariant: Color(0xff484458),
      tertiaryFixed: Color(0xffffd9e5),
      onTertiaryFixed: Color(0xff30111f),
      tertiaryFixedDim: Color(0xffeeb8cb),
      onTertiaryFixedVariant: Color(0xff623b4b),
      surfaceDim: Color(0xffddd8e0),
      surfaceBright: Color(0xfffdf8ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff7f2fa),
      surfaceContainer: Color(0xfff1ecf4),
      surfaceContainerHigh: Color(0xffece6ee),
      surfaceContainerHighest: Color(0xffe6e1e9),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff382d64),
      surfaceTint: Color(0xff615690),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff7065a0),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff383347),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff6f6a80),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff4f2b3a),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff8d6071),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffdf8ff),
      onSurface: Color(0xff121016),
      onSurfaceVariant: Color(0xff37353e),
      outline: Color(0xff54515a),
      outlineVariant: Color(0xff6f6b75),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff312f36),
      inversePrimary: Color(0xffcbbeff),
      primaryFixed: Color(0xff7065a0),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff584d86),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff6f6a80),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff575267),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff8d6071),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff724959),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc9c5cd),
      surfaceBright: Color(0xfffdf8ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff7f2fa),
      surfaceContainer: Color(0xffece6ee),
      surfaceContainerHigh: Color(0xffe0dbe3),
      surfaceContainerHighest: Color(0xffd5d0d8),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff2e235a),
      surfaceTint: Color(0xff615690),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff4c4179),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff2d2a3d),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff4b465b),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff442130),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff653d4d),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffdf8ff),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff2d2b33),
      outlineVariant: Color(0xff4a4851),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff312f36),
      inversePrimary: Color(0xffcbbeff),
      primaryFixed: Color(0xff4c4179),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff352a61),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff4b465b),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff343043),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff653d4d),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff4b2737),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffbbb7bf),
      surfaceBright: Color(0xfffdf8ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff4eff7),
      surfaceContainer: Color(0xffe6e1e9),
      surfaceContainerHigh: Color(0xffd7d3db),
      surfaceContainerHighest: Color(0xffc9c5cd),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffcbbeff),
      surfaceTint: Color(0xffcbbeff),
      onPrimary: Color(0xff33285e),
      primaryContainer: Color(0xff493e76),
      onPrimaryContainer: Color(0xffe7deff),
      secondary: Color(0xffcac3dc),
      onSecondary: Color(0xff322e41),
      secondaryContainer: Color(0xff484458),
      onSecondaryContainer: Color(0xffe6dff9),
      tertiary: Color(0xffeeb8cb),
      onTertiary: Color(0xff492534),
      tertiaryContainer: Color(0xff623b4b),
      onTertiaryContainer: Color(0xffffd9e5),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff141318),
      onSurface: Color(0xffe6e1e9),
      onSurfaceVariant: Color(0xffc9c4cf),
      outline: Color(0xff938f99),
      outlineVariant: Color(0xff48454e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe6e1e9),
      inversePrimary: Color(0xff615690),
      primaryFixed: Color(0xffe7deff),
      onPrimaryFixed: Color(0xff1d1148),
      primaryFixedDim: Color(0xffcbbeff),
      onPrimaryFixedVariant: Color(0xff493e76),
      secondaryFixed: Color(0xffe6dff9),
      onSecondaryFixed: Color(0xff1d192b),
      secondaryFixedDim: Color(0xffcac3dc),
      onSecondaryFixedVariant: Color(0xff484458),
      tertiaryFixed: Color(0xffffd9e5),
      onTertiaryFixed: Color(0xff30111f),
      tertiaryFixedDim: Color(0xffeeb8cb),
      onTertiaryFixedVariant: Color(0xff623b4b),
      surfaceDim: Color(0xff141318),
      surfaceBright: Color(0xff3a383e),
      surfaceContainerLowest: Color(0xff0f0d13),
      surfaceContainerLow: Color(0xff1c1b20),
      surfaceContainer: Color(0xff201f24),
      surfaceContainerHigh: Color(0xff2b292f),
      surfaceContainerHighest: Color(0xff36343a),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffe1d7ff),
      surfaceTint: Color(0xffcbbeff),
      onPrimary: Color(0xff281c53),
      primaryContainer: Color(0xff9588c6),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffe0d9f2),
      onSecondary: Color(0xff272336),
      secondaryContainer: Color(0xff938da5),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffffd0e0),
      onTertiary: Color(0xff3c1b29),
      tertiaryContainer: Color(0xffb48395),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff141318),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffe0dae5),
      outline: Color(0xffb5b0bb),
      outlineVariant: Color(0xff938f99),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe6e1e9),
      inversePrimary: Color(0xff4b4078),
      primaryFixed: Color(0xffe7deff),
      onPrimaryFixed: Color(0xff13043e),
      primaryFixedDim: Color(0xffcbbeff),
      onPrimaryFixedVariant: Color(0xff382d64),
      secondaryFixed: Color(0xffe6dff9),
      onSecondaryFixed: Color(0xff120f20),
      secondaryFixedDim: Color(0xffcac3dc),
      onSecondaryFixedVariant: Color(0xff383347),
      tertiaryFixed: Color(0xffffd9e5),
      onTertiaryFixed: Color(0xff240615),
      tertiaryFixedDim: Color(0xffeeb8cb),
      onTertiaryFixedVariant: Color(0xff4f2b3a),
      surfaceDim: Color(0xff141318),
      surfaceBright: Color(0xff46434a),
      surfaceContainerLowest: Color(0xff08070c),
      surfaceContainerLow: Color(0xff1e1d22),
      surfaceContainer: Color(0xff29272d),
      surfaceContainerHigh: Color(0xff343238),
      surfaceContainerHighest: Color(0xff3f3d43),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfff4edff),
      surfaceTint: Color(0xffcbbeff),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffc7bafb),
      onPrimaryContainer: Color(0xff0c0035),
      secondary: Color(0xfff4edff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffc6bfd8),
      onSecondaryContainer: Color(0xff0c091a),
      tertiary: Color(0xffffebf0),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffe9b4c7),
      onTertiaryContainer: Color(0xff1c020e),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff141318),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xfff4eef9),
      outlineVariant: Color(0xffc6c1cc),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe6e1e9),
      inversePrimary: Color(0xff4b4078),
      primaryFixed: Color(0xffe7deff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffcbbeff),
      onPrimaryFixedVariant: Color(0xff13043e),
      secondaryFixed: Color(0xffe6dff9),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffcac3dc),
      onSecondaryFixedVariant: Color(0xff120f20),
      tertiaryFixed: Color(0xffffd9e5),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffeeb8cb),
      onTertiaryFixedVariant: Color(0xff240615),
      surfaceDim: Color(0xff141318),
      surfaceBright: Color(0xff514f56),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff201f24),
      surfaceContainer: Color(0xff312f36),
      surfaceContainerHigh: Color(0xff3c3a41),
      surfaceContainerHighest: Color(0xff48464c),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.surface,
     canvasColor: colorScheme.surface,

     filledButtonTheme: FilledButtonThemeData(
       style: FilledButton.styleFrom(
         backgroundColor: colorScheme.tertiaryContainer,
         foregroundColor: colorScheme.onTertiaryContainer,
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(24),
         ),
         textStyle: GoogleFonts.fredoka(
           fontSize: 20,
           fontWeight: FontWeight.normal,
         ),
         iconSize: 26
       ),
     ),
     iconTheme: IconThemeData(
       size: 26
     ),
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
