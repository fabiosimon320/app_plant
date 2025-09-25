import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_app/providers/followedplantprovider.dart';
import 'package:plant_app/widgets/infocard.dart';
import 'package:plant_app/widgets/myappbar.dart';
import '../database/databaseplant.dart';
import '../models/plant.dart';

class PlantProfilePage extends ConsumerStatefulWidget {
  final Plant plant;

  const PlantProfilePage({super.key, required this.plant});

  @override
  ConsumerState<PlantProfilePage> createState() => PlantProfilePageState();

}

class PlantProfilePageState extends ConsumerState<PlantProfilePage>{

  final plantdatabase = DatabasePlant.instance;


  Future<void> update() async {


    await plantdatabase.updatePlant(widget.plant.id, widget.plant.followed);
    ref.read(followedPlantsProvider.notifier).followPlant(widget.plant);


  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    bool isFollowed = ref.watch(followedPlantsProvider).contains(widget.plant.id);


    return Scaffold(
      appBar: MyAppBar(title: 'profilo pianta', showBackButton: true),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child:Center(
          child: Column(

              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
              SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                  File(widget.plant.imagepath),
                  width: screenWidth * 0.8,
                  height: 400,
                  fit: BoxFit.cover
              ),
            ),

            const SizedBox(height: 16),
            Text(
              widget.plant.name,
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  fontSize: 24
              ),
            ),

            const SizedBox(height: 8),
            Text(
              widget.plant.scientificname,
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
              widget.plant.description,
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
              value: "Ogni ${widget.plant.waterday} giorni",
            ),
            const SizedBox(height: 8),
            InfoCard(
              icon: Icons.eco_sharp,
              title: 'Tipo di terreno',
              value: widget.plant.soiltype,
            ),
            const SizedBox(height: 8),
            InfoCard(
              icon: Icons.sunny,
              title: 'Esposizione alla luce solare',
              value: widget.plant.sunlight,
            ),
            const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 0, 167, 107),
                  ),
                  onPressed: update,
                  child: Text(
                    isFollowed
                        ? 'Pianta già seguita'
                        : 'Aggiungi trattamento pianta al calendario!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      color: Colors.white,


                      )
                    ),
                  ),



            const SizedBox(height: 40),

          ],
        ) ,
      ),
    ),
    );
  }






}