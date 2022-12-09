import 'package:flutter/material.dart';
class CustomText extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;

  const CustomText({
    Key? key,
    required this.text,
    required this.fontWeight,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
      style: TextStyle(
        color: Colors.black,
        fontWeight: fontWeight,
        fontSize: 16,
      ),

    );
  }
}