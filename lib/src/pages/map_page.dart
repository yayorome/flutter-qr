import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:qr_sqlite/src/model/scan_model.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final MapController mapController = MapController();

  String mapType = 'streets';

  @override
  Widget build(BuildContext context) {
    final ScanModel scanModel = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.my_location),
              onPressed: () {
                mapController.move(scanModel.getLatLng(), 15);
              })
        ],
      ),
      body: _createMap(scanModel),
      floatingActionButton: _createFloatingButton(context),
    );
  }

  _createMap(ScanModel scanModel) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(center: scanModel.getLatLng(), zoom: 15),
      layers: [_createLayers(), _createMarkers(scanModel)],
    );
  }

  _createLayers() {
    return TileLayerOptions(
        urlTemplate: 'https://api.tiles.mapbox.com/v4/'
            '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
        additionalOptions: {
          'accessToken':
              'pk.eyJ1Ijoiam9yZ2VncmVnb3J5IiwiYSI6ImNrODk5aXE5cjA0c2wzZ3BjcTA0NGs3YjcifQ.H9LcQyP_-G9sxhaT5YbVow',
          'id': 'mapbox.$mapType'
        });
  }

  _createMarkers(ScanModel scanModel) {
    return MarkerLayerOptions(markers: <Marker>[
      Marker(
        width: 100,
        height: 100,
        point: scanModel.getLatLng(),
        builder: (context) => Container(
          child: Icon(
            Icons.location_on,
            size: 45,
            color: Theme.of(context).primaryColor,
          ),
        ),
      )
    ]);
  }

  Widget _createFloatingButton(BuildContext context) {
    return FloatingActionButton(
        child: Icon(Icons.repeat),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          switch (mapType) {
            case 'streets':
              mapType = 'dark';
              break;
            case 'dark':
              mapType = 'light';
              break;
            case 'light':
              mapType = 'outdoors';
              break;
            case 'outdoors':
              mapType = 'satellite';
              break;
            case 'satellite':
              mapType = 'streets';
              break;
            default:
              mapType = 'streets';
          }

          setState(() {});
        });
  }
}
