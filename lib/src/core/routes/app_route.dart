import 'package:bloc_load_more/src/ui/grid.dart';
import 'package:bloc_load_more/src/ui/home.dart';
import 'package:bloc_load_more/src/ui/splash.dart';
import 'package:bloc_load_more/src/ui/start.dart';
import 'package:flutter/material.dart';

class AppRoute {
  static Route<dynamic> routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) {
        return const Splash();
      });
    } else if (settings.name == Home.routeName) {
      return MaterialPageRoute(builder: (context) {
        return const Home();
      });
    } else if (settings.name == Start.routeName) {
      return MaterialPageRoute(builder: (context) {
        return const Start();
      });
    } else if (settings.name == Grid.routeName) {
      return MaterialPageRoute(builder: (context) {
        return const Grid();
      });
    } else {
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
