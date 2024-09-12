import 'package:flutter/material.dart';
import '../base/app_route_parser.dart';

/// The main application widget that sets up the router for the app.
class MyApp extends StatefulWidget {
  /// Creates an instance of [MyApp].
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Instance of the custom router delegate to manage app navigation.
  final AppRouterDelegate _routerDelegate = AppRouterDelegate();

  // Instance of the custom route information parser to parse route information.
  final AppRouteInformationParser _routeInformationParser = AppRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser,
    );
  }
}
