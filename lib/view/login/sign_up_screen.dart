import 'package:flutter/material.dart';
import 'package:fusion_sync/controller/auth_controller.dart';
import 'package:fusion_sync/model/ui_constants/constants.dart';
import 'package:fusion_sync/view/login/widgets/app_sign_user.dart';
import 'package:fusion_sync/view/login/widgets/nav_button.dart';
import 'package:fusion_sync/view/widgets/for_textfileds.dart';
import 'package:fusion_sync/view/widgets/fusion_sync_logo.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final cntrl = Get.put(AuthController());
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: kWhiteColor),
        child: Form(
          key: formkey,
          child: ListView(
            children: [
              SizedBox(
                height: size.height * 0.06,
              ),
              const FusionSyncLogo(),
              SizedBox(
                height: size.height * 0.06,
              ),
              ForTextFormFileds(
                  cntrl: cntrl.username,
                  text: "Username",
                  hintText: "Enter your name",
                  labelText: "username"),
              ForTextFormFileds(
                  cntrl: cntrl.email,
                  text: "Email Adress",
                  hintText: "Enter your Email",
                  labelText: "Email"),
              ForTextFormFileds(
                  cntrl: cntrl.password,
                  text: "Password",
                  hintText: "Enter your password",
                  labelText: "password"),
              NavbuttonForSign(
                text: "SignUp",
                formkey: formkey,
              ),
              AppSignForUser(
                  foruser: "Already have an account ?", want: "SignIn")
            ],
          ),
        ),
      ),
    );
  }
}
