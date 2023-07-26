import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fusion_sync/infrastructure/user_model.dart';
import 'package:fusion_sync/presantetion/login/login_screen.dart';
import 'package:fusion_sync/presantetion/main/main_screen.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController loginemail = TextEditingController();
  TextEditingController loginpassword = TextEditingController();
  TextEditingController resetemail = TextEditingController();
  var loading = false.obs;

  signup() async {
    try {
      loading.value = true;
      await auth.createUserWithEmailAndPassword(
          email: email.text, password: password.text);
      addUser();
      verifyEmail();
      Get.offAll(() => MainScreen());
      loading.value = false;
    } catch (e) {
      Get.snackbar("error", "$e");
      loading.value = false;
    }
  }

  addUser() async {
    UserModel user = UserModel(
      username: username.text,
      email: auth.currentUser?.email,
    );
    await db
        .collection("user")
        .doc(auth.currentUser?.uid)
        .collection("profile")
        .add(user.tomap());
  }

  signOut() async {
    await auth.signOut();
    Get.offAll(SigninScreen());
  }

  signIn() async {
    try {
      loading.value = true;
      await auth.signInWithEmailAndPassword(
          email: loginemail.text, password: loginpassword.text);
      Get.offAll(() => MainScreen());
      loading.value = false;
    } catch (e) {
      Get.snackbar("error", "$e");
      loading.value = false;
    }
  }

  verifyEmail() async {
    await auth.currentUser?.sendEmailVerification();
    Get.snackbar("email", "send");
  }

  resetPassword() async {
    try {
      await auth.sendPasswordResetEmail(email: resetemail.text);
      Get.snackbar("email", "send successfully");
      Get.off(() => SigninScreen());
    } catch (e) {
      Get.snackbar("error", "$e");
    }
  }
}
