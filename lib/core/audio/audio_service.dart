import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

import '../settings/settings_controller.dart';
import 'sound_effect.dart';

/// Singleton audio service for background music and sound effects.
class AudioService {
  AudioService._();

  static final AudioService instance = AudioService._();

  final AudioPlayer _musicPlayer = AudioPlayer();
  final AudioPlayer _sfxPlayer = AudioPlayer();

  SettingsController? _settings;
  bool _initialized = false;

  Future<void> init({required SettingsController settings}) async {
    if (_initialized) return;
    _settings = settings;

    await AudioPlayer.global.setAudioContext(
      AudioContext(
        android: AudioContextAndroid(
          isSpeakerphoneOn: false,
          stayAwake: true,
          contentType: AndroidContentType.music,
          usageType: AndroidUsageType.media,
          audioFocus: AndroidAudioFocus.gain,
        ),
        iOS: AudioContextIOS(
          category: AVAudioSessionCategory.playback,
          options: {AVAudioSessionOptions.mixWithOthers},
        ),
      ),
    );

    await _musicPlayer.setPlayerMode(PlayerMode.mediaPlayer);
    await _musicPlayer.setReleaseMode(ReleaseMode.loop);
    await _musicPlayer.setVolume(0.75);

    await _sfxPlayer.setPlayerMode(PlayerMode.lowLatency);
    await _sfxPlayer.setReleaseMode(ReleaseMode.stop);
    await _sfxPlayer.setVolume(0.7);

    _initialized = true;
  }

  Future<void> startBackgroundMusic() async {
    if (_settings?.musicEnabled != true) return;

    try {
      await _musicPlayer.stop();
      await _musicPlayer.setSource(
        AssetSource('audio/solarflex-space-541545.mp3'),
      );
      await _musicPlayer.resume();
      debugPrint('AudioService: background music started');
    } catch (e, stack) {
      debugPrint('AudioService: background music unavailable — $e\n$stack');
    }
  }

  Future<void> stopBackgroundMusic() async {
    try {
      await _musicPlayer.stop();
      debugPrint('AudioService: background music stopped');
    } catch (e) {
      debugPrint('AudioService: failed to stop music — $e');
    }
  }

  Future<void> setMusicEnabled(bool enabled) async {
    if (enabled) {
      await startBackgroundMusic();
    } else {
      await stopBackgroundMusic();
    }
  }

  Future<void> playSfx(SoundEffect effect) async {
    if (_settings?.sfxEnabled != true) return;

    try {
      final assetPath = effect.assetPath.replaceFirst('assets/', '');
      await _sfxPlayer.stop();
      await _sfxPlayer.play(AssetSource(assetPath));
    } catch (e) {
      // SFX files are optional until added — fail silently.
      debugPrint('AudioService: SFX unavailable (${effect.name}) — $e');
    }
  }

  Future<void> dispose() async {
    await _musicPlayer.dispose();
    await _sfxPlayer.dispose();
    _initialized = false;
  }
}
