import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_tag/homepage.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
/*  @override
  void initState() {
    Future.delayed(Duration(seconds: 5),() {
      Get.to(()=>MyHomepage());
    });
    super.initState();
  }
  */
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: CircleAvatar(
          backgroundColor: Colors.blue.withOpacity(0.5),
            radius: 170,
            child: Lottie.asset("assets/splash.json",height: 280,width: 280)),
      ),
    );
  }
}
