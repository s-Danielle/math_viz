import 'package:flutter_test/flutter_test.dart';
import 'package:math_viz/app.dart';
import 'package:math_viz/core/settings/settings_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('shows Paradox Lab home screen', (WidgetTester tester) async {
    final settings = await SettingsController.create();

    await tester.pumpWidget(ParadoxLabApp(settings: settings));
    await tester.pumpAndSettle();

    expect(find.text('Paradox Lab'), findsOneWidget);
    expect(find.text('Test your intuition.\nBreak your assumptions.'), findsOneWidget);
    expect(find.text('Play'), findsOneWidget);
  });

  testWidgets('Play button navigates to paradox selection', (WidgetTester tester) async {
    final settings = await SettingsController.create();

    await tester.pumpWidget(ParadoxLabApp(settings: settings));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Play'));
    await tester.pumpAndSettle();

    expect(find.text('Paradoxes will be found here.'), findsOneWidget);
  });
}
