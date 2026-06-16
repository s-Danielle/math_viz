import 'package:flutter/material.dart';

import '../../core/audio/audio_service.dart';
import '../../core/audio/sound_effect.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/lab_background.dart';
import '../../core/widgets/lab_button.dart';
import 'monty_hall_controller.dart';
import 'monty_hall_models.dart';
import 'widgets/door_grid.dart';
import 'widgets/monty_hall_simulation_dialog.dart';
import 'widgets/monty_hall_stats_panel.dart';
import 'widgets/probability_bar.dart';

class MontyHallScreen extends StatefulWidget {
  const MontyHallScreen({super.key, required this.level});

  final MontyHallLevel level;

  @override
  State<MontyHallScreen> createState() => _MontyHallScreenState();
}

class _MontyHallScreenState extends State<MontyHallScreen> {
  late final MontyHallController _controller =
      MontyHallController(widget.level);

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onPhaseSound);
  }

  void _onPhaseSound() {
    switch (_controller.phase) {
      case MontyHallPhase.hostRevealed:
        AudioService.instance.playSfx(SoundEffect.doorOpen);
      case MontyHallPhase.result:
        AudioService.instance.playSfx(
          _controller.won ? SoundEffect.success : SoundEffect.failure,
        );
      case MontyHallPhase.choosing:
      case MontyHallPhase.hostRevealing:
      case MontyHallPhase.revealing:
        break;
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onPhaseSound);
    _controller.dispose();
    super.dispose();
  }

  String get _hostMessage {
    switch (_controller.phase) {
      case MontyHallPhase.choosing:
        return 'Choose one door.';
      case MontyHallPhase.hostRevealing:
        return 'The host is opening the losing doors...';
      case MontyHallPhase.hostRevealed:
        return 'The host opened the empty doors. Stay with your door, or '
            'switch to the other?';
      case MontyHallPhase.revealing:
        return 'Opening your door...';
      case MontyHallPhase.result:
        final action = _controller.didSwitch ? 'switched' : 'stayed';
        return _controller.won
            ? 'You $action and won!'
            : 'You $action and lost.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.level.title, style: AppTextStyles.screenTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          Center(
            child: ListenableBuilder(
              listenable: _controller,
              builder: (context, _) => _ScoreChip(
                wins: _controller.playerWins,
                rounds: _controller.roundsPlayed,
              ),
            ),
          ),
          IconButton(
            tooltip: 'Simulate',
            icon: const Icon(Icons.bolt_rounded),
            color: AppColors.insightYellow,
            onPressed: () {
              AudioService.instance.playSfx(SoundEffect.tap);
              MontyHallSimulationDialog.show(context, widget.level);
            },
          ),
        ],
      ),
      body: LabBackground(
        child: SafeArea(
          top: false,
          child: ListenableBuilder(
            listenable: _controller,
            builder: (context, _) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Column(
                  children: [
                    _HostMessagePanel(
                      message: _hostMessage,
                      isResult: _controller.isResult,
                      won: _controller.won,
                    ),
                    const SizedBox(height: 12),
                    Expanded(child: DoorGrid(controller: _controller)),
                    const SizedBox(height: 12),
                    _ActionArea(controller: _controller),
                    const SizedBox(height: 12),
                    MontyHallStatsPanel(controller: _controller),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _HostMessagePanel extends StatelessWidget {
  const _HostMessagePanel({
    required this.message,
    required this.isResult,
    required this.won,
  });

  final String message;
  final bool isResult;
  final bool won;

  @override
  Widget build(BuildContext context) {
    final accent = !isResult
        ? AppColors.cyanGlow
        : won
            ? AppColors.neonGreen
            : AppColors.magenta;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accent.withValues(alpha: 0.5)),
      ),
      child: Text(
        message,
        style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w500),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _ActionArea extends StatelessWidget {
  const _ActionArea({required this.controller});

  final MontyHallController controller;

  @override
  Widget build(BuildContext context) {
    switch (controller.phase) {
      case MontyHallPhase.choosing:
        return Text(
          'Tap a door to make your first pick.',
          style: AppTextStyles.label,
          textAlign: TextAlign.center,
        );
      case MontyHallPhase.hostRevealing:
      case MontyHallPhase.revealing:
        return const _BusyIndicator();
      case MontyHallPhase.hostRevealed:
        return Row(
          children: [
            Expanded(
              child: LabButton(
                label: 'Stay',
                variant: LabButtonVariant.secondary,
                onPressed: () => controller.decide(stay: true),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: LabButton(
                label: 'Switch',
                onPressed: () => controller.decide(stay: false),
              ),
            ),
          ],
        );
      case MontyHallPhase.result:
        return _ExplanationCard(controller: controller);
    }
  }
}

class _BusyIndicator extends StatelessWidget {
  const _BusyIndicator();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 52,
      child: Center(
        child: SizedBox(
          width: 26,
          height: 26,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation(AppColors.cyanGlow),
          ),
        ),
      ),
    );
  }
}

class _ScoreChip extends StatelessWidget {
  const _ScoreChip({required this.wins, required this.rounds});

  final int wins;
  final int rounds;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.insightYellow.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.emoji_events_rounded,
              color: AppColors.insightYellow, size: 16),
          const SizedBox(width: 6),
          Text(
            '$wins/$rounds',
            style: AppTextStyles.label.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _ExplanationCard extends StatelessWidget {
  const _ExplanationCard({required this.controller});

  final MontyHallController controller;

  @override
  Widget build(BuildContext context) {
    final doors = controller.doorCount;

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.cardSurface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: AppColors.insightYellow.withValues(alpha: 0.4),
            ),
          ),
          child: Column(
            children: [
              ProbabilityBar(
                label: 'Stay',
                fraction: 1 / doors,
                caption: '1/$doors',
                color: AppColors.cyanGlow,
              ),
              const SizedBox(height: 12),
              ProbabilityBar(
                label: 'Switch',
                fraction: (doors - 1) / doors,
                caption: '${doors - 1}/$doors',
                color: AppColors.magenta,
              ),
              const SizedBox(height: 14),
              Text(
                controller.level.explanationText,
                style: AppTextStyles.label,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        LabButton(
          label: 'Next round',
          icon: Icons.refresh_rounded,
          width: double.infinity,
          variant: LabButtonVariant.success,
          onPressed: controller.nextRound,
        ),
      ],
    );
  }
}
