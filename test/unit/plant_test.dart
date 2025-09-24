import 'package:flutter_test/flutter_test.dart';
import 'package:plant_app/models/plant.dart';

void main() {

  final plant = Plant(
    name: 'Rosa',
    scientificname: 'Roseae Lam.',
    imagepath: 'percorso.jpg',
    description: 'E una rosa',
    waterday: 7,
    sunlight: 'Tanto sole',
    soiltype: 'terriccio',
  );

  test('Test per vedere cambio valore followed', () {
    expect(plant.followed, 0);
    plant.changeFollow();
    expect(plant.followed, 1);
    plant.changeFollow();
    expect(plant.followed, 0);
  });


  test('Test per vedere risultato di toMap', () {
    final map = plant.toMap();
    expect(map['name'], plant.name);
    expect(map['scientificname'], plant.scientificname);
    expect(map['imagepath'], plant.imagepath);
    expect(map['description'], plant.description);
    expect(map['waterday'], plant.waterday);
    expect(map['sunlight'], plant.sunlight);
    expect(map['soiltype'], plant.soiltype);
    expect(map['followed'], 0);
    expect(map['id'], plant.id);
  });


}