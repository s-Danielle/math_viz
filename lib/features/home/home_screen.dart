import 'package:flutter/material.dart';

import '../../core/audio/audio_service.dart';
import '../../core/audio/sound_effect.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/lab_background.dart';
import '../../core/widgets/lab_button.dart';
import '../about/about_screen.dart';
import '../paradoxes/paradox_selection_screen.dart';
import '../settings/settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _navigate(BuildContext context, Widget screen) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LabBackground(
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 8,
                left: 8,
                child: IconButton(
                  tooltip: 'About',
                  icon: const Icon(Icons.info_outline),
                  color: AppColors.cyanGlow,
                  onPressed: () {
                    AudioService.instance.playSfx(SoundEffect.tap);
                    _navigate(context, const AboutScreen());
                  },
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  tooltip: 'Settings',
                  icon: const Icon(Icons.settings_outlined),
                  color: AppColors.cyanGlow,
                  onPressed: () {
                    AudioService.instance.playSfx(SoundEffect.tap);
                    _navigate(context, const SettingsScreen());
                  },
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Paradox Lab',
                        style: AppTextStyles.displayTitle.copyWith(
                          shadows: [
                            Shadow(
                              color: AppColors.cyanGlow.withValues(alpha: 0.5),
                              blurRadius: 24,
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Test your intuition.\nBreak your assumptions.',
                        style: AppTextStyles.subtitle,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 64),
                      LabButton(
                        label: 'Play',
                        icon: Icons.play_arrow_rounded,
                        width: 220,
                        onPressed: () => _navigate(
                          context,
                          const ParadoxSelectionScreen(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
