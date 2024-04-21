import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum ScreenType { desktop, tablet, handset, watch }

class FormFactor {
  static double desktop = 900;
  static double tablet = 600;
  static double handset = 300;

  bool get isMobileDevice => !kIsWeb && (Platform.isIOS || Platform.isAndroid);
  bool get isDesktopDevice =>
      !kIsWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux);
  bool get isMobileDeviceOrWeb => kIsWeb || isMobileDevice;
  bool get isDesktopDeviceOrWeb => kIsWeb || isDesktopDevice;

  ScreenType getFormFactor(BuildContext context) {
    // Use .shortestSide to detect device type regardless of orientation
    double deviceWidth = MediaQuery.of(context).size.width;
    if (deviceWidth > FormFactor.desktop) return ScreenType.desktop;
    if (deviceWidth > FormFactor.tablet) return ScreenType.tablet;
    if (deviceWidth > FormFactor.handset) return ScreenType.handset;
    return ScreenType.watch;
  }
}
