import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/audio/audio_service.dart';
import '../../../core/audio/sound_effect.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/lab_button.dart';
import '../monty_hall_controller.dart';
import '../monty_hall_models.dart';
import 'probability_bar.dart';

/// Modal that runs many automated rounds and reports stay vs switch wins.
class MontyHallSimulationDialog extends StatefulWidget {
  const MontyHallSimulationDialog({super.key, required this.level});

  final MontyHallLevel level;

  static Future<void> show(BuildContext context, MontyHallLevel level) {
    return showDialog<void>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.7),
      builder: (_) => MontyHallSimulationDialog(level: level),
    );
  }

  @override
  State<MontyHallSimulationDialog> createState() =>
      _MontyHallSimulationDialogState();
}

class _MontyHallSimulationDialogState extends State<MontyHallSimulationDialog> {
  static const _maxTrials = 1000000;
  static const _presets = [100, 1000, 10000];

  final TextEditingController _input = TextEditingController(text: '1000');
  MontyHallSimulationResult? _result;
  String? _error;
  bool _running = false;

  @override
  void dispose() {
    _input.dispose();
    super.dispose();
  }

  Future<void> _run() async {
    if (_running) return;
    AudioService.instance.playSfx(SoundEffect.tap);
    final value = int.tryParse(_input.text.trim());
    if (value == null || value <= 0) {
      setState(() => _error = 'Enter a number greater than 0.');
      return;
    }
    if (value > _maxTrials) {
      setState(() => _error = 'Maximum is ${_formatInt(_maxTrials)}.');
      return;
    }

    setState(() {
      _error = null;
      _running = true;
      _result = null;
    });

    // Brief pause so the run feels like it is playing out.
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;

    setState(() {
      _running = false;
      _result = simulateMontyHall(
        doorCount: widget.level.doorCount,
        trials: value,
      );
    });
  }

  void _applyPreset(int value) {
    if (_running) return;
    _input.text = '$value';
    _run();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: AppColors.cardSurface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.cyanGlow.withValues(alpha: 0.4),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.bolt_rounded, color: AppColors.insightYellow),
                  const SizedBox(width: 8),
                  Text('Simulate rounds', style: AppTextStyles.screenTitle.copyWith(fontSize: 22)),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                '${widget.level.title} · ${widget.level.doorCount} doors',
                style: AppTextStyles.label,
              ),
              const SizedBox(height: 18),
              Text('Number of rounds', style: AppTextStyles.label),
              const SizedBox(height: 8),
              TextField(
                controller: _input,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                style: AppTextStyles.button,
                cursorColor: AppColors.cyanGlow,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.deepSpaceNavy,
                  errorText: _error,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: AppColors.cyanGlow.withValues(alpha: 0.3),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.cyanGlow),
                  ),
                ),
                onSubmitted: (_) => _run(),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: [
                  for (final preset in _presets)
                    ActionChip(
                      label: Text(_formatInt(preset), style: AppTextStyles.label),
                      backgroundColor: AppColors.darkViolet,
                      side: BorderSide(
                        color: AppColors.cyanGlow.withValues(alpha: 0.3),
                      ),
                      onPressed: () => _applyPreset(preset),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              LabButton(
                label: _running ? 'Simulating...' : 'Run simulation',
                icon: Icons.play_arrow_rounded,
                width: double.infinity,
                variant: _running
                    ? LabButtonVariant.disabled
                    : LabButtonVariant.primary,
                onPressed: _running ? null : _run,
              ),
              if (_running) ...[
                const SizedBox(height: 22),
                const _RunningIndicator(),
              ],
              if (!_running && _result != null) ...[
                const SizedBox(height: 22),
                _ResultSection(result: _result!),
              ],
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'Close',
                    style: AppTextStyles.label.copyWith(
                      color: AppColors.cyanGlow,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RunningIndicator extends StatelessWidget {
  const _RunningIndicator();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          width: 30,
          height: 30,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation(AppColors.insightYellow),
          ),
        ),
        const SizedBox(height: 12),
        Text('Playing out rounds...', style: AppTextStyles.label),
      ],
    );
  }
}

class _ResultSection extends StatelessWidget {
  const _ResultSection({required this.result});

  final MontyHallSimulationResult result;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${_formatInt(result.trials)} rounds played',
          style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 14),
        ProbabilityBar(
          label: 'Stay wins',
          fraction: result.stayRate,
          caption:
              '${_formatInt(result.stayWins)}  (${_percent(result.stayRate)})',
          color: AppColors.cyanGlow,
        ),
        const SizedBox(height: 14),
        ProbabilityBar(
          label: 'Switch wins',
          fraction: result.switchRate,
          caption:
              '${_formatInt(result.switchWins)}  (${_percent(result.switchRate)})',
          color: AppColors.magenta,
        ),
      ],
    );
  }
}

String _percent(double value) => '${(value * 100).toStringAsFixed(1)}%';

String _formatInt(int value) {
  final digits = value.toString();
  final buffer = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) buffer.write(',');
    buffer.write(digits[i]);
  }
  return buffer.toString();
}
