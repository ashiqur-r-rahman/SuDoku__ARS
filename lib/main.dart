import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/screens/home_screen.dart';
import 'package:myapp/models/sudoku_game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SudokuGame(),
      child: MaterialApp(
        title: 'Sudoku Game',
        theme: ThemeData(
          primaryColor: const Color(0xFFFFC0CB), // Baby Pink
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: const Color(0xFFF5F5F5), // Soft Gray
            onPrimary: const Color(0xFFFFFFFF), // White
            onSurface: const Color(0xFF333333), // Charcoal Gray
            surface: const Color(0xFF98FF98), // Mint Green for success/highlight
          ),
          textTheme: Theme.of(context).textTheme.apply(
            bodyColor: const Color(0xFF333333), // Charcoal Gray
            displayColor: const Color(0xFF333333), // Charcoal Gray
            fontFamily: GoogleFonts.getFont('Press Start 2P').fontFamily,
          ),
          scaffoldBackgroundColor: const Color(0xFFFFFFFF), // White
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFFFFC0CB), // Baby Pink
            foregroundColor: Color(0xFFFFFFFF), // White
          ),
          buttonTheme: ButtonThemeData(
            buttonColor: const Color(0xFFFFC0CB), // Baby Pink
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFC0CB), // Baby Pink
              foregroundColor: const Color(0xFFFFFFFF), // White
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
          cardTheme: CardThemeData(
            color: const Color(0xFFFFFFFF), // White
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: const Color(0xFFF5F5F5), // Soft Gray
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: Color(0xFFFFC0CB), width: 2.0),
            ),
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
