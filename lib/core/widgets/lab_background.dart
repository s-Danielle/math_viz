import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Reusable dark gradient background with subtle stars and glow blobs.
class LabBackground extends StatelessWidget {
  const LabBackground({
    super.key,
    required this.child,
    this.showStars = true,
  });

  final Widget child;
  final bool showStars;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.darkViolet,
                AppColors.deepSpaceNavy,
                Color(0xFF05001A),
              ],
              stops: [0.0, 0.55, 1.0],
            ),
          ),
        ),
        if (showStars) const _StarField(),
        const _GlowBlobs(),
        child,
      ],
    );
  }
}

class _StarField extends StatelessWidget {
  const _StarField();

  static const _starData = <(double, double, double, double)>[
    (0.08, 0.12, 2.0, 0.6),
    (0.22, 0.08, 1.5, 0.4),
    (0.45, 0.15, 2.5, 0.7),
    (0.72, 0.06, 1.8, 0.5),
    (0.88, 0.18, 2.0, 0.6),
    (0.15, 0.35, 1.2, 0.35),
    (0.55, 0.28, 1.6, 0.45),
    (0.80, 0.32, 2.2, 0.55),
    (0.30, 0.55, 1.4, 0.4),
    (0.65, 0.48, 1.8, 0.5),
    (0.10, 0.72, 2.0, 0.55),
    (0.50, 0.68, 1.3, 0.35),
    (0.85, 0.75, 1.7, 0.45),
    (0.35, 0.88, 2.0, 0.5),
    (0.70, 0.90, 1.5, 0.4),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return CustomPaint(
          size: Size(constraints.maxWidth, constraints.maxHeight),
          painter: _StarPainter(stars: _starData),
        );
      },
    );
  }
}

class _StarPainter extends CustomPainter {
  const _StarPainter({required this.stars});

  final List<(double, double, double, double)> stars;

  @override
  void paint(Canvas canvas, Size size) {
    for (final (x, y, radius, opacity) in stars) {
      final paint = Paint()
        ..color = Colors.white.withValues(alpha: opacity)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(
        Offset(x * size.width, y * size.height),
        radius,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _GlowBlobs extends StatelessWidget {
  const _GlowBlobs();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -80,
          right: -60,
          child: _GlowBlob(
            size: 220,
            color: AppColors.magenta.withValues(alpha: 0.12),
          ),
        ),
        Positioned(
          bottom: 120,
          left: -100,
          child: _GlowBlob(
            size: 280,
            color: AppColors.electricBlue.withValues(alpha: 0.10),
          ),
        ),
        Positioned(
          top: MediaQuery.sizeOf(context).height * 0.35,
          right: -40,
          child: _GlowBlob(
            size: 160,
            color: AppColors.cyanGlow.withValues(alpha: 0.08),
          ),
        ),
      ],
    );
  }
}

class _GlowBlob extends StatelessWidget {
  const _GlowBlob({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color, color.withValues(alpha: 0)],
        ),
      ),
    );
  }
}
