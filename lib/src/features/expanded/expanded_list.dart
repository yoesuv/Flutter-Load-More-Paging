import 'package:bloc_load_more/src/core/blocs/home_list_bloc.dart';
import 'package:bloc_load_more/src/core/events/home_list_event.dart';
import 'package:bloc_load_more/src/core/states/home_list_state.dart';
import 'package:bloc_load_more/src/ui/widgets/item_load_more.dart';
import 'package:bloc_load_more/src/ui/widgets/item_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const double _scrollThreshold = 0.9;

class ExpandedList extends StatelessWidget {
  static const String routeName = 'expanded-list';
  const ExpandedList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification.metrics.pixels >=
                notification.metrics.maxScrollExtent * _scrollThreshold) {
              context.read<HomeListBloc>().add(HomeListEventLoad());
            }
            return false;
          },
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                floating: true,
                expandedHeight: 200,
                flexibleSpace: FlexibleSpaceBar(
                  title: const Text(
                    'Expanded List',
                    style: TextStyle(color: Colors.white),
                  ),
                  centerTitle: false,
                  background: Image.asset(
                    'assets/images/kame-house.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              BlocBuilder<HomeListBloc, HomeListState>(
                buildWhen: (previous, current) =>
                    previous.status != current.status ||
                    previous.hasReachedMax != current.hasReachedMax ||
                    previous.posts != current.posts,
                builder: (context, state) {
                  switch (state.status) {
                    case PostStatus.success:
                      if (state.posts.isEmpty) {
                        return const SliverFillRemaining(
                          child: Center(child: Text('No Data')),
                        );
                      }
                      return SliverList.builder(
                        itemCount: _itemCount(state),
                        itemBuilder: (context, index) {
                          if (index.isOdd) return const Divider(height: 1);
                          final itemIndex = index ~/ 2;
                          if (itemIndex >= state.posts.length) {
                            return const ItemLoadMore();
                          }
                          return ItemPost(state.posts[itemIndex]);
                        },
                      );
                    case PostStatus.failure:
                      return SliverFillRemaining(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Something went wrong'),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () => context
                                    .read<HomeListBloc>()
                                    .add(HomeListEventLoad()),
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        ),
                      );
                    case PostStatus.initial:
                      return const SliverFillRemaining(
                        child: Center(child: CircularProgressIndicator()),
                      );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _itemCount(HomeListState state) {
    final totalItems = state.hasReachedMax
        ? state.posts.length
        : state.posts.length + 1;
    return totalItems * 2 - 1;
  }
}
