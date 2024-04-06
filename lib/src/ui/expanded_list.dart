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
            pinned: true,
            expandedHeight: 200,
            title: Text("EXPANDED"),
            backgroundColor: Colors.teal,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              _buildList(),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 33,
      physics: const NeverScrollableScrollPhysics(),
      primary: false,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: 8,
          ),
          child: Text("Item $index"),
        );
      },
    );
  }
}
