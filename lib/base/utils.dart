import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void setStatusBar() =>
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      // Use transparent or match your app's background color
      statusBarIconBrightness: Brightness.dark,
      // Use dark icons for light backgrounds
      statusBarBrightness: Brightness.light,
      // Use light brightness for dark backgrounds
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
