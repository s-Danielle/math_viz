import 'package:flutter/material.dart';

import '../../core/audio/audio_service.dart';
import '../../core/audio/sound_effect.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/lab_background.dart';
import '../../core/widgets/page_transitions.dart';
import 'paradox_registry.dart';

class ParadoxSelectionScreen extends StatelessWidget {
  const ParadoxSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Experiment', style: AppTextStyles.screenTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: LabBackground(
        child: paradoxRegistry.isEmpty
            ? _EmptyState()
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: paradoxRegistry.length,
                itemBuilder: (context, index) {
                  final paradox = paradoxRegistry[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: Icon(
                        paradox.icon,
                        color: paradox.themeColor,
                      ),
                      title: Text(
                        paradox.title,
                        style: AppTextStyles.body.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        paradox.shortDescription,
                        style: AppTextStyles.label,
                      ),
                      trailing: paradox.isLocked
                          ? Icon(
                              Icons.lock_outline,
                              color: AppColors.textSecondary,
                            )
                          : Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: AppColors.cyanGlow,
                            ),
                      onTap: paradox.isLocked || paradox.builder == null
                          ? null
                          : () {
                              AudioService.instance.playSfx(SoundEffect.tap);
                              Navigator.of(context).push(
                                diagonalRoute(paradox.builder!(context)),
                              );
                            },
                    ),
                  );
                },
              ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.science_outlined,
              size: 72,
              color: AppColors.cyanGlow.withValues(alpha: 0.6),
            ),
            const SizedBox(height: 24),
            Text(
              'Paradoxes will be found here.',
              style: AppTextStyles.screenTitle.copyWith(fontSize: 22),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Experiments are being prepared in the lab.',
              style: AppTextStyles.subtitle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
