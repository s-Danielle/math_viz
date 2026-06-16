import 'package:flutter/material.dart';

import '../monty_hall_controller.dart';
import 'door_widget.dart';

/// Lays out the doors in a responsive grid that scales with the door count.
class DoorGrid extends StatelessWidget {
  const DoorGrid({super.key, required this.controller});

  final MontyHallController controller;

  int get _columns {
    final n = controller.doorCount;
    if (n <= 3) return 3;
    if (n <= 12) return 5;
    return 6;
  }

  @override
  Widget build(BuildContext context) {
    final canChoose = controller.phase == MontyHallPhase.choosing;

    return GridView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      physics: const BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _columns,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.72,
      ),
      itemCount: controller.doorCount,
      itemBuilder: (context, index) {
        return DoorWidget(
          number: index + 1,
          isSelected: controller.isSelected(index),
          isEliminated: controller.isEliminated(index),
          isRevealed: controller.isResult,
          hasPrize: controller.isPrize(index),
          isSwitchCandidate: controller.isSwitchCandidate(index),
          onTap: canChoose ? () => controller.selectDoor(index) : null,
        );
      },
    );
  }
}
