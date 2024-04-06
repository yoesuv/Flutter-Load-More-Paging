import 'package:flutter/material.dart';

class ExpandedList extends StatelessWidget {
  static const String routeName = 'expanded-list';

  const ExpandedList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            title: Text("EXPANDED"),
            backgroundColor: Colors.teal,
          ),
          SliverList(delegate: SliverChildListDelegate(
            [
              Text("Item 1"),
              Text("Item 2"),
              Text("Item 3"),
            ]
          ),),
        ],
      ),
    );


  }

}