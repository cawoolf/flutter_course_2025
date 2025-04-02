import 'package:expense_tracker/expenses.dart';
import 'package:flutter/material.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 96, 59, 181));

var kDarkColorScheme = ColorScheme.fromSeed(
    seedColor: Color.fromARGB(255, 5, 99, 125), brightness: Brightness.dark);

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations( // Locks the app orientation to Portrait Mode
  //   [DeviceOrientation.portraitUp],
  // ).then((fn){
  //   _runApp();
  _runApp();
}

void _runApp() {
  runApp(MaterialApp(
    darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        cardTheme: _darkCardTheme,
        elevatedButtonTheme: _darkElevatedButtonThemeData),
    theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: _appBarTheme,
        cardTheme: _cardTheme,
        elevatedButtonTheme: _elevatedButtonThemeData,
        textTheme: _textTheme),
    themeMode: ThemeMode.system,
    home: const Expenses(),
  ));
}

TextTheme get _textTheme =>
ThemeData().textTheme.copyWith(
      titleLarge: TextStyle(
          fontWeight: FontWeight.bold,
          color: kColorScheme.onSecondaryContainer,
          fontSize:
              16) // Title large is usually the title for appBars and other widgets
      );


AppBarTheme get _appBarTheme => const AppBarTheme().copyWith(
      backgroundColor: kColorScheme.onPrimaryContainer,
      foregroundColor: kColorScheme
          .primaryContainer); // Normally overrides any text color in the appBar

ElevatedButtonThemeData get _elevatedButtonThemeData => ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        backgroundColor: kColorScheme.primaryContainer));

ElevatedButtonThemeData
    get _darkElevatedButtonThemeData => ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer,
        foregroundColor: kDarkColorScheme.onPrimaryContainer));

CardTheme get _cardTheme => CardTheme().copyWith(
    color: kColorScheme.secondaryContainer,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8));

CardTheme get _darkCardTheme => CardTheme().copyWith(
    color: kDarkColorScheme.secondaryContainer,
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8));

// Notes
/* Using ThemeData().copyWith() preservers some of the Flutter default themes. Allows individual aspects to be configured.
colorScheme: is applied to several different widgets. Easy way to theme the app

Selective overrides of theme elements is the way to go.

k before variable name means it's global

use .styleFrom() as a .copyWith() technique for Buttons

fromSeed() is optimized for light mode by default
*/
