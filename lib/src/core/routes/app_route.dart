import 'package:bloc_load_more/src/core/blocs/home_list_bloc.dart';
import 'package:bloc_load_more/src/core/events/home_list_event.dart';
import 'package:bloc_load_more/src/features/expanded/expanded_list.dart';
import 'package:bloc_load_more/src/features/grid/grid.dart';
import 'package:bloc_load_more/src/features/home/home.dart';
import 'package:bloc_load_more/src/features/splash/splash.dart';
import 'package:bloc_load_more/src/features/start/start.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoute {
  static Route<dynamic> routes(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (context) {
            return const Splash();
          },
        );
      case Home.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return const Home();
          },
        );
      case Start.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return const Start();
          },
        );
      case Grid.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return const Grid();
          },
        );
      case ExpandedList.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => HomeListBloc()..add(HomeListEventLoad()),
              child: const ExpandedList(),
            );
          },
        );
      default:
        return MaterialPageRoute(
          builder: (context) {
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
          },
        );
    }
  }
}
