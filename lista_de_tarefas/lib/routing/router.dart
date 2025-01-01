import 'package:go_router/go_router.dart';
import 'package:lista_de_tarefas/routing/routes.dart';
import 'package:lista_de_tarefas/ui/chart/widgets/chart_screen.dart';
import 'package:lista_de_tarefas/ui/home/widgets/home_screen.dart';
import 'package:lista_de_tarefas/ui/list/widgets/list_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: Routes.home,
  routes: [
    GoRoute(
      path: Routes.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: Routes.list,
      builder: (context, state) => const ListScreen(),
    ),
    GoRoute(
      path: Routes.chart,
      builder: (context, state) => const ChartScreen(),
    ),
  ],
);
