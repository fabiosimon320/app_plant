import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:plant_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Integration test bottom navigation', (WidgetTester tester) async {
    app.main(); // lancia l’app vera
    await tester.pumpAndSettle();

    // Simula tap sulle icone della bottom nav
    await tester.tap(find.byIcon(Icons.add_a_photo));
    await tester.pumpAndSettle();
    expect(find.text('Aggiungi pianta'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.calendar_today));
    await tester.pumpAndSettle();
    expect(find.text('Calendario'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.home));
    await tester.pumpAndSettle();
    expect(find.text('Le tue piante'), findsOneWidget);
  });
}