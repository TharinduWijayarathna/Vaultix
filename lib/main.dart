import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/app_provider.dart';
import 'screens/main_screen.dart';
import 'screens/add_account_screen.dart';

void main() {
  runApp(const VaultixApp());
}

class VaultixApp extends StatelessWidget {
  const VaultixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MaterialApp(
        title: 'Vaultix - Money Management',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
          primaryColor: const Color(0xFF6C5CE7),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF6C5CE7),
            brightness: Brightness.light,
          ),
          fontFamily: 'SF Pro Display', // iOS-inspired font
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF6C5CE7),
            foregroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6C5CE7),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.grey[100],
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
          ),
          cardTheme: CardTheme(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: Colors.white,
          ),
        ),
        home: const MainScreen(),
        routes: {
          '/add-account': (context) => const AddAccountScreen(),
        },
      ),
    );
  }
}
