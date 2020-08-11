import 'dart:async';

import 'package:qr_sqlite/src/bloc/validator.dart';
import 'package:qr_sqlite/src/providers/db_provider.dart';

class ScansBloc with Validators {
  static final ScansBloc _scansBloc = new ScansBloc._internal();

  factory ScansBloc() {
    return _scansBloc;
  }

  ScansBloc._internal() {
    getAllScans();
  }

  final _scansController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStream =>
      _scansController.stream.transform(validateGeo);
  Stream<List<ScanModel>> get scansStreamHttp =>
      _scansController.stream.transform(validateHttp);

  getAllScans() async {
    _scansController.sink.add(await DBProvider.db.selectScans());
  }

  insertScan(ScanModel scan) async {
    await DBProvider.db.newScan(scan);
    getAllScans();
  }

  deleteScan(int uid) async {
    await DBProvider.db.deleteScanbyUid(uid);
    getAllScans();
  }

  deleteAllScans() async {
    await DBProvider.db.deleteAllScans();
    getAllScans();
  }

  dispose() {
    _scansController?.close();
  }
}
