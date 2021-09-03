import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('BLOC Load More', style: TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold
        )),
      ),
    );
  }
}