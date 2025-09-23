import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/plant.dart';

class PlantNotifier extends StateNotifier<List<Plant>> {

  PlantNotifier() : super([]);

  void addPlant(Plant plant) {
    state = [...state, plant];
  }

  void addPlantAtIndex(Plant plant, int index){
    final newList = [...state];  // copia della lista
    newList.insert(index, plant);
    state = newList;
  }
  
  void removePlant(String id){
    state = state.where((p) => p.id != id).toList();
  }

}

  final plantProvider = StateNotifierProvider<PlantNotifier, List<Plant>> ((ref) {
    return PlantNotifier();


  });
