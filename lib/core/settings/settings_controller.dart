import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Persists and exposes app settings (music / SFX toggles).
class SettingsController extends ChangeNotifier {
  SettingsController(this._prefs);

  static const _musicKey = 'music_enabled';
  static const _sfxKey = 'sfx_enabled';

  final SharedPreferences _prefs;

  bool _musicEnabled = true;
  bool _sfxEnabled = true;

  bool get musicEnabled => _musicEnabled;
  bool get sfxEnabled => _sfxEnabled;

  static Future<SettingsController> create() async {
    final prefs = await SharedPreferences.getInstance();
    final controller = SettingsController(prefs);
    controller._musicEnabled = prefs.getBool(_musicKey) ?? true;
    controller._sfxEnabled = prefs.getBool(_sfxKey) ?? true;
    return controller;
  }

  Future<void> setMusicEnabled(bool value) async {
    if (_musicEnabled == value) return;
    _musicEnabled = value;
    await _prefs.setBool(_musicKey, value);
    notifyListeners();
  }

  Future<void> setSfxEnabled(bool value) async {
    if (_sfxEnabled == value) return;
    _sfxEnabled = value;
    await _prefs.setBool(_sfxKey, value);
    notifyListeners();
  }
}
