import 'package:flutter/material.dart';

import '/presentation/screens/detect_screen/detect_language_screen.dart';
import '/presentation/screens/translate_screen/translate_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// It handles the navigation through tabs
  int _currentIndex = 0;

  ///List of Screens that will be visible as body
  ///depending on the _currentIndex
  final List<Widget> _pages = const [
    TranslateScreen(),
    DetectScreen(),
  ];

  final List<BottomNavigationBarItem> _bottomNavigationBarItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.translate),
      label: "Translate",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.language),
      label: "Detect language",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) => setState(() => _currentIndex = value),
        currentIndex: _currentIndex,
        items: _bottomNavigationBarItems,
      ),
    );
  }
}
