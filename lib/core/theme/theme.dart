import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff306a42),
      surfaceTint: Color(0xff306a42),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color.fromARGB(255, 217, 218, 217),
      onPrimaryContainer: Color(0xff15512c),
      secondary: Color(0xff506353),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffd2e8d3),
      onSecondaryContainer: Color.fromARGB(255, 255, 255, 255),
      tertiary: Color.fromARGB(255, 146, 182, 179),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color.fromARGB(255, 0, 150, 136),
      onTertiaryContainer: Color(0xff204d56),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfff6fbf3),
      onSurface: Color(0xff181d18),
      onSurfaceVariant: Color(0xff414941),
      outline: Color.fromARGB(255, 245, 245, 245),
      outlineVariant: Color(0xffc1c9bf),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d322d),
      inversePrimary: Color(0xff97d5a4),
      primaryFixed: Color.fromARGB(255, 255, 255, 255),
      onPrimaryFixed: Color(0xff00210d),
      primaryFixedDim: Color(0xff97d5a4),
      onPrimaryFixedVariant: Color(0xff15512c),
      secondaryFixed: Color(0xffd2e8d3),
      onSecondaryFixed: Color(0xff0d1f12),
      secondaryFixedDim: Color.fromARGB(255, 216, 141, 2),
      onSecondaryFixedVariant: Color(0xff384b3c),
      tertiaryFixed: Color(0xffbeeaf5),
      onTertiaryFixed: Color(0xff001f25),
      tertiaryFixedDim: Color(0xffa2ced9),
      onTertiaryFixedVariant: Color(0xff204d56),
      surfaceDim: Color(0xffd7dbd4),
      surfaceBright: Color(0xfff6fbf3),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff0f5ed),
      surfaceContainer: Color(0xffebefe7),
      surfaceContainerHigh: Color(0xffe5eae2),
      surfaceContainerHighest: Color(0xffdfe4dc),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff97d5a4),
      surfaceTint: Color(0xff97d5a4),
      onPrimary: Color.fromARGB(255, 36, 36, 36),
      primaryContainer: Color.fromARGB(255, 68, 68, 68),
      onPrimaryContainer: Color(0xffb3f1bf),
      secondary: Color(0xffb7ccb8),
      onSecondary: Color(0xff223526),
      secondaryContainer: Color(0xff384b3c),
      onSecondaryContainer: Color.fromARGB(255, 104, 104, 104),
      tertiary: Color.fromARGB(255, 153, 189, 186),
      onTertiary: Color(0xff01363f),
      tertiaryContainer: Color.fromARGB(255, 0, 128, 115),
      onTertiaryContainer: Color(0xffbeeaf5),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff101510),
      onSurface: Color(0xffdfe4dc),
      onSurfaceVariant: Color(0xffc1c9bf),
      outline: Color.fromARGB(255, 70, 70, 70),
      outlineVariant: Color(0xff414941),
      shadow: Color(0xff000000),
      scrim: Color.fromARGB(255, 255, 255, 255),
      inverseSurface: Color(0xffdfe4dc),
      inversePrimary: Color(0xff306a42),
      primaryFixed: Color.fromARGB(255, 255, 255, 255),
      onPrimaryFixed: Color(0xff00210d),
      primaryFixedDim: Color(0xff97d5a4),
      onPrimaryFixedVariant: Color(0xff15512c),
      secondaryFixed: Color(0xffd2e8d3),
      onSecondaryFixed: Color(0xff0d1f12),
      secondaryFixedDim: Color.fromARGB(255, 168, 110, 3),
      onSecondaryFixedVariant: Color(0xff384b3c),
      tertiaryFixed: Color(0xffbeeaf5),
      onTertiaryFixed: Color(0xff001f25),
      tertiaryFixedDim: Color(0xffa2ced9),
      onTertiaryFixedVariant: Color(0xff204d56),
      surfaceDim: Color(0xff101510),
      surfaceBright: Color(0xff353a35),
      surfaceContainerLowest: Color(0xff0a0f0b),
      surfaceContainerLow: Color(0xff181d18),
      surfaceContainer: Color(0xff1c211c),
      surfaceContainerHigh: Color(0xff262b26),
      surfaceContainerHighest: Color(0xff313631),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily dark;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.dark,
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
