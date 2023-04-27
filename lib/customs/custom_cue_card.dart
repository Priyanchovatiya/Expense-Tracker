import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_text.dart';

class cueCard extends StatelessWidget {
  final Color colour;
  final IconData icon;
  final String headText;
  final String data;
  cueCard(
      {required this.colour,
      required this.icon,
      required this.headText,
      required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: colour.withOpacity(0.4),
            radius: 20.0,
            child: Icon(
              icon,
              color: colour,
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          CustomText(
              fontWeight: FontWeight.w500,
              text: headText,
              size: 18,
              colour: Color(0xFF111111)),
          const SizedBox(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                  fontWeight: FontWeight.bold,
                  text: "₹",
                  size: 18,
                  colour: Color(0xFF111111)),
              CustomText(
                  fontWeight: FontWeight.bold,
                  text: data.toString(),
                  size: 18,
                  colour: Color(0xFF111111)),
              // CustomText(fontWeight: FontWeight.bold, text: data.toString(), size: 18, colour: Color(0xFF111111)),
            ],
          ),
        ],
      ),
    );
  }
}
