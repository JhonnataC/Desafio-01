import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/ui/home/view_models/home_viewmodel.dart';

class HomeScreen extends StatelessWidget {
  final HomeViewModel homeViewModel;

  const HomeScreen({super.key, required this.homeViewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Home'),
      ),
    );
  }
}
