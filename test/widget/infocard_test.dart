import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:plant_app/widgets/infocard.dart';

void main() {
  testWidgets('test di info card', (WidgetTester tester) async {


    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: InfoCard(
            icon: Icons.water_drop_outlined,
            title: 'Acqua',
            value: 'Ogni 3 giorni',
              ),
        ),
      ),
    );

    expect(find.text('Acqua'), findsOneWidget);
    expect(find.text('Ogni 3 giorni'), findsOneWidget);
    expect(find.byIcon(Icons.water_drop_outlined), findsOneWidget);

  });
}
