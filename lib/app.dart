import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/audio/audio_service.dart';
import 'core/settings/settings_controller.dart';
import 'core/theme/app_theme.dart';
import 'features/home/home_screen.dart';

class ParadoxLabApp extends StatefulWidget {
  const ParadoxLabApp({super.key, required this.settings});

  final SettingsController settings;

  @override
  State<ParadoxLabApp> createState() => _ParadoxLabAppState();
}

class _ParadoxLabAppState extends State<ParadoxLabApp> {
  @override
  void initState() {
    super.initState();
    // Start music after the first frame so Android audio is ready.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AudioService.instance.startBackgroundMusic();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: widget.settings,
      child: MaterialApp(
        title: 'Paradox Lab',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        home: const HomeScreen(),
      ),
    );
  }
}
