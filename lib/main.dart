import 'package:flutter/material.dart';
import 'package:translator_app/home_screen.dart';

void main() {
  runApp(const TranslatorApp());
}

class TranslatorApp extends StatelessWidget {
  const TranslatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
