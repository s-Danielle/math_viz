import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

/// A single door in the Monty Hall grid with glow, eliminate and pulse states.
class DoorWidget extends StatefulWidget {
  const DoorWidget({
    super.key,
    required this.number,
    required this.isSelected,
    required this.isEliminated,
    required this.isRevealed,
    required this.hasPrize,
    required this.isSwitchCandidate,
    required this.onTap,
  });

  final int number;
  final bool isSelected;
  final bool isEliminated;
  final bool isRevealed;
  final bool hasPrize;
  final bool isSwitchCandidate;
  final VoidCallback? onTap;

  @override
  State<DoorWidget> createState() => _DoorWidgetState();
}

class _DoorWidgetState extends State<DoorWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
    value: 1.0,
  );

  @override
  void initState() {
    super.initState();
    _syncPulse();
  }

  @override
  void didUpdateWidget(DoorWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isSwitchCandidate != widget.isSwitchCandidate) {
      _syncPulse();
    }
  }

  void _syncPulse() {
    if (widget.isSwitchCandidate) {
      _pulse.repeat(reverse: true);
    } else {
      _pulse
        ..stop()
        ..value = 1.0;
    }
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  ({Color fill, Color border, IconData? icon, Color iconColor, double opacity})
      get _style {
    if (widget.isEliminated) {
      return (
        fill: AppColors.cardSurface,
        border: AppColors.textSecondary.withValues(alpha: 0.2),
        icon: Icons.close_rounded,
        iconColor: AppColors.textSecondary,
        opacity: 0.3,
      );
    }
    if (widget.isRevealed) {
      if (widget.hasPrize) {
        return (
          fill: AppColors.neonGreen.withValues(alpha: 0.25),
          border: AppColors.neonGreen,
          icon: Icons.emoji_events_rounded,
          iconColor: AppColors.neonGreen,
          opacity: 1.0,
        );
      }
      return (
        fill: AppColors.cardSurface,
        border: AppColors.textSecondary.withValues(alpha: 0.25),
        icon: Icons.sentiment_dissatisfied_rounded,
        iconColor: AppColors.textSecondary,
        opacity: 0.55,
      );
    }
    if (widget.isSelected) {
      return (
        fill: AppColors.electricBlue.withValues(alpha: 0.3),
        border: AppColors.cyanGlow,
        icon: Icons.check_rounded,
        iconColor: AppColors.cyanGlow,
        opacity: 1.0,
      );
    }
    if (widget.isSwitchCandidate) {
      return (
        fill: AppColors.darkViolet,
        border: AppColors.magenta,
        icon: null,
        iconColor: AppColors.magenta,
        opacity: 1.0,
      );
    }
    return (
      fill: AppColors.darkViolet,
      border: AppColors.cyanGlow.withValues(alpha: 0.25),
      icon: null,
      iconColor: AppColors.textSecondary,
      opacity: 1.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final style = _style;

    return AnimatedBuilder(
      animation: _pulse,
      builder: (context, _) {
        final glowColor = widget.isSwitchCandidate
            ? AppColors.magenta
            : widget.isSelected
                ? AppColors.cyanGlow
                : widget.isRevealed && widget.hasPrize
                    ? AppColors.neonGreen
                    : null;

        final pulseStrength = widget.isSwitchCandidate ? _pulse.value : 1.0;

        final scale = widget.isEliminated
            ? 0.45
            : (widget.isRevealed && widget.hasPrize)
                ? 1.06
                : 1.0;

        return GestureDetector(
          onTap: widget.onTap,
          child: AnimatedScale(
            scale: scale,
            duration: const Duration(milliseconds: 360),
            curve: widget.isEliminated ? Curves.easeIn : Curves.easeOutBack,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 360),
              opacity: style.opacity,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                decoration: BoxDecoration(
                color: style.fill,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: style.border, width: 2),
                boxShadow: glowColor == null
                    ? null
                    : [
                        BoxShadow(
                          color: glowColor.withValues(
                            alpha: 0.4 + 0.4 * pulseStrength,
                          ),
                          blurRadius: 14 + 10 * pulseStrength,
                          spreadRadius: 1,
                        ),
                      ],
              ),
                child: Center(
                  child: style.icon != null
                      ? Icon(style.icon, color: style.iconColor, size: 26)
                      : Text(
                          '${widget.number}',
                          style: AppTextStyles.button.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
