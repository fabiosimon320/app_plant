import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:plant_app/services/geminiservice.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant_app/providers/plantprovider.dart';

import '../models/plant.dart';

class AddPlantScreen extends ConsumerStatefulWidget {
  final PersistentTabController controller;
  const AddPlantScreen({super.key, required this.controller});

  @override
  ConsumerState<AddPlantScreen> createState() => AddPlantScreenState();


}

class AddPlantScreenState extends ConsumerState<AddPlantScreen> {
  File? _selectedImage;
  late String _geminiResponse = 'risposta gemini apparira qui';
  late String plantResponse = 'risposta api';

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

      final Uint8List imageData = await selectedImage.readAsBytes();
      final geminiService = Gemini();
      final String info = await geminiService.getPlantInformation(imageData);
      setState(() {
        _geminiResponse = info;
      });
      print("Risposta Gemini: $info");
      decodeJson(info);
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

     final newPlant = Plant(
       name: commonName,
       scientificname: scientificName,
       description: description,
       image: FileImage(_selectedImage!),
     );

     ref.read(plantProvider.notifier).addPlant(newPlant);
     widget.controller.jumpToTab(0);


  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Quadrato in alto
          Container(
            margin: EdgeInsets.all(30),
            width: MediaQuery.of(context).size.width - 60,
            height: (MediaQuery.of(context).size.width - 60)* 1.33,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              color: Colors.grey.shade400,
            ),
            child: _selectedImage == null
                ? Center(child: Text("Nessuna foto"))
                : Image.file(_selectedImage!, fit: BoxFit.cover, filterQuality: FilterQuality.high),

          ),

          // Bottone in basso
          if( _selectedImage == null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _takePicture,
                child: Text("Scatta Foto"),
              ),
            ),

          SizedBox(height: 20),
          Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(_geminiResponse),
                  )
              ),
          ),


          if(_selectedImage != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedImage = null;
                      _geminiResponse = 'in attesa';
                    });
                  },
                  child: Icon(Icons.refresh),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                  onPressed: _sendPicture,
                  child: Icon(Icons.check),
                  ),
                ),
              ],
            )




        ],
      ),
    );
  }

}