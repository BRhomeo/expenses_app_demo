import 'package:flutter/material.dart';
import 'package:expenses_app_demo/screens/income_expense_screen.dart';
import 'package:expenses_app_demo/screens/quiz_screen.dart';
import 'package:expenses_app_demo/theme.dart'; // Optional

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light; // Default to light mode

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Financial Wellness App',
      theme: lightTheme, // Optional
      darkTheme: darkTheme, // Optional
      themeMode: _themeMode,
      home: HomeScreen(toggleTheme: _toggleTheme),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final VoidCallback toggleTheme;

  const HomeScreen({super.key, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Financial Wellness'),
          actions: [
            // Optional theme toggle button
            IconButton(
              icon: Icon(Theme.of(context).brightness == Brightness.light
                  ? Icons.dark_mode
                  : Icons.light_mode),
              onPressed: toggleTheme,
            ),
            //to quiz page
            IconButton(
              icon: const Icon(Icons.quiz),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QuizScreen()),
                );
              },
            ),
          ],
        ),
        body: Center(child: IncomeExpenseScreen()));
  }
}
