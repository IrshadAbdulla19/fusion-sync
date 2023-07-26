import 'package:flutter/material.dart';
import 'package:fusion_sync/application/auth_controller.dart';
import 'package:fusion_sync/domain/core/ui_constants/constants.dart';
import 'package:get/get.dart';

class NavbuttonForSign extends StatelessWidget {
  NavbuttonForSign({super.key, required this.text});
  final cntrl = Get.put(AuthController());
  String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: kBlackColor),
        child: Obx(
          () => TextButton(
              onPressed: () {
                text == "SignUp" ? cntrl.signup() : cntrl.signIn();
              },
              child: cntrl.loading.value
                  ? CircularProgressIndicator(
                      color: kWhiteColor,
                    )
                  : Text(
                      text,
                      style: normalTextStyleWhite,
                    )),
        ),
      ),
    );
  }
}
