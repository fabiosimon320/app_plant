import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/plant.dart';

class DatabasePlant {


  static final DatabasePlant instance = DatabasePlant._internal();
  factory DatabasePlant() => instance;
  DatabasePlant._internal();

  static Database? _database;


  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }


  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'plants.db');

    Database db = await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
    );

    return db;
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS plants(
        id TEXT PRIMARY KEY,
        name TEXT,
        scientificname TEXT,
        imagepath TEXT,
        description TEXT,
        waterday INTEGER,
        sunlight TEXT,
        soiltype TEXT,
        followed INTEGER
      )
    ''');
  }

  Future<int> insertPlant(Plant plant) async {
    Database db = await database;


    return await db.insert('plants', plant.toMap());
  }

  // Get all plants
  Future<List<Plant>> getPlants() async {

    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'plants',
    );
    return List.generate(maps.length, (i) => Plant(
      id: maps[i]['id'],
      name: maps[i]['name'],
      scientificname: maps[i]['scientificname'],
      imagepath: maps[i]['imagepath'],
      description: maps[i]['description'],
      waterday: maps[i]['waterday'],
      sunlight: maps[i]['sunlight'],
      soiltype: maps[i]['soiltype'],

    )..followed = maps[i]['followed']);
  }

  Future<void> updatePlant(String plantId, int isFollowing) async {

    int value = 1 - isFollowing;
    Database db = await database; // o usa il tuo db già aperto

    try{
      await db.update(
        'plants', // nome tabella
        {'followed': value}, // campo booleano come int
        where: 'id = ?',
        whereArgs: [plantId],
      );

    }catch(e) {
      rethrow;
    }

  }

  Future<void> deletePlant(String plantId) async {
    final db = await database;

    await db.delete('plants', where: 'id = ?', whereArgs: [plantId]);
  }

}


