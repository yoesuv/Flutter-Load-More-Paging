import 'package:bloc_load_more/src/core/blocs/home_list_bloc.dart';
import 'package:bloc_load_more/src/core/events/home_list_event.dart';
import 'package:bloc_load_more/src/ui/grid_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Grid extends StatelessWidget {
  static const String routeName = 'grid';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List Grid')),
      body: BlocProvider(
        create: (context) => HomeListBloc()..add(HomeListEventLoad()),
        child: GridList(),
      ),
    );
  }
}