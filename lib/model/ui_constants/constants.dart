import 'package:flutter/material.dart';
import 'package:fusion_sync/controller/theme_contoller.dart';
import 'package:get/get.dart';

const String serverKey =
    "AAAAtPztbSg:APA91bEVoOSJZ6C-ykJoSx63aJ9Z5zNcBPsUkhEvARINCyq6AbdNhnixSaRsIbltG5wH3lI3uUKHwVmSKs8Ad2bte7c9Vl4tvbTwW7PgGd9jBYMfyawmT5X4lWK61Xrn3n3VLLj2ooVC";
final themeCntrl = Get.put(ThemeController());
var textFormDoc = InputDecoration(
    labelStyle: const TextStyle(color: Colors.black),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.black)),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.black)));
var kBlackColor = Colors.black;
var kWhiteColor = Colors.white;
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
const MaterialColor primaryWhite = MaterialColor(
  _whitePrimaryValue,
  <int, Color>{
    50: Color(0xFFFFFFFF),
    100: Color(0xFFFFFFFF),
    200: Color(0xFFFFFFFF),
    300: Color(0xFFFFFFFF),
    400: Color(0xFFFFFFFF),
    500: Color(_whitePrimaryValue),
    600: Color(0xFFFFFFFF),
    700: Color(0xFFFFFFFF),
    800: Color(0xFFFFFFFF),
    900: Color(0xFFFFFFFF),
  },
);
const int _whitePrimaryValue = 0xFFFFFFFF;

const kGreyClr = Colors.grey;

var normalTextStyleBlack =
    TextStyle(color: kBlackColor, fontWeight: FontWeight.w700);
const normalTextStyleGrey =
    TextStyle(color: Colors.grey, fontWeight: FontWeight.w700);
var normalTextStyleBlackHead =
    TextStyle(color: kBlackColor, fontSize: 18, fontWeight: FontWeight.w900);
var normalTextStyleWhite =
    TextStyle(color: kWhiteColor, fontWeight: FontWeight.w700);
var blodText500 = TextStyle(fontWeight: FontWeight.w900, color: kBlackColor);
var miniText =
    TextStyle(color: kBlackColor, fontWeight: FontWeight.w400, fontSize: 18);
var circularProgresKBlack = CircularProgressIndicator(
  color: kBlackColor,
);
var mainTextHeads =
    TextStyle(color: kBlackColor, fontWeight: FontWeight.w800, fontSize: 15);
var miniTextHeads =
    TextStyle(color: kBlackColor, fontWeight: FontWeight.w900, fontSize: 18);

var circularProgresKWhite = CircularProgressIndicator(
  color: kWhiteColor,
);
const nonUserNonProfile =
    'https://image.shutterstock.com/image-vector/man-icon-flat-vector-260nw-1371568223.jpg';
const noImage =
    "https://upload.wikimedia.org/wikipedia/commons/7/75/No_image_available.png";
