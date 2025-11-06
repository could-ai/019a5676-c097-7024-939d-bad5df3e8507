import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const AIPhotoEditorApp());
}

class AIPhotoEditorApp extends StatelessWidget {
  const AIPhotoEditorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Photo Editor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
      ),
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
      routes: {
        '/': (context) => const HomeScreen(),
      },
    );
  }
}