import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fusion_sync/presantetion/login/login_screen.dart';
import 'package:fusion_sync/presantetion/main/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    forCheck();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "asset/images/Vector 1.png",
              width: size.width * 0.9,
              height: size.width * 0.5,
              scale: .5,
            ),
            Image.asset("asset/images/Union.png"),
            SizedBox(
              height: size.height * 0.03,
            ),
            const Text(
              "For strengthen the bonds 💌",
              style: TextStyle(color: Colors.blue),
            )
          ],
        ),
      ),
    );
  }

  forCheck() async {
    await Future.delayed(Duration(seconds: 3));
    if (auth.currentUser != null || auth.currentUser!.emailVerified == true) {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return MainScreen();
        },
      ));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return SigninScreen();
        },
      ));
    }
  }
}
