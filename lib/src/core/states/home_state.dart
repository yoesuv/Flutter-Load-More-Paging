import 'package:bloc_load_more/src/core/models/post_response.dart';
import 'package:equatable/equatable.dart';

enum PostStatus {
  initial, success, failure
}

class HomeState extends Equatable {

  const HomeState({
    this.status = PostStatus.initial,
    this.posts = const <Post>[],
    this.hasReachedMax = false
  });

  final PostStatus status;
  final List<Post> posts;
  final bool hasReachedMax;

  HomeState copyWith(PostStatus? status, List<Post>? posts, bool? hasReachedMax) {
    return HomeState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      hasReachedMax:  hasReachedMax ?? this.hasReachedMax
    );
  }

  @override
  List<Object?> get props => [status, posts, hasReachedMax];

}