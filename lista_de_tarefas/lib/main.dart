import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:lista_de_tarefas/routing/router.dart';
import 'package:lista_de_tarefas/ui/core/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: router,
    );
  }
}
