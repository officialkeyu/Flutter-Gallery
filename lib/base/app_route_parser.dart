// Route Paths
import 'package:flutter/material.dart';
import '../ui/home.dart';
import '../ui/spalsh.dart';

/// Defines various route paths for the application.
class AppRoutePath {
  /// The current location path.
  final String? location;

  /// Constructor for the home route path.
  AppRoutePath.home() : location = '/home';

  /// Constructor for the splash route path.
  AppRoutePath.splash() : location = '/';

  /// Constructor for the full-screen image route path.
  AppRoutePath.fullScreenImage() : location = '/fullScreenImage';

  /// Checks if the current path is the home page.
  bool get isHomePage => location == '/home';

  /// Checks if the current path is the splash page.
  bool get isSplashPage => location == '/';

  /// Checks if the current path is the full-screen image page.
  bool get isFullScreenImagePage => location == '/fullScreenImage';
}

/// Parses route information into [AppRoutePath].
class AppRouteInformationParser extends RouteInformationParser<AppRoutePath> {
  @override
  Future<AppRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location ?? '/');

    if (uri.pathSegments.isEmpty) {
      return AppRoutePath.splash();
    }

    if (uri.pathSegments.length == 1) {
      switch (uri.pathSegments[0]) {
        case 'home':
          return AppRoutePath.home();
        case 'fullScreenImage':
          return AppRoutePath.fullScreenImage();
      }
    }

    return AppRoutePath.splash();
  }

  @override
  RouteInformation? restoreRouteInformation(AppRoutePath configuration) {
    if (configuration.isHomePage) {
      return RouteInformation(uri: Uri.parse('/home'));
    } else if (configuration.isFullScreenImagePage) {
      return RouteInformation(uri: Uri.parse('/fullScreenImage'));
    }
    return RouteInformation(uri: Uri.parse('/'));
  }
}

/// A custom router delegate to manage application routing.
class AppRouterDelegate extends RouterDelegate<AppRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRoutePath> {
  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  AppRoutePath _currentPath = AppRoutePath.splash();

  @override
  AppRoutePath get currentConfiguration => _currentPath;

  /// Navigates to the home page.
  void _handleSplashComplete() {
    _currentPath = AppRoutePath.home();
    notifyListeners();
  }

  /// Navigates to the full-screen image page.
  void _handleFullScreenImage() {
    _currentPath = AppRoutePath.fullScreenImage();
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        if (_currentPath.isSplashPage)
          MaterialPage(
            key: const ValueKey('SplashPage'),
            child: SplashScreen(onComplete: _handleSplashComplete),
          ),
        if (_currentPath.isHomePage)
          MaterialPage(
            key: const ValueKey('HomePage'),
            child: Home(onFullScreenImage: _handleFullScreenImage),
          ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        _currentPath = AppRoutePath.splash();
        notifyListeners(); // Notifies listeners when popping the route
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(AppRoutePath configuration) async {
    _currentPath = configuration;
  }
}
