import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchWeb(url) async {
  try {
    await launchUrl(url);
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}
