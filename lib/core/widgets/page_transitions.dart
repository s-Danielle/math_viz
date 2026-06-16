import 'package:flutter/material.dart';

/// Sideways diagonal slide-in transition used when entering experiment modules.
Route<T> diagonalRoute<T>(Widget page) {
  return PageRouteBuilder<T>(
    transitionDuration: const Duration(milliseconds: 450),
    reverseTransitionDuration: const Duration(milliseconds: 320),
    pageBuilder: (_, _, _) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      );
      final slide = Tween<Offset>(
        begin: const Offset(1.0, -0.65),
        end: Offset.zero,
      ).animate(curved);
      return SlideTransition(
        position: slide,
        child: FadeTransition(opacity: curved, child: child),
      );
    },
  );
}
