import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plant_app/providers/plantprovider.dart';
import '../models/plant.dart';

class FollowedPlantsNotifier extends StateNotifier<Set<String>>{

  FollowedPlantsNotifier() : super({});

  void followPlant(Plant plant) {

    if(state.contains(plant.id)) {
      state = {...state}..remove(plant.id);
    } else {
      state = {...state, plant.id};
    }

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