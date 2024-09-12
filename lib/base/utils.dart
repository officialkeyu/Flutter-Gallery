import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Sets the status bar and navigation bar styles for the app.
void setStatusBar() {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            // Makes the status bar transparent or matches it to the app's background color.
            statusBarIconBrightness: Brightness.dark,
            // Uses dark icons for light backgrounds in the status bar.
            statusBarBrightness: Brightness.light,
            // Uses light brightness for dark backgrounds in the status bar.
            systemNavigationBarColor: Colors.white,
            // Sets the system navigation bar color to white.
            systemNavigationBarIconBrightness: Brightness.dark,
            // Uses dark icons for the system navigation bar.
      ));
}
