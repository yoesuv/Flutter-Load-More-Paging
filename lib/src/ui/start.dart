import 'package:bloc_load_more/src/ui/home.dart';
import 'package:bloc_load_more/src/ui/widgets/button_primary.dart';
import 'package:flutter/material.dart';

class Start extends StatelessWidget {

  static const String routeName = 'start';

  VoidCallback goToList(BuildContext context) => (){
    Navigator.pushNamed(context, Home.routeName);
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Infinite List')),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ButtonPrimary(onPress: goToList(context), text: 'Pagination List'),
              SizedBox(height: 20),
              ButtonPrimary( onPress: () {}, text: 'Pagination Grid'),
            ],
          ),
        ),
      ),
    );
  }
}