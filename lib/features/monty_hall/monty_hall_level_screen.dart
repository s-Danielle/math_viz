import 'package:flutter/material.dart';

import '../../core/audio/audio_service.dart';
import '../../core/audio/sound_effect.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/lab_background.dart';
import '../../core/widgets/lab_button.dart';
import '../../core/widgets/page_transitions.dart';
import 'monty_hall_models.dart';
import 'monty_hall_screen.dart';
import 'widgets/monty_hall_simulation_dialog.dart';

class MontyHallLevelScreen extends StatelessWidget {
  const MontyHallLevelScreen({super.key});

  void _openLevel(BuildContext context, MontyHallLevel level) {
    AudioService.instance.playSfx(SoundEffect.tap);
    Navigator.of(context).push(
      diagonalRoute(MontyHallScreen(level: level)),
    );
  }

  void _simulateLevel(BuildContext context, MontyHallLevel level) {
    AudioService.instance.playSfx(SoundEffect.tap);
    MontyHallSimulationDialog.show(context, level);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Monty Hall', style: AppTextStyles.screenTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: LabBackground(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Can switching choices beat your first instinct?',
              style: AppTextStyles.subtitle,
            ),
            const SizedBox(height: 8),
            Text('Choose a level', style: AppTextStyles.label),
            const SizedBox(height: 16),
            for (final level in montyHallLevels) ...[
              _LevelCard(
                level: level,
                onPlay: () => _openLevel(context, level),
                onSimulate: () => _simulateLevel(context, level),
              ),
              const SizedBox(height: 12),
            ],
          ],
        ),
      ),
    );
  }
}

class _LevelCard extends StatelessWidget {
  const _LevelCard({
    required this.level,
    required this.onPlay,
    required this.onSimulate,
  });

  final MontyHallLevel level;
  final VoidCallback onPlay;
  final VoidCallback onSimulate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.magenta.withValues(alpha: 0.35),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.magenta.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${level.levelNumber}',
                  style: AppTextStyles.button.copyWith(
                    color: AppColors.magenta,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      level.title,
                      style: AppTextStyles.body.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${level.doorCount} doors',
                      style: AppTextStyles.label,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: LabButton(
                  label: 'Simulate',
                  icon: Icons.bolt_rounded,
                  variant: LabButtonVariant.secondary,
                  onPressed: onSimulate,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: LabButton(
                  label: 'Play',
                  icon: Icons.play_arrow_rounded,
                  onPressed: onPlay,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
