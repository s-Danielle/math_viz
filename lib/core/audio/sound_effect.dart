/// Sound effects used throughout Paradox Lab.
///
/// Add new entries here and map them to asset paths as audio files are created.
enum SoundEffect {
  tap('assets/audio/sfx/tap.mp3'),
  success('assets/audio/sfx/success.mp3'),
  failure('assets/audio/sfx/failure.mp3'),
  doorOpen('assets/audio/sfx/door_open.mp3'),
  insight('assets/audio/sfx/insight.mp3');

  const SoundEffect(this.assetPath);

  final String assetPath;
}

/// Background music asset path.
/// Replace with any ambient track (mp3 or wav) at this path.
const backgroundMusicAsset = 'assets/audio/solarflex-space-541545.mp3';
