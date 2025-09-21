import 'package:flutter/material.dart';

class PlantCard extends StatelessWidget {
  final ImageProvider imageplant;
  final String namePlant;
  final String scientificName;
  final String description;

  const PlantCard({
    super.key,
    required this.imageplant,
    required this.scientificName,
    required this.namePlant,
    required this.description,
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
                    image: imageplant,
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
                      namePlant,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      scientificName,
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
                  // azione quando clicchi
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