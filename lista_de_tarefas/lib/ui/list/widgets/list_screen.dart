import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/ui/list/view_models/list_viewmodels.dart';

class ListScreen extends StatelessWidget {
  final ListViewModel listViewModel;

  const ListScreen({super.key, required this.listViewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('List'),
      ),
    );
  }
}
