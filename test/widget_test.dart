import 'package:flutter_test/flutter_test.dart';
import 'package:plexus_trio/main.dart';

void main() {
  testWidgets('App shows core-ready placeholder text', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Plexus Trio Core Ready'), findsOneWidget);
  });
}
