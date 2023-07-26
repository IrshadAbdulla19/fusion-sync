import 'package:flutter/material.dart';
import 'package:fusion_sync/application/auth_controller.dart';
import 'package:fusion_sync/domain/core/ui_constants/constants.dart';
import 'package:fusion_sync/presantetion/login/widgets/app_sign_user.dart';
import 'package:fusion_sync/presantetion/login/widgets/forget_password.dart';
import 'package:fusion_sync/presantetion/login/widgets/nav_button.dart';
import 'package:fusion_sync/presantetion/widgets/for_textfileds.dart';
import 'package:fusion_sync/presantetion/widgets/fusion_sync_logo.dart';
import 'package:get/get.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({super.key});
  final cntrl = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: kWhiteColor),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 120),
            child: ListView(
              children: [
                const FusionSyncLogo(),
                SizedBox(
                  height: size.height * 0.09,
                ),
                ForTextFormFileds(
                  cntrl: cntrl.loginemail,
                  text: "Email Adress",
                  hintText: "Enter your Email",
                  labelText: "Email",
                ),
                ForTextFormFileds(
                  cntrl: cntrl.loginpassword,
                  text: "Password",
                  hintText: "Enter password",
                  labelText: "password",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForfotPasswordScreen(),
                              ));
                        },
                        child: const Text(
                          "Forgot password ?",
                          style: blodText500,
                        ))
                  ],
                ),
                NavbuttonForSign(
                  text: "SignIn",
                ),
                AppSignForUser(
                  foruser: "For Create an account ?",
                  want: "SignUp",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
