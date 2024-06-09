import 'package:carroforte/models/car_register.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

class RegisterCarController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController modelo = TextEditingController();
  TextEditingController ano = TextEditingController();
  TextEditingController cor = TextEditingController();
  TextEditingController quilometragem = TextEditingController();
  TextEditingController placa = TextEditingController();
  TextEditingController proprietario = TextEditingController();

  Future<bool> onCreateCar() async {
    try {
      if (formKey.currentState!.validate()) {
        CarRegister newCar = CarRegister(
          modelo: modelo.text,
          ano: int.parse(ano.text),
          cor: cor.text,
          quilometragem: int.parse(quilometragem.text),
          placa: placa.text,
          proprietario: proprietario.text,
        );
        await insertCar(newCar);
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> insertCar(CarRegister car) async {
    final db = await openDatabase(
      join(await getDatabasesPath(), 'carsDataBase.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE cars(id INTEGER PRIMARY KEY AUTOINCREMENT, modelo TEXT, ano INTEGER, cor TEXT, quilometragem INTEGER, placa TEXT, proprietario TEXT)',
        );
      },
      version: 1,
    );

    await db.insert(
      'cars',
      car.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
