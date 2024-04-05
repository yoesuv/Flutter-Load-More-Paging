import 'package:flutter/material.dart';

class ItemLoadMore extends StatelessWidget {
  const ItemLoadMore({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: const Center(
        child: SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
