import 'package:bloc_load_more/src/ui/expanded_list.dart';
import 'package:bloc_load_more/src/ui/grid.dart';
import 'package:bloc_load_more/src/ui/home.dart';
import 'package:bloc_load_more/src/ui/splash.dart';
import 'package:bloc_load_more/src/ui/start.dart';
import 'package:flutter/material.dart';

class AppRoute {
  static Route<dynamic> routes(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (context) {
          return const Splash();
        });
      case Home.routeName:
        return MaterialPageRoute(builder: (context) {
          return const Home();
        });
      case Start.routeName:
        return MaterialPageRoute(builder: (context) {
          return const Start();
        });
      case Grid.routeName:
        return MaterialPageRoute(builder: (context) {
          return const Grid();
        });
      case ExpandedList.routeName:
        return MaterialPageRoute(builder: (context) {
          return const ExpandedList();
        });
      default:
        return MaterialPageRoute(builder: (context) {
          return const Scaffold(
            body: Center(
              child: Text(
                'Page Not Found',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        });
    }
  }
}
