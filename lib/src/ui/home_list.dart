import 'package:bloc_load_more/src/core/blocs/home_list_bloc.dart';
import 'package:bloc_load_more/src/core/events/home_list_event.dart';
import 'package:bloc_load_more/src/core/states/home_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeListState();
  }
}

class _HomeListState extends State<HomeList> {

  final _scrollController = ScrollController();
  late HomeListBloc _bloc = HomeListBloc();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _bloc = context.read<HomeListBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeListBloc, HomeListState>(
      builder: (context, state) {
        return Center(
          child: Text("Home List ${state.status}"),
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) _bloc.add(HomeListEventLoad());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

}