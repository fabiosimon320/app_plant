import 'package:flutter/material.dart';
import 'package:plant_app/widgets/plantcard.dart';

import '../models/plant.dart';

class PlantScreen extends StatelessWidget {
  PlantScreen({super.key});


  final List<Plant> plants = [
    const Plant(
        name: 'rosa1',
        image: NetworkImage( 'https://plus.unsplash.com/premium_photo-1675864663002-c330710c6ba0?q=80&w=987&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
        description: 'description'),
    const Plant(
        name: 'rosa2',
        image: NetworkImage( 'https://plus.unsplash.com/premium_photo-1675864663002-c330710c6ba0?q=80&w=987&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
        description: 'description'),
    const Plant(
        name: 'rosa3',
        image: NetworkImage( 'https://plus.unsplash.com/premium_photo-1675864663002-c330710c6ba0?q=80&w=987&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
        description: 'description'),
    const Plant(
        name: 'rosa4',
        image: NetworkImage( 'https://plus.unsplash.com/premium_photo-1675864663002-c330710c6ba0?q=80&w=987&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
        description: 'description'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 171, 211, 137),
      body: SafeArea(
          child: PageView.builder(
            itemCount: null,
            itemBuilder: (context, index){
                final int realIndex = index % plants.length;
                final Plant currentPlant = plants[realIndex];
                return PlantCard(
                    imageplant: currentPlant.image,
                    namePlant: currentPlant.name,
                    description: currentPlant.description);
              }
            )
          )
      );
  }


}