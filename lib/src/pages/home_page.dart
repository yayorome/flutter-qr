import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_sqlite/src/bloc/scans_bloc.dart';
// import 'package:barcode_scan/barcode_scan.dart';
import 'package:qr_sqlite/src/model/scan_model.dart';

import 'package:qr_sqlite/src/pages/directions_page.dart';
import 'package:qr_sqlite/src/pages/maps_page.dart';
import 'package:qr_sqlite/src/utils/utils.dart' as utils;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;
  final scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.delete_forever),
              onPressed: () {
                scansBloc.deleteAllScans();
              })
        ],
      ),
      body: _loadPage(currentPage),
      bottomNavigationBar: _bottonNavbar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _floatingButton(),
    );
  }

  Widget _loadPage(int actualPage) {
    switch (actualPage) {
      case 0:
        return MapsPage();
      case 1:
        return DirectionsPage();
      default:
        return MapsPage();
    }
  }

  Widget _bottonNavbar() {
    return BottomNavigationBar(
        currentIndex: currentPage,
        onTap: (index) {
          setState(() {
            currentPage = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.map), title: Text('Mapas')),
          BottomNavigationBarItem(
              icon: Icon(Icons.brightness_5), title: Text('Direcciones'))
        ]);
  }

  Widget _floatingButton() {
    return FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: _scanQR);
  }

  _scanQR() async {
    // http://www.yit.com.mx
    final geo = 'geo:40.68675513364264,-73.96748915156253';

    dynamic futureString = 'http://www.yit.com.mx';
    /*try {
      futureString = await BarcodeScanner.scan();
    } catch (e) {
      futureString = e.toString();
    }
    print('Future String: ${futureString.rawContent}'); */

    if (futureString != null) {
      final scan = ScanModel(value: futureString);
      scansBloc.insertScan(scan);

      final scan2 = ScanModel(value: geo);
      scansBloc.insertScan(scan2);

      if (Platform.isIOS) {
        Future.delayed(Duration(milliseconds: 750), () {
          utils.launchScan(scan);
        });
      } else {
        utils.launchScan(scan);
      }
    }
  }
}
