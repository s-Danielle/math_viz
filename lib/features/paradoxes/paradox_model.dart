import 'package:flutter/material.dart';

/// Data model for a paradox experiment module.
class ParadoxModel {
  const ParadoxModel({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.longDescription,
    required this.icon,
    required this.difficulty,
    required this.themeColor,
    required this.route,
    this.builder,
    this.isCompleted = false,
    this.isLocked = false,
  });

  final String id;
  final String title;
  final String shortDescription;
  final String longDescription;
  final IconData icon;
  final int difficulty;
  final Color themeColor;
  final String route;

  /// Builds the entry screen for this paradox module.
  final Widget Function(BuildContext context)? builder;

  final bool isCompleted;
  final bool isLocked;
}
