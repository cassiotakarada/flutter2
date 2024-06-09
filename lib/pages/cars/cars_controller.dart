import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CarsController {
  Future<List<Map<String, dynamic>>?> getCars() async {
    try {
      final db = await openDatabase(
        join(await getDatabasesPath(), 'carsDataBase.db'),
      );

      final List<Map<String, dynamic>>? cars = await db.query('cars');
      return cars;
    } catch (e) {
      return null;
    }
  }
}
