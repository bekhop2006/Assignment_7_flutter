import 'package:flutter/material.dart';

import '../state/app_state.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key, required this.state});

  final AppState state;

  @override
  Widget build(BuildContext context) {
    final total = state.totalCount;
    final done = state.completedCount;
    final active = total - done;
    final progress = total == 0 ? 0.0 : done / total;

    return Scaffold(
      appBar: AppBar(title: const Text('Stats')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Progress',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    LinearProgressIndicator(
                      key: const Key('progressBar'),
                      value: progress,
                      minHeight: 10,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${(progress * 100).toStringAsFixed(0)}% completed',
                      key: const Key('progressLabel'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            _StatTile(
              keyName: 'totalStat',
              label: 'Total tasks',
              value: total,
              icon: Icons.list_alt,
            ),
            _StatTile(
              keyName: 'doneStat',
              label: 'Completed',
              value: done,
              icon: Icons.check_circle,
            ),
            _StatTile(
              keyName: 'activeStat',
              label: 'Active',
              value: active,
              icon: Icons.timelapse,
            ),
          ],
        ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.keyName,
    required this.label,
    required this.value,
    required this.icon,
  });

  final String keyName;
  final String label;
  final int value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        key: Key(keyName),
        leading: Icon(icon),
        title: Text(label),
        trailing: Text('$value', style: Theme.of(context).textTheme.titleLarge),
      ),
    );
  }
}
