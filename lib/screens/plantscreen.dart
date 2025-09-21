import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plant_app/providers/plantprovider.dart';
import '../widgets/plantcard.dart';
import 'package:google_fonts/google_fonts.dart';
class PlantScreen extends ConsumerWidget {

  const PlantScreen({super.key});




  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final demoPlants = ref.watch(plantProvider);
    if (demoPlants.isEmpty) {
      return const Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.local_florist,
                size: 100,
                color: Colors.green,
              ),
              SizedBox(height: 20),
              Text(
                'Non ci sono piante ancora!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Scatta una foto alle tua piante e inizia!.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.green,
                ),
                textAlign: TextAlign.center,
              ),

            ],
          ),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
       centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "App prova",
          textAlign: TextAlign.center,
          style:  GoogleFonts.roboto(
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
      ),
      body: SafeArea(

          child: ListView.separated(
            padding: const EdgeInsets.only(top:10),
            itemCount: demoPlants.length,
            itemBuilder: (context,index) {
              final currentPlant = demoPlants[index];

              return Dismissible(
                  key: ValueKey(currentPlant.id),
                  direction: DismissDirection.startToEnd,
                  background: Container(
                    color: Colors.white,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.red,),
                  ),
                  onDismissed: (direction){
                    ref.read(plantProvider.notifier).removePlant(currentPlant.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          behavior: SnackBarBehavior.floating,
                          duration: const Duration(seconds: 3),
                          content: const Text("la pianta è stata eliminata"),
                          action:  SnackBarAction(label: 'Annulla',
                              onPressed: () {
                                ref.read(plantProvider.notifier).addPlantAtIndex(currentPlant, index);
                              }
                          ),
                      ),
                    );
                  },
                  child: PlantCard(
                    imageplant: currentPlant.image,
                    scientificName: currentPlant.scientificname,
                    namePlant: currentPlant.name,
                    description: currentPlant.description
                  ),
              );
            },
            separatorBuilder: (context,index) => const Divider(
              thickness: 1,
              color: Colors.black12,
              indent: 16,
              endIndent: 16,
            ),


        ),
      ),
    );

  }


}