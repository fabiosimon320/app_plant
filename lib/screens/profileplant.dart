import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_app/providers/followedplantprovider.dart';
import 'package:plant_app/widgets/infocard.dart';
import 'package:plant_app/widgets/myappbar.dart';

import '../models/plant.dart';

class PlantProfilePage extends ConsumerWidget {
  final Plant plant;

  const PlantProfilePage({super.key, required this.plant});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;

    
    return Scaffold(
      appBar: MyAppBar(title: 'profilo pianta', showBackButton: true),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          children: [
            SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                  File(plant.imagePath),
                  width: screenWidth * 0.8,
                  height: 400,
                  fit: BoxFit.cover
              ),
            ),

            const SizedBox(height: 16),
            Text(
                plant.name,
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  fontSize: 24
                ),
            ),

            const SizedBox(height: 8),
            Text(
              plant.scientificname,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
            ),

            const SizedBox(height: 16),
            Text(
                'Descrizione:',
                style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                ),
            ),

            const SizedBox(height: 4),
            Text(
              plant.description,
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 16),
            Text(
              'Condizioni ideali',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 8),
            InfoCard(
              icon: Icons.thermostat,
              title: 'Acqua',
              value: "Ogni ${plant.waterday} giorni",
            ),
            const SizedBox(height: 8),
            InfoCard(
              icon: Icons.eco_sharp,
              title: 'Tipo di terreno',
              value: plant.soiltype,
            ),
            const SizedBox(height: 8),
            InfoCard(
              icon: Icons.sunny,
              title: 'Esposizione alla luce solare',
              value: plant.sunlight,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 0, 167, 107),
              ),
              onPressed:(){
                ref.read(followedPlantsProvider.notifier).followPlant(plant);
              },
              child: Text(
                ref.watch(followedPlantsProvider).contains(plant.id)
                    ? 'Pianta già seguita'
                    : 'Aggiungi trattamento pianta al calendario!',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ) ,
      ),
    );
  }


}