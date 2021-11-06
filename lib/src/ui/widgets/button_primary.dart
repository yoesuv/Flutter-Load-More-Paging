import 'package:flutter/material.dart';

class ButtonPrimary extends StatelessWidget {

  final VoidCallback onPress;
  final String text;

  ButtonPrimary({required this.onPress, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.circular(8)
      ),
      child: MaterialButton(
        onPressed: onPress,
        child: Text(text, style: TextStyle(color: Colors.white, fontSize: 16)),
      ),
    );
  }

}