import 'dart:async';

import 'package:bloc_load_more/src/ui/start.dart';
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      const route = Start.routeName;
      Navigator.pushNamedAndRemoveUntil(
        context,
        route,
        ModalRoute.withName("/"),
      );
    });
    return const Scaffold(
      body: Center(
        child: Text(
          'BLOC Load More',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
