import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_test/ui/my_app.dart';

/// The main entry point of the application.
Future<void> main() async {
  /// Loads environment variables from the .env file.
  await dotenv.load();

  /// Runs the Flutter application with a [ProviderScope] to manage state using Riverpod.
  runApp(const ProviderScope(child: MyApp()));
}
