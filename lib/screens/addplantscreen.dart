import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:plant_app/services/geminiservice.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant_app/providers/plantprovider.dart';
import 'package:plant_app/services/plantidapi.dart';
import 'package:plant_app/widgets/myappbar.dart';
import '../models/plant.dart';

class AddPlantScreen extends ConsumerStatefulWidget {
  final PersistentTabController controller;
  const AddPlantScreen({super.key, required this.controller});

  @override
  ConsumerState<AddPlantScreen> createState() => AddPlantScreenState();


}

class AddPlantScreenState extends ConsumerState<AddPlantScreen> {
  File? _selectedImage;
  bool isLoading = false;

  void _takePicture() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      // Chiede il permesso all'utente
      status = await Permission.camera.request();
    }
    if (status.isGranted) {
      final imagePicker = ImagePicker();
      final pickedImage = await imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 100,
        maxWidth: 600,
      );

      if (pickedImage == null) {
        return;
      }

      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    } else if (status.isDenied) {

    } else if (status.isPermanentlyDenied) {
      openAppSettings(); // Per aprire le impostazioni del dispositivo
    }


  }

  void _sendPicture() async {

    final selectedImage = _selectedImage;
    if(selectedImage != null) {
      setState(() {
        isLoading = true;
      });
      String? namePlant = 'rosa';
      //namePlant = await identifyPlant(selectedImage);


      if(namePlant != null) {
        final geminiService = Gemini();
        final String info = await geminiService.getPlantInformation(namePlant);
        decodeJson(info);

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Pianta inserita con successo!',
                style: GoogleFonts.roboto(fontSize: 12),
              ),
              duration: Duration(seconds: 2),
              backgroundColor: Color.fromARGB(255, 0, 167, 107),
            ),
        );
      }


    }
  }

  void decodeJson(String json) {
    String cleaned = json
        .replaceFirst(RegExp(r'^```json\s*'), '') // inizio
        .replaceFirst(RegExp(r'\s*```$'), '')     // fine
        .trim();

    final Map<String, dynamic> data = jsonDecode(cleaned);

    final String commonName = data['plant_name']['common'];
    final String scientificName = data['plant_name']['scientific'];
    final String description = data['description'];
    final int waterDay = data['care']['watering_interval_days'];
    final String sunLight = data['care']['sunlight'];
    final String soilType = data['care']['soil_type'];

    final newPlant = Plant(
      name: commonName,
      scientificname: scientificName,
      description: description,
      image: FileImage(_selectedImage!),
      waterday: waterDay,
      sunlight: sunLight,
      soiltype: soilType,
    );
    ref.read(plantProvider.notifier).addPlant(newPlant);

    setState(() {
      isLoading = false;
    });


  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: MyAppBar(title: 'Inserisci foto'),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/sfondoschermate.png',
              fit: BoxFit.cover, repeat: ImageRepeat.repeat,
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: kToolbarHeight ), // lascia spazio all'AppBar
              SizedBox(height: 35),
              Center(
                child: Container(

                  width: MediaQuery.of(context).size.width - 100,
                  height: (MediaQuery.of(context).size.width - 100) * 1.33,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 1,
                        blurRadius: 5,
                      )
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: _selectedImage != null
                      ? Image.file(
                          _selectedImage!,
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                        )
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.camera_alt,size: 90, color: Color.fromARGB(255,0,167,107),
                              ),
                            ],
                          ),
                    )
                  ),
                ),
              ),



              // Bottone in basso
              if( _selectedImage == null)
                Padding(
                  padding: const EdgeInsets.only(top:50.0),
                  child: ElevatedButton(
                    onPressed: _takePicture,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 0, 167, 107),
                    ),
                    child: Text(
                      "Scatta Foto",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),

                  ),
                ),


              if(_selectedImage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 0, 167, 107),
                        ),
                        onPressed: () {
                          setState(() {
                            _selectedImage = null;

                          });
                        },
                        child: Icon(Icons.refresh, color: Colors.white),
                      ),

                      SizedBox(width: screenWidth * 0.3), // distanza tra i pulsanti
                      ElevatedButton(

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 0, 167, 107),
                        ),
                        onPressed: _sendPicture,
                        child: Icon(Icons.check, color: Colors.white,),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          if (isLoading)
            Container(
              color: Colors.black.withAlpha(127), // trasparenza
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white, // visibile sullo sfondo scuro
                ),
              ),
            ),

          const SizedBox(height: 15),


        ],
      ),
    );
  }

}