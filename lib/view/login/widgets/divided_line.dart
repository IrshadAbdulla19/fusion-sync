import 'package:flutter/material.dart';

class DividingLine extends StatelessWidget {
  const DividingLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 1,
          width: 100,
          color: Colors.black,
        ),
        const SizedBox(
            height: 10), // Adjust the space between the lines and the text
        const Text(
          'Or',
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(
            height: 10), // Adjust the space between the text and the lines
        Container(
          height: 1,
          width: 100,
          color: Colors.black,
        ),
      ],
    );
  }
}
