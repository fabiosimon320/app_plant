import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plant_app/database/databaseplant.dart';
import 'package:plant_app/providers/plantprovider.dart';
import '../models/plant.dart';

class FollowedPlantsNotifier extends StateNotifier<Set<String>>{

  DatabasePlant databasePlant = DatabasePlant.instance;
  FollowedPlantsNotifier() : super({});

  void followPlant(Plant plant) {
    plant.changeFollow();
    if(state.contains(plant.id)) {

      state = {...state}..remove(plant.id);
    } else {

      state = {...state, plant.id};
    }

  }

  void initializeFollowed(List<Plant> plants) {

    state = plants.where((p) => p.followed == 1).map((p) => p.id).toSet();
  }


}


final followedPlantsProvider =
StateNotifierProvider<FollowedPlantsNotifier, Set<String>>(
        (ref) => FollowedPlantsNotifier());

final followedPlantsDataProvider = Provider<List<Plant>>((ref) {
  final plants = ref.watch(plantProvider);
  final followedIds = ref.watch(followedPlantsProvider);
  return plants.where((p) => followedIds.contains(p.id)).toList();
});