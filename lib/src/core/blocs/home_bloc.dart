import 'package:bloc/bloc.dart';
import 'package:bloc_load_more/src/core/events/home_event.dart';
import 'package:bloc_load_more/src/core/states/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  HomeBloc(HomeState initialState) : super(initialState);

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomeEventLoad) {

    }
  }

}