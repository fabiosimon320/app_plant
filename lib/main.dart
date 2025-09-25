import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plant_app/homepage.dart';
import 'package:plant_app/services/geminiservice.dart';
import 'package:plant_app/services/notification_service.dart';


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
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
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Plant App',
      theme: ThemeData(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,

      ),
      home: HomePage(),
    );
  }
}


