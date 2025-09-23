import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<String?> identifyPlant(File imageFile) async {
  final apiKey  = dotenv.env['API_PLANT_KEY'];
  if(apiKey == null) {
    stderr.writeln('No gemini api key');
    exit(1);
  }

  // Converti l’immagine in Base64
  final base64Image = base64Encode(await imageFile.readAsBytes());

  final response = await http.post(
    Uri.parse("https://plant.id/api/v3/identification"),
    headers: {
      "Content-Type": "application/json",
      "Api-Key": apiKey,
    },
    body: jsonEncode({
      "images": [base64Image],
    }),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    final data = jsonDecode(response.body);
    final suggestions = data["result"]["classification"]["suggestions"];
    if (suggestions != null && suggestions.isNotEmpty) {
      final bestMatch = suggestions[0];

      return bestMatch["name"];

    }

  } else {

    return null;
  }
  return null;
}