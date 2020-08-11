import 'package:flutter/material.dart';
import 'package:qr_sqlite/src/bloc/scans_bloc.dart';
import 'package:qr_sqlite/src/model/scan_model.dart';
import 'package:qr_sqlite/src/utils/utils.dart' as utils;

class MapsPage extends StatelessWidget {
  final scansBloc = new ScansBloc();
  @override
  Widget build(BuildContext context) {
    scansBloc.getAllScans();
    return StreamBuilder<List<ScanModel>>(
      stream: scansBloc.scansStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final scans = snapshot.data;
        if (scans.length == 0) {
          return Center(child: Text('No hay información'));
        }

        return ListView.builder(
          itemCount: scans.length,
          itemBuilder: (context, index) => Dismissible(
            key: UniqueKey(),
            background: Container(
              color: Colors.red,
            ),
            onDismissed: (direction) => scansBloc.deleteScan(scans[index].uid),
            child: ListTile(
              leading: Icon(
                Icons.map,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(scans[index].value),
              subtitle: Text('ID: ${scans[index].uid}'),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.grey,
              ),
              onTap: () => utils.launchScan(context, scans[index]),
            ),
          ),
        );
      },
    );
  }
}
