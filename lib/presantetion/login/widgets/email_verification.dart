import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fusion_sync/application/auth_controller.dart';
import 'package:fusion_sync/domain/core/ui_constants/constants.dart';
import 'package:fusion_sync/presantetion/main/main_screen.dart';
import 'package:get/get.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool check = false;
  final cntrl = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(
              check == false
                  ? "Please Verify Your Email"
                  : "Your Email is Verified",
              style: mainTextHeads,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 60.0, vertical: 10),
              child: Container(
                width: size.width * 0.6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: kBlackColor),
                child: TextButton(
                  onPressed: () {
                    if (check == true) {
                      print("yes");
                    } else {
                      print("no");
                    }
                    forCheckVerification();
                    check == true
                        ? Get.offAll(MainScreen())
                        : cntrl.verifyEmail();
                  },
                  child: Text(
                    check == true
                        ? "Please Press to Get In"
                        : "Resent The Email",
                    style: normalTextStyleWhite,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: size.width * 0.5,
              height: size.height * 0.05,
              child: ElevatedButton(
                  onPressed: () {
                    print("hello${auth.currentUser!.emailVerified}");
                    forCheckVerification();
                  },
                  child: Text(
                    "Refresh",
                    style: normalTextStyleWhite,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  forCheckVerification() {
    if (auth.currentUser!.emailVerified == true) {
      setState(() {
        check = true;
      });
    }
  }
}
