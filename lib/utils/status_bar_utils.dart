import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void setLightStatusBar() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark, // For Android
      statusBarBrightness: Brightness.light, // For iOS
    ),
  );
}

void setDarkStatusBar() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light, // For Android
      statusBarBrightness: Brightness.dark, // For iOS
    ),
  );
}
