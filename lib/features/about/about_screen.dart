import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/lab_background.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About', style: AppTextStyles.screenTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: LabBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.biotech_outlined,
                size: 80,
                color: AppColors.magenta.withValues(alpha: 0.8),
              ),
              const SizedBox(height: 24),
              Text(
                'Paradox Lab',
                style: AppTextStyles.displayTitle.copyWith(fontSize: 28),
              ),
              const SizedBox(height: 8),
              Text('Version 0.1.0', style: AppTextStyles.label),
              const SizedBox(height: 32),
              Text(
                'An interactive lab where mathematical paradoxes and '
                'philosophical problems become experiments. Test your '
                'intuition, break your assumptions, and discover why '
                'reality doesn\'t always match what you expect.',
                style: AppTextStyles.body,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.cardSurface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.cyanGlow.withValues(alpha: 0.2),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      'Experience before explanation.',
                      style: AppTextStyles.body.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.insightYellow,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Each paradox lets you interact first, then understand.',
                      style: AppTextStyles.label,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),
              Text(
                'Built with Flutter',
                style: AppTextStyles.label.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
