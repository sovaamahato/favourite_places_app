import 'dart:io';

import 'package:favourite_places_app/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(path.join(dbPath, 'places.db'),
      onCreate: (db, version) {
    return db.execute(
        'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, lng REAL,address TEXT  )');
  }, version: 1);
  return db;
}

class UserPlaceNotifier extends StateNotifier<List<Place>> {
  UserPlaceNotifier() : super(const []);

  Future<void> loadPlace() async {
    final db = await _getDatabase();
    final data = await db.query('user_places');
    final places = data.map((row) {
      return Place(
        id: row['id'] as String,
        title: row['title'] as String,
        image: File(
          row['image'] as String,
        ),
        location: PlaceLocation(
            latitude: row['lat'] as double,
            longitude: row['lng'] as double,
            address: row['address'] as String),
      );
    }).toList();
    state = places;
  }

  Future<void> addPlace(
      String title, File image, PlaceLocation location) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final filename = path.basename(image.path);
    final copyImage = await image.copy('${appDir.path}/$filename');
    final newPlace = Place(title: title, image: copyImage, location: location);

    final db = await _getDatabase();
    db.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'lng': newPlace.location.longitude,
      'lat': newPlace.location.latitude,
      'address': newPlace.location.address,
    });
    //update the state
    state = [newPlace, ...state];
  }
}

final userPlaceProvider = StateNotifierProvider<UserPlaceNotifier, List<Place>>(
  (ref) => UserPlaceNotifier(),
);
