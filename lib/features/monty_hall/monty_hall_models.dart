/// Data-driven Monty Hall level configuration (Design Document section 17).
class MontyHallLevel {
  const MontyHallLevel({
    required this.levelNumber,
    required this.title,
    required this.doorCount,
    required this.explanationText,
  });

  final int levelNumber;
  final String title;
  final int doorCount;
  final String explanationText;

  /// Doors the host opens after the first pick (all but the chosen + one other).
  int get doorsToEliminate => doorCount - 2;
}

const List<MontyHallLevel> montyHallLevels = [
  MontyHallLevel(
    levelNumber: 1,
    title: 'Level 1',
    doorCount: 3,
    explanationText:
        'Your first pick had a 1 in 3 chance. The other unopened door now '
        'carries the combined odds of the doors the host opened.',
  ),
  MontyHallLevel(
    levelNumber: 2,
    title: 'Level 2',
    doorCount: 5,
    explanationText:
        'With 5 doors your first pick is right only 1 in 5 times. Switching '
        'gives you the remaining 4 in 5.',
  ),
  MontyHallLevel(
    levelNumber: 3,
    title: 'Level 3',
    doorCount: 10,
    explanationText:
        'With 10 doors, staying wins 1 in 10 times. Switching wins 9 in 10.',
  ),
  MontyHallLevel(
    levelNumber: 4,
    title: 'Level 4',
    doorCount: 30,
    explanationText:
        'With 30 doors, your first choice had only a 1 in 30 chance. The '
        'remaining unopened door carries the probability of all 29 others.',
  ),
];
