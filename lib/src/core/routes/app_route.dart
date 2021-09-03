import 'package:bloc_load_more/src/ui/home.dart';
import 'package:bloc_load_more/src/ui/splash.dart';
import 'package:flutter/material.dart';

class AppRoute {
  static Route<dynamic> routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) {
        return Splash();
      });
    } else if (settings.name == Home.routeName) {
      return MaterialPageRoute(builder: (context) {
        return Home();
      });
    } else {
      return MaterialPageRoute(builder: (context) {
        return Scaffold(
          body: Center(
            child: Text('Page Not Found'),
          ),
        );
      });
    }
  }
}