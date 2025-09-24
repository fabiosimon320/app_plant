import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plant_app/models/plant.dart';
import 'package:plant_app/screens/profileplant.dart';
import 'package:plant_app/widgets/plantcard.dart';

void main() {
  testWidgets('test di plant card', (WidgetTester tester) async {
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
          body: PlantCard(plant: plant),
        ),
      ),
    );

    expect(find.text('Rosa'), findsOneWidget);
    expect(find.text('Roseae Lam'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_forward), findsOneWidget);

  });
}
