import 'dart:async';

import 'package:bloc_load_more/src/ui/start.dart';
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(context, Start.routeName, ModalRoute.withName("/"));
    });
    return Scaffold(
      body: Center(
        child: Text('BLOC Load More', style: TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold
        )),
      ),
    );
  }
}