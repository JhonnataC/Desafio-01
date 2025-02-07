import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateAndScreenTitle extends StatelessWidget {
  final String title;

  const DateAndScreenTitle({super.key, required this.title});

  String get today {
    final today = DateTime.now();
    final month =
        toBeginningOfSentenceCase(DateFormat('MMMM', 'pt_BR').format(today));
    return '${today.day} de $month';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            today,
            style: theme.headlineSmall,
          ),
          const SizedBox(height: 3),
          Text(
            toBeginningOfSentenceCase(title),
            style: theme.headlineLarge,
          ),
        ],
      ),
    );
  }
}
