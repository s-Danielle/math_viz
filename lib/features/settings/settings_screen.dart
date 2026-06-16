import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/audio/audio_service.dart';
import '../../core/settings/settings_controller.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/lab_background.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: AppTextStyles.screenTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: LabBackground(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Text('Audio', style: AppTextStyles.label),
            const SizedBox(height: 12),
            _SettingsTile(
              title: 'Background Music',
              subtitle: 'Ambient lab atmosphere',
              icon: Icons.music_note_outlined,
              value: settings.musicEnabled,
              onChanged: (value) async {
                await settings.setMusicEnabled(value);
                await AudioService.instance.setMusicEnabled(value);
              },
            ),
            const SizedBox(height: 8),
            _SettingsTile(
              title: 'Sound Effects',
              subtitle: 'Button taps and interactions',
              icon: Icons.volume_up_outlined,
              value: settings.sfxEnabled,
              onChanged: settings.setSfxEnabled,
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SwitchListTile(
        secondary: Icon(icon, color: AppColors.cyanGlow),
        title: Text(
          title,
          style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(subtitle, style: AppTextStyles.label),
        value: value,
        activeThumbColor: AppColors.cyanGlow,
        onChanged: onChanged,
      ),
    );
  }
}
