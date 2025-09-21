import 'dart:io';
import 'dart:typed_data';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Gemini {
  static final Gemini _instance = Gemini._internal();

  Gemini._internal();

  factory Gemini(){
    return _instance;
  }

  late GenerativeModel _model;

  Future<void> initGemini() async {
    await dotenv.load(fileName: ".env");

    final apiKey = dotenv.env['API_KEY'];
    if(apiKey == null) {
      stderr.writeln('No gemini api key');
      exit(1);
    }

    _model = GenerativeModel(
        model:'gemini-1.5-flash',
        apiKey: apiKey,
        generationConfig: GenerationConfig(temperature: 0.5, maxOutputTokens: 500)
    );
  }

  GenerativeModel get model => _model;

  Future<String> getPlantInformation(Uint8List imageData) async {
    Gemini gemini = Gemini();
    GenerativeModel model = gemini.model;

    var prompt = '''
      You are a highly knowledgeable botanical expert.
      Your task is to identify the plant shown in the provided image and provide a detailed summary.

      **IMPORTANT:** Generate ONLY the JSON object below.
      Do NOT include explanations, backticks, markdown,
      or any extra text.
      Do not add ```json, markdown, explanations, or any text outside the JSON
      {
        "plant_name": {
          "common": "string",
          "scientific": "string"
        },
        "description": "string"
      }

      - For `plant_name.common`, provide the common name.
      - For `plant_name.scientific`, provide the scientific name.
      - For `description`, provide a comprehensive description suitable 
        for a plant enthusiast. The description should include details on its 
        appearance, typical size, and key features (e.g., leaves, flowers,
         fruit) along with any unique facts or curiosities.
         Do not include any text or 
        conversation outside of the JSON object.
    ''';

    final content = [
      Content.text(prompt),
    Content.data('image/jpeg', imageData),
    ];
    final response = await model.generateContent(content);
    return response.text?.trim() ?? '{"Error": "Nessuna risposta dal modello"}';



  }


}