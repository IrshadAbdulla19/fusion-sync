import 'package:flutter/material.dart';

class FusionSyncLogo extends StatelessWidget {
  const FusionSyncLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "asset/images/Union.png",
        ),
      ],
    );
  }
}
