import 'package:flutter/material.dart';

class PlantCard extends StatelessWidget {
  final ImageProvider imageplant;
  final String namePlant;
  final String description;

  const PlantCard({
    super.key,
    required this.imageplant,
    required this.namePlant,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ) ,
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),

      margin: EdgeInsets.only(top: 15, left: 30, right: 30, bottom: 15),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),

              child: Image(
                image: imageplant,
                height: 400,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(height: 6),

          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(namePlant, textAlign: TextAlign.center),
          ),

          const SizedBox(height: 6),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Icon(Icons.water_drop),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Icon(Icons.sunny),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Icon(Icons.thermostat),
                ),
              ],
          ),

          const SizedBox(height: 10),

          Padding(padding: const EdgeInsets.all(15), child: Text(description)),
        ],
      ),
    );
  }
}
