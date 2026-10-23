import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:squizhy_app/main.dart';
import 'package:squizhy_app/providers/quiz_provider.dart';

void main() {
  testWidgets('Squizhy welcome screen displays correctly', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => QuizProvider(),
        child: const SquizhyApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Squizhy'), findsNothing);
    expect(find.text('Make every answer count.'), findsOneWidget);
    expect(find.text('Start Quiz'), findsOneWidget);
    expect(find.text('About'), findsOneWidget);
  });
}
