import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

Widget buildSegment(String text) {
  return Container(
    //color:  Color(0xFF78C4A4),
    padding: EdgeInsets.only(right: 13, left: 13, top: 8, bottom: 8),
    //
    child: Text(text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w500,
          height: 0,
        )),
  );
}
