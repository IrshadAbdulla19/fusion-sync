import 'package:flutter/material.dart';
import 'package:fusion_sync/application/auth_controller.dart';
import 'package:fusion_sync/domain/core/ui_constants/constants.dart';
import 'package:fusion_sync/presantetion/widgets/for_textfileds.dart';
import 'package:get/get.dart';

class ForfotPasswordScreen extends StatelessWidget {
  ForfotPasswordScreen({super.key});
  final cntrl = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.2,
            ),
            ForTextFormFileds(
              cntrl: cntrl.resetemail,
              text: "Reset Password",
              hintText: "Enter verify email",
              labelText: "Email",
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 60.0, vertical: 10),
              child: Container(
                width: size.width * 0.5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: kBlackColor),
                child: Obx(
                  () => TextButton(
                      onPressed: () {
                        cntrl.resetPassword();
                      },
                      child: cntrl.loading.value
                          ? CircularProgressIndicator(
                              color: kWhiteColor,
                            )
                          : Text(
                              "Send Email",
                              style: normalTextStyleWhite,
                            )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
