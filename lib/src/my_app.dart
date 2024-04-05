import 'package:bloc_load_more/src/core/routes/app_route.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter BLOC Load More',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          background: Colors.white,
        )
      ),
      onGenerateRoute: AppRoute.routes,
    );
  }
}
