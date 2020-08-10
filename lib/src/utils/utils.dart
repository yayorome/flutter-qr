import 'package:qr_sqlite/src/model/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

launchScan(ScanModel scan) async {
  if (scan.type == 'http') {
    if (await canLaunch(scan.value)) {
      await launch(scan.value);
    } else {
      throw 'Could not launch ${scan.value}';
    }
  } else {
    print('Geo ${scan.value}');
  }
}
