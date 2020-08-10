import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_sqlite/src/model/scan_model.dart';
import 'package:sqflite/sqflite.dart';

export 'package:qr_sqlite/src/model/scan_model.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'scans.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Scans('
          'uid INTEGER PRIMARY KEY,'
          'type TEXT,'
          'value TEXT'
          ')');
    });
  }

  newScanRaw(ScanModel scanModel) async {
    final db = await database;
    final res = await db.rawInsert("INSERT INTO Scans (uid, type, value) "
        "VALUES (${scanModel.uid}, '${scanModel.type}', '${scanModel.value}')");
    return res;
  }

  newScan(ScanModel scanModel) async {
    final db = await database;
    final res = await db.insert('Scans', scanModel.toJson());
    return res;
  }

  Future<List<ScanModel>> selectScans() async {
    final db = await database;
    final res = await db.query('Scans');
    List<ScanModel> resList =
        res.isNotEmpty ? res.map((c) => ScanModel.fromJson(c)).toList() : [];

    return resList;
  }

  selectScanbyUid(int uid) async {
    final db = await database;
    final res = await db.query('Scans', where: 'uid = ?', whereArgs: [uid]);
    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  selectScanbyType(String type) async {
    final db = await database;
    final res = await db.query('Scans', where: 'type = ?', whereArgs: [type]);
    List<ScanModel> resList = res.isNotEmpty
        ? res.map((scan) => ScanModel.fromJson(scan)).toList()
        : [];

    return resList;
  }

  selectScanbyValue(String value) async {
    final db = await database;
    final res = await db.query('Scans', where: 'value = ?', whereArgs: [value]);
    List<ScanModel> resList = res.isNotEmpty
        ? res.map((scan) => ScanModel.fromJson(scan)).toList()
        : [];

    return resList;
  }

  updateScan(ScanModel scanModel) async {
    final db = await database;
    final res = await db.update('Scans', scanModel.toJson(),
        where: 'uid = ?', whereArgs: [scanModel.uid]);
    return res;
  }

  deleteScanbyUid(int uid) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'uid = ?', whereArgs: [uid]);
    return res;
  }

  deleteAllScans() async {
    final db = await database;
    final res = await db.delete('Scans');
    return res;
  }
}
