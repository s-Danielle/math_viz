import 'package:flutter/material.dart';

import '../audio/audio_service.dart';
import '../audio/sound_effect.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

enum LabButtonVariant { primary, secondary, danger, success, disabled }

/// Reusable glowing button for Paradox Lab screens.
class LabButton extends StatelessWidget {
  const LabButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = LabButtonVariant.primary,
    this.icon,
    this.width,
    this.playTapSound = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final LabButtonVariant variant;
  final IconData? icon;
  final double? width;
  final bool playTapSound;

  bool get _isDisabled =>
      variant == LabButtonVariant.disabled || onPressed == null;

  (Color background, Color glow, Color text) get _colors {
    switch (variant) {
      case LabButtonVariant.primary:
        return (
          AppColors.electricBlue,
          AppColors.cyanGlow,
          AppColors.textPrimary,
        );
      case LabButtonVariant.secondary:
        return (
          AppColors.darkViolet,
          AppColors.magenta,
          AppColors.cyanGlow,
        );
      case LabButtonVariant.danger:
        return (
          AppColors.magenta,
          AppColors.magenta,
          AppColors.textPrimary,
        );
      case LabButtonVariant.success:
        return (
          AppColors.neonGreen,
          AppColors.neonGreen,
          AppColors.deepSpaceNavy,
        );
      case LabButtonVariant.disabled:
        return (
          AppColors.cardSurface,
          AppColors.textSecondary,
          AppColors.textSecondary,
        );
    }
  }

  void _handlePress() {
    if (_isDisabled) return;
    if (playTapSound) {
      AudioService.instance.playSfx(SoundEffect.tap);
    }
    onPressed?.call();
  }

  @override
  Widget build(BuildContext context) {
    final (background, glow, textColor) = _colors;

    return SizedBox(
      width: width,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _isDisabled ? null : _handlePress,
          borderRadius: BorderRadius.circular(20),
          child: Ink(
            decoration: BoxDecoration(
              color: background.withValues(alpha: _isDisabled ? 0.5 : 1.0),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: glow.withValues(alpha: _isDisabled ? 0.2 : 0.6),
                width: 1.5,
              ),
              boxShadow: _isDisabled
                  ? null
                  : [
                      BoxShadow(
                        color: glow.withValues(alpha: 0.45),
                        blurRadius: 20,
                        spreadRadius: 1,
                      ),
                    ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Icon(icon, color: textColor, size: 22),
                  const SizedBox(width: 8),
                ],
                Flexible(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.button.copyWith(color: textColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
