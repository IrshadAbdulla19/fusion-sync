import 'package:flutter/material.dart';
import 'package:fusion_sync/controller/auth_controller.dart';
import 'package:fusion_sync/model/ui_constants/constants.dart';
import 'package:get/get.dart';

class GoogleLogin extends StatelessWidget {
  GoogleLogin({
    super.key,
    required this.size,
  });

  final Size size;
  final cntrl = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: kBlackColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  cntrl.signInwithGoogle();
                },
                child: Text(
                  "SigIn With Google",
                  style: normalTextStyleWhite,
                )),
            Image.asset(
              "asset/images/google logo.png",
              width: size.width * 0.1,
              // height: size.height * 0.05,
            )
          ],
        ),
      ),
    );
  }
}
