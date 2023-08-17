import 'package:flutter/material.dart';
import 'package:fusion_sync/controller/profile_controller.dart';
import 'package:fusion_sync/model/ui_constants/constants.dart';
import 'package:get/get.dart';

class EditProfilScreen extends StatelessWidget {
  EditProfilScreen({super.key});
  final proCntrl = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: kBlackColor,
            icon: Icon(Icons.cancel)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "irshad_abulla",
          style: blodText500,
        ),
        actions: [
          IconButton(
              onPressed: () {
                proCntrl.profiletextEdit();
                Navigator.pop(context);
              },
              color: kBlackColor,
              icon: Icon(Icons.done_rounded))
        ],
      ),
      body: SafeArea(
          child: Column(
        children: [
          StreamBuilder(
              stream: proCntrl.getInstance
                  .doc(proCntrl.auth.currentUser?.uid)
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                return snapshot.hasData
                    ? EditProfileForm(
                        thisCntrl: proCntrl.namecntrl,
                        text: "Name",
                        hintText: proCntrl.namecntrl.text =
                            snapshot.data['name'] ?? '',
                      )
                    : CircularProgressIndicator(
                        color: kBlackColor,
                      );
              }),
          StreamBuilder(
              stream: proCntrl.getInstance
                  .doc(proCntrl.auth.currentUser?.uid)
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                return snapshot.hasData
                    ? EditProfileForm(
                        thisCntrl: proCntrl.usernamecntrl,
                        text: "Username",
                        hintText: proCntrl.usernamecntrl.text =
                            snapshot.data['username'] ?? '',
                      )
                    : CircularProgressIndicator(
                        color: kBlackColor,
                      );
              }),
          StreamBuilder(
              stream: proCntrl.getInstance
                  .doc(proCntrl.auth.currentUser?.uid)
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                return snapshot.hasData
                    ? EditProfileForm(
                        thisCntrl: proCntrl.biocntrl,
                        text: "Bio",
                        hintText: proCntrl.biocntrl.text =
                            snapshot.data['bio'] ?? '',
                      )
                    : CircularProgressIndicator(
                        color: kBlackColor,
                      );
              }),
        ],
      )),
    );
  }
}

class EditProfileForm extends StatelessWidget {
  EditProfileForm(
      {super.key,
      required this.hintText,
      required this.text,
      required this.thisCntrl});
  String text;
  String hintText;
  TextEditingController thisCntrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
          child: Text(
            text,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600, color: kBlackColor),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
          child: TextFormField(
            controller: thisCntrl,
            decoration: textFormDoc.copyWith(
                hintText: hintText, hintMaxLines: text == "Bio" ? 4 : 1),
          ),
        ),
      ],
    );
  }
}
