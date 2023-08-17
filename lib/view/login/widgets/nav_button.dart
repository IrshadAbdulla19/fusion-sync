import 'package:flutter/material.dart';
import 'package:fusion_sync/controller/auth_controller.dart';
import 'package:fusion_sync/model/ui_constants/constants.dart';
import 'package:get/get.dart';

class NavbuttonForSign extends StatelessWidget {
  NavbuttonForSign({super.key, required this.text, required this.formkey});
  final cntrl = Get.put(AuthController());
  String text;
  GlobalKey<FormState> formkey;

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
                if (formkey.currentState!.validate()) {
                  text == "SignUp" ? cntrl.signup() : cntrl.signIn();
                } else {
                  Get.snackbar("error", "Please do the correct validation");
                }
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
