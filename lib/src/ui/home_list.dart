import 'package:bloc_load_more/src/core/blocs/home_list_bloc.dart';
import 'package:bloc_load_more/src/core/events/home_list_event.dart';
import 'package:bloc_load_more/src/core/states/home_list_state.dart';
import 'package:bloc_load_more/src/ui/widgets/item_load_more.dart';
import 'package:bloc_load_more/src/ui/widgets/item_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeList extends StatefulWidget {
  const HomeList({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeListState();
  }
}

class _HomeListState extends State<HomeList> {
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
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.hasReachedMax != current.hasReachedMax ||
          previous.posts != current.posts,
      builder: (context, state) {
        if (state.status == PostStatus.failure) {
          return Center(child: Text("Home List ${state.status}"));
        } else if (state.status == PostStatus.success) {
          if (state.posts.isEmpty) {
            return const Center(child: Text("No Data"));
          } else {
            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                return index >= state.posts.length
                    ? const ItemLoadMore()
                    : ItemPost(state.posts[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.posts.length
                  : state.posts.length + 1,
              controller: _scrollController,
            );
          }
        } else {
          return const Center(
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
