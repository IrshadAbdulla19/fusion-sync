import 'package:flutter/material.dart';

class FusionSync extends StatelessWidget {
  FusionSync({super.key, required this.size});
  Size size;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("asset/images/Union.png", width: size.width * 0.13),
      ],
    );
  }
}
