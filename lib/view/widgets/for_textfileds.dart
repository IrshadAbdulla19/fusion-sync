import 'package:flutter/material.dart';
import 'package:fusion_sync/model/ui_constants/constants.dart';

class ForTextFormFileds extends StatelessWidget {
  ForTextFormFileds(
      {super.key,
      required this.text,
      required this.hintText,
      required this.labelText,
      required this.cntrl});
  String text;
  String hintText;
  String labelText;
  TextEditingController cntrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
          child: Text(
            text,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600, color: kBlackColor),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
          child: TextFormField(
            obscuringCharacter: "*",
            obscureText: text == "Password" ? true : false,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please fill the Form Filed';
              } else {
                return null;
              }
            },
            controller: cntrl,
            decoration:
                textFormDoc.copyWith(hintText: hintText, labelText: labelText),
          ),
        ),
      ],
    );
  }
}
