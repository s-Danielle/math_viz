import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../monty_hall/monty_hall_level_screen.dart';
import 'paradox_model.dart';

Widget _buildMontyHall(BuildContext context) => const MontyHallLevelScreen();

/// Central registry of all paradox modules.
///
/// Add new paradoxes here — the selection screen renders them automatically.
const List<ParadoxModel> paradoxRegistry = [
  ParadoxModel(
    id: 'monty_hall',
    title: 'Monty Hall',
    shortDescription: 'Can switching choices beat your first instinct?',
    longDescription:
        'One door hides a prize. After you pick, the host opens losing doors. '
        'Should you stay or switch?',
    icon: Icons.meeting_room_outlined,
    difficulty: 1,
    themeColor: AppColors.magenta,
    route: '/monty-hall',
    builder: _buildMontyHall,
  ),
];
