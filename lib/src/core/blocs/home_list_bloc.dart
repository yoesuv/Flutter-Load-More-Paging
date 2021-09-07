import 'package:bloc/bloc.dart';
import 'package:bloc_load_more/src/core/events/home_list_event.dart';
import 'package:bloc_load_more/src/core/repositories/app_repository.dart';
import 'package:bloc_load_more/src/core/states/home_list_state.dart';
import 'package:rxdart/rxdart.dart';

class HomeListBloc extends Bloc<HomeListEvent, HomeListState> {

  HomeListBloc(HomeListState initialState) : super(initialState);

  @override
  Stream<Transition<HomeListEvent, HomeListState>> transformEvents(
      Stream<HomeListEvent> events, TransitionFunction<HomeListEvent, HomeListState> transitionFn) {
    return super.transformEvents(events.throttleTime(const Duration(milliseconds: 500)), transitionFn);
  }

  @override
  Stream<HomeListState> mapEventToState(HomeListEvent event) async* {
    if (event is HomeListEventLoad) {
      yield await _mapPostFetchedToState(state);
    }
  }

  Future<HomeListState> _mapPostFetchedToState(HomeListState state) async {
    if (state.hasReachedMax) return state;
    try {
      if (state.status == PostStatus.initial) {
        final posts = await AppRepository().getListPost(0);
        return state.copyWith(status: PostStatus.success, posts: posts, hasReachedMax: false);
      }
      final posts = await AppRepository().getListPost(state.posts.length);
      if (posts.isEmpty) {
        return state.copyWith(hasReachedMax: true);
      } else {
        return state.copyWith(status: PostStatus.success, posts: List.of(state.posts)..addAll(posts), hasReachedMax: false);
      }
    } catch (e) {
      return state.copyWith(status: PostStatus.failure);
    }
  }

}