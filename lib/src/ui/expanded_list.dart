import 'package:bloc_load_more/src/core/blocs/home_list_bloc.dart';
import 'package:bloc_load_more/src/core/events/home_list_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpandedList extends StatefulWidget {
  static const String routeName = 'expanded-list';

  const ExpandedList({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpandedListState();
  }

}

class _ExpandedListState extends State<ExpandedList> {

  HomeListBloc? _homeListBloc;

  @override
  void initState() {
    super.initState();
    _homeListBloc = context.read<HomeListBloc>();
    _homeListBloc?.add(HomeListEventLoad());
  }

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
