import 'package:flutter_test/flutter_test.dart';
import 'package:plant_app/models/plant.dart';
import 'package:flutter/material.dart';
import 'package:plant_app/widgets/infocard.dart';

void main() {
  testWidgets('test di info card', (WidgetTester tester) async {
    final plant = Plant(
      name: 'Rosa',
      scientificname: 'Roseae Lam',
      imagepath: 'assets/images/sfondocalendario.png',
      description: 'E una rosa',
      waterday: 7,
      sunlight: 'Tanto sole',
      soiltype: 'terriccio',
    );

    // Costruisci il widget
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
