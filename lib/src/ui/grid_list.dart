import 'package:bloc_load_more/src/core/blocs/home_list_bloc.dart';
import 'package:bloc_load_more/src/core/events/home_list_event.dart';
import 'package:bloc_load_more/src/core/states/home_list_state.dart';
import 'package:bloc_load_more/src/ui/widgets/item_load_more.dart';
import 'package:bloc_load_more/src/ui/widgets/item_post_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GridList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GridListState();
  }
}

class _GridListState extends State<GridList> {

  final _scrollController = ScrollController();
  late HomeListBloc _bloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _bloc = context.read<HomeListBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeListBloc, HomeListState>(
      bloc: _bloc,
      builder: (context, state) {
        if (state.status == PostStatus.failure) {
          return Center(
              child: Text("Home List ${state.status}")
          );
        } else if (state.status == PostStatus.success) {
          if (state.posts.length == 0) {
            return Center(
                child: Text("No Data")
            );
          } else {
            return GridView.builder(
              scrollDirection: Axis.vertical,
              controller: _scrollController,
              itemCount: state.hasReachedMax ? state.posts.length : state.posts.length + 1,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                return index >= state.posts.length
                    ? ItemLoadMore()
                    : ItemPostGrid(state.posts[index]);
              },
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
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