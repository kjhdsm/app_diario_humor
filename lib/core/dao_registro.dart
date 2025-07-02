import 'package:sqflite/sqflite.dart';

import '../../models/registro_model.dart';
import 'database.dart';

class RegistroDao {

  Future<int> inserirRegistro(registroModel registro) async {
    final db = await AppDataBase.database;
    print('IMAGEM:' + registro.imagePath.toString());
    return await db.insert(
        'registros',
        registro.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<registroModel>> listarRegistros() async {
    final db = await AppDataBase.database;
    final List<Map<String, dynamic>> maps = await db.query(
        'registros',
        orderBy: 'date DESC');

    return List.generate(
        maps.length,
        (i) => registroModel.fromMap(maps[i]));
  }

  Future<int> atualizarRegistro(registroModel registro) async {
    final db = await AppDataBase.database;
    return await db.update(
      'registros',
      registro.toMap(),
      where: 'date = ?',
      whereArgs: [registro.data.toIso8601String()],
    );
  }

  Future<int> deletarRegistro(DateTime data) async {
    final db = await AppDataBase.database;
    return await db.delete(
      'registros',
      where: 'date = ?',
      whereArgs: [data.toIso8601String()],
    );
  }
}
