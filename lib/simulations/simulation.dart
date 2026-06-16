import 'package:flutter/material.dart';

/// Base type for a visual math simulation screen.
///
/// Extend this when you add your first simulation, e.g.:
/// ```dart
/// class SineWaveSimulation extends Simulation {
///   const SineWaveSimulation();
///
///   @override
///   String get id => 'sine_wave';
///
///   @override
///   String get title => 'Sine Wave';
///
///   @override
///   Widget buildScreen(BuildContext context) => const SineWaveScreen();
/// }
/// ```
abstract class Simulation {
  const Simulation();

  String get id;
  String get title;
  String? get description => null;

  Widget buildScreen(BuildContext context);
}
