import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/databaseplant.dart';
import '../models/plant.dart';

class PlantNotifier extends StateNotifier<List<Plant>> {

  PlantNotifier() : super([]){
    loadPlants();
  }

  DatabasePlant databasePlant = DatabasePlant.instance;
  bool isLoading = false;

  Future<void> loadPlants() async {
    try {
      isLoading = true;
      final plants = await databasePlant.getPlants();
      state = plants;
    } catch (e) {
      state = [];
      rethrow;
    } finally {
      isLoading = false;
    }
  }


  void addPlant(Plant plant) {
    state = [...state, plant];
  }

  void addPlantAtIndex(Plant plant, int index){
    final newList = [...state];
    newList.insert(index, plant);
    state = newList;
  }

  void removePlant(String id){
    state = state.where((p) => p.id != id).toList();
  }

  void setPlants(List<Plant> plants) {
    state = plants;
  }

}

  final plantProvider = StateNotifierProvider<PlantNotifier, List<Plant>> ((ref) {
    return PlantNotifier();


  });
