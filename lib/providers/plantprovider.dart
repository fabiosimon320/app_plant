import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/plant.dart';

class PlantNotifier extends StateNotifier<List<Plant>> {

  PlantNotifier() : super([
  Plant(
  name: "Rosa",
  scientificname: "Rosa rubiginosa",
  image: const NetworkImage(
  "https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=600",
  ),
        description:
  "La rosa è una pianta ornamentale molto amata, con fiori eleganti e profumati. Cresce in cespugli di dimensioni variabili e produce petali dai colori che vanno dal bianco al rosso intenso.",
  ),
  Plant(
  name: "Girasole",
  scientificname: "Helianthus annuus",
  image: const NetworkImage(
  "https://images.unsplash.com/photo-1504595403659-9088ce801e29?w=600",
  ),
  description:
  "Il girasole è caratterizzato da grandi fiori gialli che seguono il sole durante il giorno. Può raggiungere i 3 metri di altezza ed è coltivato anche per i suoi semi commestibili.",
  ),
  Plant(
  name: "Lavanda",
  scientificname: "Lavandula angustifolia",
  image: const NetworkImage(
  "https://images.unsplash.com/photo-1501004318641-b39e6451bec6?w=600",
  ),
  description:
  "La lavanda è una pianta aromatica con fiori viola intensi e profumati. Viene spesso usata per oli essenziali, profumi e tisane. Predilige climi caldi e terreni ben drenati.",
  ),
  Plant(
  name: "Rosa",
  scientificname: "Rosa rubiginosa",
  image: const NetworkImage(
  "https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=600",
  ),
  description:
  "La rosa è una pianta ornamentale molto amata, con fiori eleganti e profumati. Cresce in cespugli di dimensioni variabili e produce petali dai colori che vanno dal bianco al rosso intenso.",
  ),
  Plant(
  name: "Girasole",
  scientificname: "Helianthus annuus",
  image: const NetworkImage(
  "https://images.unsplash.com/photo-1504595403659-9088ce801e29?w=600",
  ),
  description:
  "Il girasole è caratterizzato da grandi fiori gialli che seguono il sole durante il giorno. Può raggiungere i 3 metri di altezza ed è coltivato anche per i suoi semi commestibili.",
  ),
  Plant(
  name: "Lavanda",
  scientificname: "Lavandula angustifolia",
  image: const NetworkImage(
  "https://images.unsplash.com/photo-1501004318641-b39e6451bec6?w=600",
  ),
  description:
  "La lavanda è una pianta aromatica con fiori viola intensi e profumati. Viene spesso usata per oli essenziali, profumi e tisane. Predilige climi caldi e terreni ben drenati.",
  ),
  Plant(
  name: "Rosa",
  scientificname: "Rosa rubiginosa",
  image: const NetworkImage(
  "https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=600",
  ),
  description:
  "La rosa è una pianta ornamentale molto amata, con fiori eleganti e profumati. Cresce in cespugli di dimensioni variabili e produce petali dai colori che vanno dal bianco al rosso intenso.",
  ),
  Plant(
  name: "Girasole",
  scientificname: "Helianthus annuus",
  image: const NetworkImage(
  "https://images.unsplash.com/photo-1504595403659-9088ce801e29?w=600",
  ),
  description:
  "Il girasole è caratterizzato da grandi fiori gialli che seguono il sole durante il giorno. Può raggiungere i 3 metri di altezza ed è coltivato anche per i suoi semi commestibili.",
  ),
  Plant(
  name: "Lavanda",
  scientificname: "Lavandula angustifolia",
  image: const NetworkImage(
  "https://images.unsplash.com/photo-1501004318641-b39e6451bec6?w=600",
  ),
  description:
  "La lavanda è una pianta aromatica con fiori viola intensi e profumati. Viene spesso usata per oli essenziali, profumi e tisane. Predilige climi caldi e terreni ben drenati.",
  ),


  ]);

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
