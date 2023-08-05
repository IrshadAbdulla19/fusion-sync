import 'package:flutter/material.dart';

final textFormDoc = InputDecoration(
    labelStyle: const TextStyle(color: Colors.black),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.black)),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.black)));
const kBlackColor = Colors.black;
const kWhiteColor = Colors.white;
const MaterialColor primaryBlack = MaterialColor(
  _blackPrimaryValue,
  <int, Color>{
    50: Color(0xFF000000),
    100: Color(0xFF000000),
    200: Color(0xFF000000),
    300: Color(0xFF000000),
    400: Color(0xFF000000),
    500: Color(_blackPrimaryValue),
    600: Color(0xFF000000),
    700: Color(0xFF000000),
    800: Color(0xFF000000),
    900: Color(0xFF000000),
  },
);
const int _blackPrimaryValue = 0xFF000000;

const normalTextStyleBlack =
    TextStyle(color: kBlackColor, fontWeight: FontWeight.w700);
const normalTextStyleWhite =
    TextStyle(color: kWhiteColor, fontWeight: FontWeight.w700);
const blodText500 = TextStyle(fontWeight: FontWeight.w900, color: kBlackColor);
const mainTextHeads =
    TextStyle(color: kBlackColor, fontWeight: FontWeight.w800, fontSize: 28);
const circularProgresKBlack = CircularProgressIndicator(
  color: kBlackColor,
);
const circularProgresKWhite = CircularProgressIndicator(
  color: kWhiteColor,
);
