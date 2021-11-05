import 'package:flutter/material.dart';

class Grid extends StatelessWidget {
  static const String routeName = 'grid';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List Grid')),
      body: Center(
        child: Text('List Grid'),
      ),
    );
  }
}