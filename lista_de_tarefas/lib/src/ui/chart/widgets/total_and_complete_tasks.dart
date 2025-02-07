import 'package:flutter/material.dart';

class TotalAndCompleteTasks extends StatelessWidget {
  final double total;
  final double complete;

  const TotalAndCompleteTasks({
    super.key,
    required this.total,
    required this.complete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 90,
              child: Text(
                'Total: ${total.toStringAsFixed(0)}',
                style: theme.textTheme.titleSmall,
              ),
            ),
            SizedBox(
              height: 20,
              width: 1,
              child: VerticalDivider(
                color: theme.colorScheme.onSurface,
              ),
            ),
            Text(
              'Completas: ${complete.toStringAsFixed(0)}',
              style: theme.textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}
