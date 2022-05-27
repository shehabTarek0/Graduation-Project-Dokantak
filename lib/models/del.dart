// ignore_for_file: deprecated_member_use

/* class del {
  bool? status;
  String? message;
  bool? wished;

  del({this.status, this.message, this.wished});

  del.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    wished = json['wished'];
  }
}
 */

import 'package:url_launcher/url_launcher.dart';

class MapUtils {
  MapUtils._();

  static Future<void> openmap(double lat, double lng) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&qeuery=$lat,$lng';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}
