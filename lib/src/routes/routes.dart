import 'package:flutter/material.dart';
import 'package:qr_sqlite/src/pages/directions_page.dart';
import 'package:qr_sqlite/src/pages/home_page.dart';
import 'package:qr_sqlite/src/pages/maps_page.dart';

Map<String, WidgetBuilder> getAppRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => HomePage(),
    'maps': (BuildContext context) => MapsPage(),
    'directions': (BuildContext context) => DirectionsPage(),
  };
}
