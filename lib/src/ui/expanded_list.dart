import 'package:bloc_load_more/src/core/blocs/home_list_bloc.dart';
import 'package:bloc_load_more/src/core/events/home_list_event.dart';
import 'package:bloc_load_more/src/core/states/home_list_state.dart';
import 'package:bloc_load_more/src/ui/widgets/item_load_more.dart';
import 'package:bloc_load_more/src/ui/widgets/item_post.dart';
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
  final _scrollController = ScrollController();

  void _onScroll() {
    if (_isBottom) _homeListBloc?.add(HomeListEventLoad());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void initState() {
    super.initState();
    _homeListBloc = context.read<HomeListBloc>();
    _homeListBloc?.add(HomeListEventLoad());
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            expandedHeight: 200,
            title: const Text("EXPANDED"),
            flexibleSpace: Container(
              width: double.infinity,
              height: 200,
              decoration: const BoxDecoration(
                color: Colors.teal,
              ),
            ),
          ),
          BlocBuilder<HomeListBloc, HomeListState>(
            bloc: _homeListBloc,
            buildWhen: (previous, current) =>
                previous.status != current.status ||
                previous.hasReachedMax != current.hasReachedMax ||
                previous.posts != current.posts,
            builder: (context, state) {
              if (state.status == PostStatus.success) {
                return SliverList(
                  delegate: SliverChildListDelegate([
                    _buildList(state),
                  ]),
                );
              }
              return const SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Widget _buildList(HomeListState state) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount:
          state.hasReachedMax ? state.posts.length : state.posts.length + 1,
      physics: const NeverScrollableScrollPhysics(),
      primary: false,
      itemBuilder: (context, index) {
        return index >= state.posts.length
            ? const ItemLoadMore()
            : ItemPost(state.posts[index]);
      },
      separatorBuilder: (context, index) => const Divider(height: 1),
    );
  }
}
