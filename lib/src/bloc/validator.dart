import 'dart:async';

import 'package:qr_sqlite/src/model/scan_model.dart';

class Validators {
  final validateGeo =
      StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
    handleData: (data, sink) {
      final geoScans = data.where((element) => element.type == 'geo').toList();
      sink.add(geoScans);
    },
  );

  final validateHttp =
      StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
    handleData: (data, sink) {
      final httpScans =
          data.where((element) => element.type == 'http').toList();
      sink.add(httpScans);
    },
  );
}
