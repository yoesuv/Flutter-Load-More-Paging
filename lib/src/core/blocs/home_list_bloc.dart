import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:bloc_load_more/src/core/events/home_list_event.dart';
import 'package:bloc_load_more/src/core/repositories/app_repository.dart';
import 'package:bloc_load_more/src/core/states/home_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class HomeListBloc extends Bloc<HomeListEvent, HomeListState> {
  HomeListBloc() : super(const HomeListState()) {
    on<HomeListEventLoad>(
      _onPostFetched,
      transformer: throttleDroppable(
        throttleDuration,
      ),
    );
  }

  Future<void> _onPostFetched(
    HomeListEvent event,
    Emitter<HomeListState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == PostStatus.initial) {
        final posts = await AppRepository().getListPost(0);
        return emit(state.copyWith(
          status: PostStatus.success,
          posts: posts,
          hasReachedMax: false,
        ));
      }
      final posts = await AppRepository().getListPost(state.posts.length);
      if (posts.isEmpty) {
        emit(state.copyWith(hasReachedMax: true));
      } else {
        emit(state.copyWith(
          status: PostStatus.success,
          posts: List.of(state.posts)..addAll(posts),
          hasReachedMax: false,
        ));
      }
    } catch (e) {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }
}
