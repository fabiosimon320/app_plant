import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plant_app/homepage.dart';
import 'package:plant_app/services/geminiservice.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Gemini().initGemini();
  runApp(
      ProviderScope(
          child: const MyApp()
      ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}


