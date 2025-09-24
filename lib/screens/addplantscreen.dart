import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:plant_app/database/databaseplant.dart';
import 'package:plant_app/services/geminiservice.dart';
import 'package:flutter/material.dart';
import 'package:plant_app/providers/plantprovider.dart';
import 'package:plant_app/services/plantservice.dart';
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
  final plantservice = PlantService(geminiService: Gemini());
  final plantdatabase = DatabasePlant.instance;



  Future<void> takepicture() async {
    File? image = await plantservice.takePicture();
    setState(() {
      _selectedImage = image;
    });
  }

  Future<void> sendPicture() async {

    if( _selectedImage != null) {
      setState(() {
        isLoading = true;
      });
      Plant myplant = Plant(
        name: 'ciao',
        scientificname: 'ciao',
        imagepath: _selectedImage!.path,
        description: 'ciao',
        waterday: 7,
        sunlight: 'ciao',
        soiltype: 'ciao',

      );
      //Plant? plant = await plantservice.sendPicture(_selectedImage!);


      if(myplant != null ) {

        await plantdatabase.insertPlant(myplant);

        ref.read(plantProvider.notifier).addPlant(myplant);
        if(mounted){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Pianta inserita con successo!',
                style: TextStyle(
                  color: Colors.white,
                ),

              ),
              backgroundColor: Color.fromARGB(255, 0, 167, 107),
              duration: Duration(seconds: 2),
            ),
          );


        }
      }else{
        if(mounted){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Errore, non è stato possibile inserire la pianta!',
                style: TextStyle(
                  color: Colors.white,
                ),

              ),
              backgroundColor: Color.fromARGB(255, 0, 0, 0),
              duration: Duration(seconds: 2),
            ),
          );
        }
      }

      setState(() {
        isLoading = false;

      });
    }



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
                    onPressed: takepicture,
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
                        onPressed: (){
                          sendPicture();
                          setState(() {
                            _selectedImage = null;
                          });
                        },
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