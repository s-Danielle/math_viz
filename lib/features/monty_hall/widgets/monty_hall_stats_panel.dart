import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../monty_hall_controller.dart';

/// Shows stay vs switch win tallies across rounds.
class MontyHallStatsPanel extends StatelessWidget {
  const MontyHallStatsPanel({super.key, required this.controller});

  final MontyHallController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Wins across ${controller.roundsPlayed} rounds',
          style: AppTextStyles.label,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _StatChip(
                label: 'Stay wins',
                wins: controller.stayWins,
                color: AppColors.cyanGlow,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatChip(
                label: 'Switch wins',
                wins: controller.switchWins,
                color: AppColors.magenta,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({
    required this.label,
    required this.wins,
    required this.color,
  });

  final String label;
  final int wins;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Column(
        children: [
          Text(label, style: AppTextStyles.label),
          const SizedBox(height: 4),
          Text(
            '$wins',
            style: AppTextStyles.displayTitle.copyWith(
              fontSize: 28,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
