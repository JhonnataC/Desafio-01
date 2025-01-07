import 'package:go_router/go_router.dart';
import 'package:lista_de_tarefas/routing/routes.dart';
import 'package:lista_de_tarefas/ui/chart/view_models/chart_viewmodel.dart';
import 'package:lista_de_tarefas/ui/chart/widgets/chart_screen.dart';
import 'package:lista_de_tarefas/ui/home/view_models/home_viewmodel.dart';
import 'package:lista_de_tarefas/ui/home/widgets/home_screen.dart';
import 'package:lista_de_tarefas/ui/list/view_models/list_viewmodels.dart';
import 'package:lista_de_tarefas/ui/list/widgets/list_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: Routes.home,
  routes: [
    GoRoute(
      path: Routes.home,
      builder: (context, state) => HomeScreen(
        homeViewModel: HomeViewModel(),
      ),
    ),
    GoRoute(
      path: Routes.list,
      builder: (context, state) {
        final groupId = state.pathParameters['groupId']!;

        ListViewModel listViewModel = ListViewModel(groupId);

        return ListScreen(
          listViewModel: listViewModel,
        );
      },
    ),
    GoRoute(
      path: Routes.chart,
      builder: (context, state) => ChartScreen(
        chartViewModel: ChartViewModel(),
      ),
    ),
  ],
);
