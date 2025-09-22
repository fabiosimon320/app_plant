import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/plant.dart';

class PlantNotifier extends StateNotifier<List<Plant>> {

  PlantNotifier() : super([
  Plant(
  name: "Rosa",
  scientificname: "Rosa rubiginosa",
  description:
  "La Rosa rubiginosa è una pianta arbustiva decidua che cresce fino a 2-3 metri. "
  "Presenta rami spinosi, foglie composte e fiori profumati di colore rosa chiaro, "
  "seguiti da frutti rossi chiamati cinorrodi. Fiorisce tra primavera e estate ed è apprezzata "
  "per la sua bellezza e il profumo intenso.",
  waterday: 3, // ogni 3 giorni
  sunlight: "Luce indiretta o parziale", // esposizione ideale
  soiltype: "Ben drenato, leggermente acido o neutro blablalbalbalbalbalbalbalblablabal", // tipo di terreno
  image: const NetworkImage(
  "https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=600",
    ),
  ),
  Plant(
  name: "Ficus",
  scientificname: "Ficus elastica",
  description:
  "Il Ficus elastica è una pianta sempreverde con foglie grandi, lucide e coriacee. "
  "Può raggiungere diversi metri in altezza se coltivato in vaso o in terra.",
  waterday: 7,
  sunlight: "Luce indiretta",
  soiltype: "Terriccio universale ben drenato",
  image: const NetworkImage(
  "https://images.unsplash.com/photo-1570129477492-45c003edd2be?w=600"),
  ),
    Plant(
      name: "Rosa",
      scientificname: "Rosa rubiginosa",
      description:
      "La Rosa rubiginosa è una pianta arbustiva decidua che cresce fino a 2-3 metri. "
          "Presenta rami spinosi, foglie composte e fiori profumati di colore rosa chiaro, "
          "seguiti da frutti rossi chiamati cinorrodi. Fiorisce tra primavera e estate ed è apprezzata "
          "per la sua bellezza e il profumo intenso.",
      waterday: 3, // ogni 3 giorni
      sunlight: "Luce indiretta o parziale", // esposizione ideale
      soiltype: "Ben drenato, leggermente acido o neutro", // tipo di terreno
      image: const NetworkImage(
        "https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=600",
      ),
    ),
    Plant(
      name: "Ficus",
      scientificname: "Ficus elastica",
      description:
      "Il Ficus elastica è una pianta sempreverde con foglie grandi, lucide e coriacee. "
          "Può raggiungere diversi metri in altezza se coltivato in vaso o in terra.",
      waterday: 7,
      sunlight: "Luce indiretta",
      soiltype: "Terriccio universale ben drenato",
      image: const NetworkImage(
          "https://images.unsplash.com/photo-1570129477492-45c003edd2be?w=600"),
    ),
    Plant(
      name: "Rosa",
      scientificname: "Rosa rubiginosa",
      description:
      "La Rosa rubiginosa è una pianta arbustiva decidua che cresce fino a 2-3 metri. "
          "Presenta rami spinosi, foglie composte e fiori profumati di colore rosa chiaro, "
          "seguiti da frutti rossi chiamati cinorrodi. Fiorisce tra primavera e estate ed è apprezzata "
          "per la sua bellezza e il profumo intenso.",
      waterday: 3, // ogni 3 giorni
      sunlight: "Luce indiretta o parziale", // esposizione ideale
      soiltype: "Ben drenato, leggermente acido o neutro", // tipo di terreno
      image: const NetworkImage(
        "https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=600",
      ),
    ),
    Plant(
      name: "Ficus",
      scientificname: "Ficus elastica",
      description:
      "Il Ficus elastica è una pianta sempreverde con foglie grandi, lucide e coriacee. "
          "Può raggiungere diversi metri in altezza se coltivato in vaso o in terra.",
      waterday: 7,
      sunlight: "Luce indiretta",
      soiltype: "Terriccio universale ben drenato",
      image: const NetworkImage(
          "https://images.unsplash.com/photo-1570129477492-45c003edd2be?w=600"),
    ),
    Plant(
      name: "Rosa",
      scientificname: "Rosa rubiginosa",
      description:
      "La Rosa rubiginosa è una pianta arbustiva decidua che cresce fino a 2-3 metri. "
          "Presenta rami spinosi, foglie composte e fiori profumati di colore rosa chiaro, "
          "seguiti da frutti rossi chiamati cinorrodi. Fiorisce tra primavera e estate ed è apprezzata "
          "per la sua bellezza e il profumo intenso.",
      waterday: 3, // ogni 3 giorni
      sunlight: "Luce indiretta o parziale", // esposizione ideale
      soiltype: "Ben drenato, leggermente acido o neutro", // tipo di terreno
      image: const NetworkImage(
        "https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=600",
      ),
    ),
    Plant(
      name: "Ficus",
      scientificname: "Ficus elastica",
      description:
      "Il Ficus elastica è una pianta sempreverde con foglie grandi, lucide e coriacee. "
          "Può raggiungere diversi metri in altezza se coltivato in vaso o in terra.",
      waterday: 7,
      sunlight: "Luce indiretta",
      soiltype: "Terriccio universale ben drenato",
      image: const NetworkImage(
          "https://images.unsplash.com/photo-1570129477492-45c003edd2be?w=600"),
    ),
    Plant(
      name: "Rosa",
      scientificname: "Rosa rubiginosa",
      description:
      "La Rosa rubiginosa è una pianta arbustiva decidua che cresce fino a 2-3 metri. "
          "Presenta rami spinosi, foglie composte e fiori profumati di colore rosa chiaro, "
          "seguiti da frutti rossi chiamati cinorrodi. Fiorisce tra primavera e estate ed è apprezzata "
          "per la sua bellezza e il profumo intenso.",
      waterday: 3, // ogni 3 giorni
      sunlight: "Luce indiretta o parziale", // esposizione ideale
      soiltype: "Ben drenato, leggermente acido o neutro", // tipo di terreno
      image: const NetworkImage(
        "https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=600",
      ),
    ),
    Plant(
      name: "Ficus",
      scientificname: "Ficus elastica",
      description:
      "Il Ficus elastica è una pianta sempreverde con foglie grandi, lucide e coriacee. "
          "Può raggiungere diversi metri in altezza se coltivato in vaso o in terra.",
      waterday: 7,
      sunlight: "Luce indiretta",
      soiltype: "Terriccio universale ben drenato",
      image: const NetworkImage(
          "https://images.unsplash.com/photo-1570129477492-45c003edd2be?w=600"),
    ),
    Plant(
      name: "Rosa",
      scientificname: "Rosa rubiginosa",
      description:
      "La Rosa rubiginosa è una pianta arbustiva decidua che cresce fino a 2-3 metri. "
          "Presenta rami spinosi, foglie composte e fiori profumati di colore rosa chiaro, "
          "seguiti da frutti rossi chiamati cinorrodi. Fiorisce tra primavera e estate ed è apprezzata "
          "per la sua bellezza e il profumo intenso.",
      waterday: 3, // ogni 3 giorni
      sunlight: "Luce indiretta o parziale", // esposizione ideale
      soiltype: "Ben drenato, leggermente acido o neutro", // tipo di terreno
      image: const NetworkImage(
        "https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=600",
      ),
    ),
    Plant(
      name: "Ficus",
      scientificname: "Ficus elastica",
      description:
      "Il Ficus elastica è una pianta sempreverde con foglie grandi, lucide e coriacee. "
          "Può raggiungere diversi metri in altezza se coltivato in vaso o in terra.",
      waterday: 7,
      sunlight: "Luce indiretta",
      soiltype: "Terriccio universale ben drenato",
      image: const NetworkImage(
          "https://images.unsplash.com/photo-1570129477492-45c003edd2be?w=600"),
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
