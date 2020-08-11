import 'package:latlong/latlong.dart';

class ScanModel {
  ScanModel({
    this.uid,
    this.type,
    this.value,
  }) {
    if (this.value.contains('http')) {
      this.type = 'http';
    } else {
      this.type = 'geo';
    }
  }

  int uid;
  String type;
  String value;

  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        uid: json["uid"],
        type: json["type"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "type": type,
        "value": value,
      };

  LatLng getLatLng() {
    final latlng = value.substring(4).split(',');
    final lat = double.parse(latlng[0]);
    final lng = double.parse(latlng[1]);

    return LatLng(lat, lng);
  }
}
