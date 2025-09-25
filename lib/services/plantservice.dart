import 'dart:convert';
import 'dart:io';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:plant_app/services/plantidapi.dart';
import '../models/plant.dart';
import 'geminiservice.dart';

class PlantService {

  final Gemini geminiService;

  PlantService({required this.geminiService});

  Future<String> saveImage(File image) async {
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    final savedImage = await image.copy('${appDir.path}/$fileName');
    return savedImage.path;
  }


  Future<File?> takePicture() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
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
        return null;
      }

      return  File(pickedImage.path);

    } else if (status.isDenied) {

    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
    return null;
  }

  Future<Plant?> sendPicture(File image) async {

    String? namePlant = await identifyPlant(image);


    if (namePlant != null) {

      try {
        final String info = await geminiService.getPlantInformation(namePlant);
        final savedPath = await saveImage(image);
        Plant plant = decodeJson(info, savedPath);
        return plant;
      } on GenerativeAIException catch (e) {

        return null;
      }




    }
    return null;

  }


  Plant decodeJson(String json, String imagePath) {
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
      imagepath: imagePath,
      waterday: waterDay,
      sunlight: sunLight,
      soiltype: soilType,

    );

    return newPlant;


  }



}

