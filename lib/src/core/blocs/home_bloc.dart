import 'package:bloc/bloc.dart';
import 'package:bloc_load_more/src/core/events/home_event.dart';
import 'package:bloc_load_more/src/core/repositories/app_repository.dart';
import 'package:bloc_load_more/src/core/states/home_state.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  HomeBloc(HomeState initialState) : super(initialState);

  @override
  Stream<Transition<HomeEvent, HomeState>> transformEvents(
      Stream<HomeEvent> events, TransitionFunction<HomeEvent, HomeState> transitionFn) {
    return super.transformEvents(events.throttleTime(const Duration(milliseconds: 500)), transitionFn);
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomeEventLoad) {
      yield await _mapPostFetchedToState(state);
    }
  }

  Future<HomeState> _mapPostFetchedToState(HomeState state) async {
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