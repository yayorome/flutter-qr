import 'package:flutter/material.dart';
import 'package:qr_sqlite/src/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Reader',
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      routes: getAppRoutes(),
      theme: ThemeData(primaryColor: Colors.teal[400]),
    );
  }
}
