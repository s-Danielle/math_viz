import 'package:flutter_test/flutter_test.dart';
import 'package:math_viz/main.dart';

void main() {
  testWidgets('shows placeholder home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MathVizApp());

    expect(find.text('Math Viz'), findsOneWidget);
    expect(find.text('Visual math simulations'), findsOneWidget);
  });
}
