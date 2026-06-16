import 'package:flutter/material.dart';

import 'app.dart';
import 'core/audio/audio_service.dart';
import 'core/settings/settings_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final settings = await SettingsController.create();
  await AudioService.instance.init(settings: settings);

  runApp(ParadoxLabApp(settings: settings));
}
