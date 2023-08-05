import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fusion_sync/infrastructure/user_model.dart';
import 'package:fusion_sync/presantetion/login/login_screen.dart';
import 'package:fusion_sync/presantetion/main/main_screen.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController loginemail = TextEditingController();
  TextEditingController loginpassword = TextEditingController();
  TextEditingController resetemail = TextEditingController();
  String profile = '';
  String coverPhoto = '';
  String name = '';
  String bio = '';
  var loading = false.obs;
  final _googleSignin = GoogleSignIn();

  signup() async {
    try {
      loading.value = true;
      await auth.createUserWithEmailAndPassword(
          email: email.text, password: password.text);
      addUser();
      verifyEmail();
      Get.offAll(() => SigninScreen());
      username.clear();
      email.clear();
      password.clear();
      loading.value = false;
    } catch (e) {
      Get.snackbar("error", "$e");
      loading.value = false;
    }
  }

  addUser() async {
    UserModel user = UserModel(
        username: username.text,
        name: name,
        email: auth.currentUser?.email,
        profilePic: profile,
        cover: coverPhoto,
        bio: bio,
        uid: auth.currentUser?.uid,
        followers: [],
        following: []);
    print("hello user added");
    await db.collection("user").doc(auth.currentUser?.uid).set(user.tomap());
  }

  signOut() async {
    await auth.signOut();
    await _googleSignin.signOut();
    Get.offAll(SigninScreen());
  }

  signIn() async {
    try {
      loading.value = true;
      await auth.signInWithEmailAndPassword(
          email: loginemail.text, password: loginpassword.text);
      auth.currentUser!.reload();
      if (auth.currentUser!.emailVerified == true) {
        Get.offAll(() => MainScreen());
        loginemail.clear();
        loginpassword.clear();
      } else {
        Get.snackbar("Not Verified", "Please verify your Email");
        verifyEmail();
      }
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
      resetemail.clear();
      Get.off(() => SigninScreen());
    } catch (e) {
      Get.snackbar("error", "$e");
    }
  }

  signInwithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignin.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        await auth.signInWithCredential(authCredential);
        if (auth.currentUser!.emailVerified == true ||
            auth.currentUser != null) {
          addUser();
          Get.offAll(() => MainScreen());
        } else {
          Get.offAll(() => SigninScreen());
        }
      }
    } on FirebaseAuth catch (e) {
      Get.snackbar("Message", "$e.Message");
      throw e;
    }
  }
}
