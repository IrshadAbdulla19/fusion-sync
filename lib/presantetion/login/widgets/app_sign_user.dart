import 'package:flutter/material.dart';
import 'package:fusion_sync/domain/core/ui_constants/constants.dart';
import 'package:fusion_sync/presantetion/login/login_screen.dart';
import 'package:fusion_sync/presantetion/login/sign_up_screen.dart';

class AppSignForUser extends StatelessWidget {
  AppSignForUser({super.key, required this.foruser, required this.want});
  String foruser;
  String want;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(foruser, style: normalTextStyleBlack),
        TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          want == "SignUp" ? SignUpScreen() : SigninScreen()));
            },
            child: Text(want, style: blodText500))
      ],
    );
  }
}
