import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ListaDeTarefasApp(),
    );
  }
}

class ListaDeTarefasApp extends StatelessWidget {
  const ListaDeTarefasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}