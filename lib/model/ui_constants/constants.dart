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

const kGreyClr = Colors.grey;

const normalTextStyleBlack =
    TextStyle(color: kBlackColor, fontWeight: FontWeight.w700);
const normalTextStyleGrey =
    TextStyle(color: Colors.grey, fontWeight: FontWeight.w700);
const normalTextStyleBlackHead =
    TextStyle(color: kBlackColor, fontSize: 18, fontWeight: FontWeight.w900);
const normalTextStyleWhite =
    TextStyle(color: kWhiteColor, fontWeight: FontWeight.w700);
const blodText500 = TextStyle(fontWeight: FontWeight.w900, color: kBlackColor);
const miniText =
    TextStyle(color: kBlackColor, fontWeight: FontWeight.w400, fontSize: 23);
const circularProgresKBlack = CircularProgressIndicator(
  color: kBlackColor,
);
const mainTextHeads =
    TextStyle(color: kBlackColor, fontWeight: FontWeight.w800, fontSize: 28);
const miniTextHeads =
    TextStyle(color: kBlackColor, fontWeight: FontWeight.w900, fontSize: 23);

const circularProgresKWhite = CircularProgressIndicator(
  color: kWhiteColor,
);
const nonUserNonProfile =
    'https://image.shutterstock.com/image-vector/man-icon-flat-vector-260nw-1371568223.jpg';
