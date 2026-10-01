import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Black status bar icons on a transparent bar.
const SystemUiOverlayStyle lightStatusBarStyle = SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  statusBarIconBrightness: Brightness.dark,
  statusBarBrightness: Brightness.light,
);

/// White status bar icons on a transparent bar.
const SystemUiOverlayStyle darkStatusBarStyle = SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  statusBarIconBrightness: Brightness.light,
  statusBarBrightness: Brightness.dark,
);

void setLightStatusBar() {
  SystemChrome.setSystemUIOverlayStyle(lightStatusBarStyle);
}

void setDarkStatusBar() {
  SystemChrome.setSystemUIOverlayStyle(darkStatusBarStyle);
}
