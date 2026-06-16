import 'dart:math';

import 'package:flutter/foundation.dart';

import 'monty_hall_models.dart';

enum MontyHallPhase { choosing, hostRevealing, hostRevealed, revealing, result }

/// Game logic + stats for a Monty Hall round (Design Document section 12).
class MontyHallController extends ChangeNotifier {
  MontyHallController(this.level) {
    _startRound();
  }

  /// Delay before the host opens the losing doors / before the final reveal,
  /// so transitions feel deliberate rather than instant.
  static const Duration revealDelay = Duration(milliseconds: 700);

  final MontyHallLevel level;
  final Random _random = Random();
  bool _disposed = false;

  late int _prizeDoor;
  int? _selectedDoor;
  int? _switchDoor;
  final Set<int> _eliminated = {};
  MontyHallPhase _phase = MontyHallPhase.choosing;
  bool _didSwitch = false;
  bool _won = false;

  /// Cumulative tallies — counted for every completed round regardless of the
  /// player's actual choice, so the strategy pattern is always visible.
  int stayWins = 0;
  int switchWins = 0;

  /// The player's personal score from the choices they actually made.
  int playerWins = 0;
  int roundsPlayed = 0;

  int get doorCount => level.doorCount;
  MontyHallPhase get phase => _phase;
  int? get selectedDoor => _selectedDoor;
  int? get switchDoor => _switchDoor;
  int get prizeDoor => _prizeDoor;
  bool get didSwitch => _didSwitch;
  bool get won => _won;
  bool get isResult => _phase == MontyHallPhase.result;
  bool get isBusy =>
      _phase == MontyHallPhase.hostRevealing ||
      _phase == MontyHallPhase.revealing;

  bool isEliminated(int door) => _eliminated.contains(door);
  bool isSelected(int door) => _selectedDoor == door;
  bool isPrize(int door) => _prizeDoor == door;
  bool isSwitchCandidate(int door) =>
      _phase == MontyHallPhase.hostRevealed && _switchDoor == door;

  void _startRound() {
    _prizeDoor = _random.nextInt(doorCount);
    _selectedDoor = null;
    _switchDoor = null;
    _eliminated.clear();
    _didSwitch = false;
    _won = false;
    _phase = MontyHallPhase.choosing;
  }

  /// User picks a door. After a short pause the host opens every losing door
  /// except one, always keeping the prize available to switch to when possible.
  Future<void> selectDoor(int door) async {
    if (_phase != MontyHallPhase.choosing) return;
    _selectedDoor = door;

    if (door == _prizeDoor) {
      final others = [
        for (var d = 0; d < doorCount; d++)
          if (d != door) d,
      ];
      _switchDoor = others[_random.nextInt(others.length)];
    } else {
      _switchDoor = _prizeDoor;
    }

    _phase = MontyHallPhase.hostRevealing;
    _safeNotify();

    await Future.delayed(revealDelay);
    if (_disposed) return;

    for (var d = 0; d < doorCount; d++) {
      if (d != _selectedDoor && d != _switchDoor) {
        _eliminated.add(d);
      }
    }
    _phase = MontyHallPhase.hostRevealed;
    _safeNotify();
  }

  Future<void> decide({required bool stay}) async {
    if (_phase != MontyHallPhase.hostRevealed) return;
    _didSwitch = !stay;

    final stayIsWin = _selectedDoor == _prizeDoor;
    final switchIsWin = _switchDoor == _prizeDoor;

    _phase = MontyHallPhase.revealing;
    _safeNotify();

    await Future.delayed(revealDelay);
    if (_disposed) return;

    if (stayIsWin) stayWins++;
    if (switchIsWin) switchWins++;
    _won = stay ? stayIsWin : switchIsWin;
    if (_won) playerWins++;
    roundsPlayed++;

    if (!stay) _selectedDoor = _switchDoor;

    _phase = MontyHallPhase.result;
    _safeNotify();
  }

  void nextRound() {
    _startRound();
    _safeNotify();
  }

  void resetStats() {
    stayWins = 0;
    switchWins = 0;
    playerWins = 0;
    roundsPlayed = 0;
    _safeNotify();
  }

  void _safeNotify() {
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}

/// Aggregated outcome of running many automated rounds.
class MontyHallSimulationResult {
  const MontyHallSimulationResult({
    required this.trials,
    required this.stayWins,
    required this.switchWins,
  });

  final int trials;
  final int stayWins;
  final int switchWins;

  double get stayRate => trials == 0 ? 0 : stayWins / trials;
  double get switchRate => trials == 0 ? 0 : switchWins / trials;
}

/// Plays out [trials] rounds for the given [doorCount].
///
/// In every round the host opens all losing doors but one, so staying wins
/// only when the first pick was already the prize; switching wins otherwise.
MontyHallSimulationResult simulateMontyHall({
  required int doorCount,
  required int trials,
  Random? random,
}) {
  final rng = random ?? Random();
  var stayWins = 0;
  for (var i = 0; i < trials; i++) {
    final prize = rng.nextInt(doorCount);
    final pick = rng.nextInt(doorCount);
    if (pick == prize) stayWins++;
  }
  return MontyHallSimulationResult(
    trials: trials,
    stayWins: stayWins,
    switchWins: trials - stayWins,
  );
}
