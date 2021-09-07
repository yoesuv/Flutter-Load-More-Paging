import 'package:bloc_load_more/src/core/blocs/home_list_bloc.dart';
import 'package:bloc_load_more/src/ui/home_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  static const String routeName = 'home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List Post')),
      body: BlocProvider(
        create: (context) => HomeListBloc(),
        child: HomeList(),
      )
    );
  }

}