import 'package:bloc_load_more/src/core/blocs/home_list_bloc.dart';
import 'package:bloc_load_more/src/core/events/home_list_event.dart';
import 'package:bloc_load_more/src/core/states/home_list_state.dart';
import 'package:bloc_load_more/src/ui/widgets/item_load_more.dart';
import 'package:bloc_load_more/src/ui/widgets/item_post_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const double _scrollThreshold = 0.9;

class GridList extends StatelessWidget {
  const GridList({super.key});

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.pixels >=
            notification.metrics.maxScrollExtent * _scrollThreshold) {
          context.read<HomeListBloc>().add(HomeListEventLoad());
        }
        return false;
      },
      child: BlocBuilder<HomeListBloc, HomeListState>(
        buildWhen: (previous, current) =>
            previous.status != current.status ||
            previous.hasReachedMax != current.hasReachedMax ||
            previous.posts != current.posts,
        builder: (context, state) {
          if (state.status == PostStatus.failure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Home List ${state.status}"),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<HomeListBloc>().add(HomeListEventLoad()),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (state.status == PostStatus.success) {
            if (state.posts.isEmpty) {
              return const Center(child: Text("No Data"));
            } else {
              return GridView.builder(
                scrollDirection: Axis.vertical,
                itemCount: state.hasReachedMax
                    ? state.posts.length
                    : state.posts.length + 1,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  return index >= state.posts.length
                      ? const ItemLoadMore()
                      : ItemPostGrid(state.posts[index]);
                },
              );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
