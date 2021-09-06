import 'package:flutter/material.dart';

class ItemPost extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
      return Column(
        children: [
          Text("Title", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text("Description", style: TextStyle(fontSize: 14))
        ],
      );
  }

}