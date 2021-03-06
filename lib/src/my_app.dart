import 'package:bloc_load_more/src/core/routes/app_route.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter BLOC Load More',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      onGenerateRoute: AppRoute.routes,
    );
  }
}