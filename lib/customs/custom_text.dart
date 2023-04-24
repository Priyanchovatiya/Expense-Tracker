import 'package:flutter/material.dart';
class CustimText extends StatelessWidget {
  final String text;
  final Color colour;
  final double size;
  final FontWeight fontWeight;

  const CustimText({
  required this.fontWeight,
  required this.text,
  required this.size,
  required this.colour,
  super.key,
});

@override
Widget build(BuildContext context) {
  return  Text(
    text,
    style: TextStyle(
      fontFamily: 'Plus Jakarta Sans',
      color: colour,
      fontSize: size,
      fontWeight: fontWeight,
    ),
  );
}
}
