import 'package:financass/views/InicialPage/InicialScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Financas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 80, 29, 168)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const InicialScreen(),
    );
  }
}
