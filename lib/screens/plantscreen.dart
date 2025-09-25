import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plant_app/database/databaseplant.dart';
import 'package:plant_app/providers/followedplantprovider.dart';
import 'package:plant_app/providers/plantprovider.dart';
import 'package:plant_app/widgets/myappbar.dart';
import '../widgets/plantcard.dart';

class PlantScreen extends ConsumerStatefulWidget {

  const PlantScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState()  => _PlantScreenState();

}


class _PlantScreenState extends ConsumerState<PlantScreen>{

  bool isLoading = true;
  final plantdatabase = DatabasePlant.instance;


  @override
  void initState() {
    super.initState();
    loadPlants();

  }



  Future<void> loadPlants() async {
    setState(() {
      isLoading = true;
    });
    final plants1 = await DatabasePlant.instance.getPlants();
    ref.read(plantProvider.notifier).setPlants(plants1);
    ref.read(followedPlantsProvider.notifier).initializeFollowed(plants1);
    setState(() {
      isLoading = false;
    });
  }



  @override
  Widget build(BuildContext context) {

    final plants = ref.watch(plantProvider);


    if(isLoading){

      return Scaffold(
          body: Container(
              color: Colors.black.withAlpha(127), // trasparenza
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white, // visibile sullo sfondo scuro
                ),
              ),
            ),
          );

    }else{
      if (plants.isEmpty) {

        return const Scaffold(
          appBar: MyAppBar(title: 'PlantCare'),
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.local_florist,
                  size: 100,
                  color: Color.fromARGB(255, 0, 167, 107),
                ),
                SizedBox(height: 20),
                Text(
                  'Non ci sono piante ancora!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 167, 107),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Scatta una foto alle tua piante e inizia!.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 0, 167, 107),
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
        appBar: MyAppBar(title: 'PlantCare'),
        body: SafeArea(

          child: ListView.separated(
            padding: const EdgeInsets.only(top:10),
            itemCount: plants.length,
            itemBuilder: (context,index) {
              final currentPlant = plants[index];


              return Dismissible(
                key: ValueKey(currentPlant.id),
                direction: DismissDirection.startToEnd,
                background: Container(
                  color: Colors.white,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete, color: Colors.red,),
                ),
                onDismissed: (direction) async {
                  ref.read(plantProvider.notifier).removePlant(currentPlant.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      duration: const Duration(seconds: 2),
                      content: const Text("la pianta è stata eliminata"),
                      action:  SnackBarAction(label: 'Annulla',
                          onPressed: () {
                            ref.read(plantProvider.notifier).addPlantAtIndex(currentPlant, index);
                          }
                      ),
                    ),
                  ).closed.then((reason) async {
                    if(reason != SnackBarClosedReason.action) {
                      await plantdatabase.deletePlant(currentPlant.id);
                    }
                  });





                },


                child: PlantCard(
                  plant: currentPlant,
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


}