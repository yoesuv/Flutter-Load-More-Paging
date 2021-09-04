import 'package:bloc_load_more/src/core/blocs/home_bloc.dart';
import 'package:bloc_load_more/src/core/states/home_state.dart';
import 'package:bloc_load_more/src/ui/home.dart';
import 'package:bloc_load_more/src/ui/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoute {
  static Route<dynamic> routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) {
        return Splash();
      });
    } else if (settings.name == Home.routeName) {
      return MaterialPageRoute(builder: (context) {
        return BlocProvider(
            create: (context) => HomeBloc(HomeState(status: PostStatus.initial)), child: Home());
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