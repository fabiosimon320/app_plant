import 'package:flutter/material.dart';
import 'package:plant_app/models/plant.dart';
import 'package:plant_app/screens/profileplant.dart';

class PlantCard extends StatelessWidget {
  final Plant plant;

  const PlantCard({
    super.key,
    required this.plant,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Row(
      children: [
        SizedBox( width: screenWidth * 0.07),
        Container(
          width: screenWidth * 0.86,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              // Immagine pianta
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image(
                    image: plant.image,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover
                ),
              ),
              const SizedBox(width: 16),

              // Testi
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    Text(
                      plant.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      plant.scientificname,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),

              // Pulsante freccia
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlantProfilePage(plant: plant),
                    ),
                  );
                },
                icon: Icon(Icons.arrow_forward, color: Colors.black54),
              ),
            ],
          ),
        ),
      ],
    );
  }



}