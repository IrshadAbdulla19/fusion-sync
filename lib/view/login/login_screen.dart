import 'package:flutter/material.dart';
import 'package:fusion_sync/controller/auth_controller.dart';
import 'package:fusion_sync/model/ui_constants/constants.dart';
import 'package:fusion_sync/view/login/widgets/app_sign_user.dart';
import 'package:fusion_sync/view/login/widgets/divided_line.dart';
import 'package:fusion_sync/view/login/widgets/forget_password.dart';
import 'package:fusion_sync/view/login/widgets/google_login.dart';
import 'package:fusion_sync/view/login/widgets/nav_button.dart';
import 'package:fusion_sync/view/widgets/for_textfileds.dart';
import 'package:fusion_sync/view/widgets/fusion_sync_logo.dart';
import 'package:get/get.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({super.key});
  final cntrl = Get.put(AuthController());
  final fromKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: kWhiteColor),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Form(
              key: fromKey,
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
                    formkey: fromKey,
                    text: "SignIn",
                  ),
                  AppSignForUser(
                    foruser: "For Create an account ?",
                    want: "SignUp",
                  ),
                  const DividingLine(),
                  GoogleLogin(size: size)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
