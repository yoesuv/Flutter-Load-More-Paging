import 'package:bloc_load_more/src/core/blocs/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  static const String routeName = 'home';
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {

  HomeBloc? _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<HomeBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List Post')),
      body: Center(
        child: Text('Home List'),
      ),
    );
  }

}