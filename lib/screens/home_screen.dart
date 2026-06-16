import 'package:flutter/material.dart';

/// Entry screen — add simulations to the list below as you build them.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const _placeholderSimulations = <String>[];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Math Viz'),
      ),
      body: _placeholderSimulations.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.functions,
                      size: 72,
                      color: theme.colorScheme.primary.withValues(alpha: 0.7),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Visual math simulations',
                      style: theme.textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Add simulations under lib/simulations/ and list them here.',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _placeholderSimulations.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.play_circle_outline),
                    title: Text(_placeholderSimulations[index]),
                    onTap: () {},
                  ),
                );
              },
            ),
    );
  }
}
