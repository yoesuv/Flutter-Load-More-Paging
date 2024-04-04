import 'package:bloc_load_more/src/ui/grid.dart';
import 'package:bloc_load_more/src/ui/home.dart';
import 'package:bloc_load_more/src/ui/widgets/button_primary.dart';
import 'package:flutter/material.dart';

class Start extends StatelessWidget {
  static const String routeName = 'start';

  const Start({super.key});

  VoidCallback goToList(BuildContext context) => () {
        Navigator.pushNamed(
          context,
          Home.routeName,
        );
      };

  VoidCallback goToGrid(BuildContext context) => () {
        Navigator.pushNamed(
          context,
          Grid.routeName,
        );
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Infinite List'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ButtonPrimary(
                onPress: goToList(context),
                text: 'Pagination List',
              ),
              const SizedBox(height: 20),
              ButtonPrimary(
                onPress: goToGrid(context),
                text: 'Pagination Grid',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
