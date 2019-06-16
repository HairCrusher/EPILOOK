import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'SerialModel.dart';
import 'package:http/http.dart' show get;

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'Serials.db');
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE Serials ("
              "id INTEGER PRIMARY KEY, "
              "title TEXT, "
              "desc TEXT, "
              "poster TEXT, "
              "season INTEGER, "
              "episode INTEGER, "
              "fav BIT"
              ")");
        },
        onUpgrade: (Database db, int oldVersion, int newVersion) {

        }
    );
  }


  newSerial(Serial serial, {File localFile}) async {
    final db = await database;

    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String timeStamp = new DateTime.now().millisecondsSinceEpoch.toString();
    String fileName = '$timeStamp.jpg';
    String dirPath = '${documentsDirectory.path}/images';

    await Directory(dirPath).create(recursive: true);

    String filePath = '$dirPath/$fileName';

    if(localFile == null) {
      var image = await get(serial.poster);

      File file = new File(filePath);

      await file.writeAsBytes(image.bodyBytes);
    }else{
      await localFile.copy(filePath);
    }

    serial.poster = filePath;

    print(serial);

    var res = await db.insert('Serials', serial.toMap());
    return res;
  }

  getSerial(int id) async {
    final db = await database;
    var res = await db.query('Serials', where: "id = ?", whereArgs: [id]);
    print(res);
    return res.isNotEmpty ? Serial.fromMap(res.first) : null;
  }

  Future<List<Serial>> getAllSerials() async {
    final db = await database;
    var res = await db.query('Serials', orderBy: 'id DESC');
    List<Serial> list =
        res.isNotEmpty ? res.map((c) => Serial.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<Serial>> getFavSerials() async {
    final db = await database;
    var res = await db.query('Serials', where: "fav = ?", whereArgs: [1], orderBy: 'id DESC');
    List<Serial> list =
        res.isNotEmpty ? res.map((c) => Serial.fromMap(c)).toList() : [];
    return list;
  }

  changeSerialFav(int id, bool fav) async {
    final db = await database;

    var res = db.update('Serials', {'fav': fav},
        where: "id = ?", whereArgs: [id]);
    return res;
  }

  changeSerialEp(int id, int episode) async {
    final db = await database;

    var res = db.update('Serials', {'episode': episode},
        where: "id = ?", whereArgs: [id]);
    return res;
  }

  changeSerialSe(int id, int season) async {
    final db = await database;

    var res = db.update('Serials', {'season': season},
        where: "id = ?", whereArgs: [id]);
    return res;
  }

  deleteSerial(Serial serial) async {
    final db = await database;
    db.delete("Serials", where: "id = ?", whereArgs: [serial.id]);

    File file = File(serial.poster);
    await file.delete();
  }

  deleteAllSerials() async {
    final db = await database;
    db.rawDelete("DELETE FROM Serials");
  }

  getColumns() async {
    final db = await database;

//    db.close();

    db.query('Serials').then((res) {
      debugPrint(res.toString());
    });
//    return res;
  }

  dropTable() async {
    final db = await database;
    db.rawQuery('DROP TABLE Serials');
//    return res;
  }
}
