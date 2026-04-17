import 'package:bloc_load_more/src/core/blocs/home_list_bloc.dart';
import 'package:bloc_load_more/src/core/events/home_list_event.dart';
import 'package:bloc_load_more/src/core/repositories/app_repository.dart';
import 'package:bloc_load_more/src/core/states/home_list_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'fixtures/post_fixtures.dart';

class MockAppRepository extends Mock implements AppRepository {}

void main() {
  group('HomeListBloc', () {
    late MockAppRepository mockRepository;

    setUp(() {
      mockRepository = MockAppRepository();
    });

    blocTest<HomeListBloc, HomeListState>(
      'emits [success with posts] when initial load succeeds',
      build: () => HomeListBloc(repository: mockRepository),
      setUp: () {
        when(
          () => mockRepository.getListPost(start: 0),
        ).thenAnswer((_) async => tPosts);
      },
      act: (bloc) => bloc.add(HomeListEventLoad()),
      expect: () => [
        HomeListState(
          status: PostStatus.success,
          posts: tPosts,
          hasReachedMax: false,
        ),
      ],
      verify: (_) {
        verify(() => mockRepository.getListPost(start: 0)).called(1);
      },
    );

    blocTest<HomeListBloc, HomeListState>(
      'emits [success with appended posts] when load more succeeds',
      build: () => HomeListBloc(repository: mockRepository),
      seed: () => HomeListState(
        status: PostStatus.success,
        posts: tPosts,
        hasReachedMax: false,
      ),
      setUp: () {
        when(
          () => mockRepository.getListPost(start: 2),
        ).thenAnswer((_) async => tPosts);
      },
      act: (bloc) => bloc.add(HomeListEventLoad()),
      expect: () => [
        HomeListState(
          status: PostStatus.success,
          posts: [...tPosts, ...tPosts],
          hasReachedMax: false,
        ),
      ],
      verify: (_) {
        verify(() => mockRepository.getListPost(start: 2)).called(1);
      },
    );

    blocTest<HomeListBloc, HomeListState>(
      'emits [hasReachedMax true] when no more posts returned',
      build: () => HomeListBloc(repository: mockRepository),
      seed: () => HomeListState(
        status: PostStatus.success,
        posts: tPosts,
        hasReachedMax: false,
      ),
      setUp: () {
        when(
          () => mockRepository.getListPost(start: 2),
        ).thenAnswer((_) async => []);
      },
      act: (bloc) => bloc.add(HomeListEventLoad()),
      expect: () => [
        HomeListState(
          status: PostStatus.success,
          posts: tPosts,
          hasReachedMax: true,
        ),
      ],
    );

    blocTest<HomeListBloc, HomeListState>(
      'emits nothing when hasReachedMax is true',
      build: () => HomeListBloc(repository: mockRepository),
      seed: () => HomeListState(
        status: PostStatus.success,
        posts: tPosts,
        hasReachedMax: true,
      ),
      act: (bloc) => bloc.add(HomeListEventLoad()),
      expect: () => [],
    );

    blocTest<HomeListBloc, HomeListState>(
      'emits [failure] when repository throws exception',
      build: () => HomeListBloc(repository: mockRepository),
      seed: () => HomeListState(
        status: PostStatus.success,
        posts: tPosts,
        hasReachedMax: false,
      ),
      setUp: () {
        when(
          () => mockRepository.getListPost(start: 2),
        ).thenThrow(Exception('Network error'));
      },
      act: (bloc) => bloc.add(HomeListEventLoad()),
      expect: () => [
        HomeListState(
          status: PostStatus.failure,
          posts: tPosts,
          hasReachedMax: false,
        ),
      ],
    );
  });
}
