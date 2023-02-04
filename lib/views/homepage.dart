import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_tag/constants/colors.dart';
import 'package:image_tag/views/settings.dart';

import '../constants/fonts.dart';

class MyHomepage extends StatefulWidget {
  const MyHomepage({Key? key}) : super(key: key);

  @override
  State<MyHomepage> createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: kBlackColor,
        elevation: 0,

        title: Text(
          "TORNADO",
          style: fontMontserrat(color: kWhiteColor, fontSize: 28, letterSpacing: 1),
        ),
        actions: [

        ],

      ),
      drawer: Drawer(
        backgroundColor: kBlackColor,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: kSecondaryColor,
              ),
              child: Center(child: Text('Drawer Header')),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
              ),
              title: const Text('Page 1',style: fontMontserrat(color: ),),
              onTap: () {
                Navigator.pop(context);
              },
            ),

          ],
        ),
      ),
      body: ListView(
        physics: ScrollPhysics(),
        children: [
          Container(
            height: Get.height / 2.8,
            width: Get.width,
            color: kBlackColor,
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              children: [

                SizedBox(
                  height: 20,
                ),
                Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: "We build \n", style: fontMontserrat(fontSize: 43, letterSpacing: 1)),
                        TextSpan(text: "while\n", style: fontMontserrat(fontSize: 46, color: kYellowColor, letterSpacing: 1)),
                        TextSpan(text: "you rest", style: fontMontserrat(fontSize: 43, color: kWhiteColor, letterSpacing: 1)),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  "We focus on quality and construction time, so that our clients are satisfied.",
                  textAlign: TextAlign.center,
                  style: fontMontserrat(color: kSecondaryColor, fontSize: 16, fontWeight: FontWeight.w100),
                ),
              ],
            ),
          ),
          Image.asset(
            "assets/construction.jpg",
            height: 350,
            fit: BoxFit.fill,
          ),
          Container(
            height: Get.height / 2,
            width: Get.width,
            color: kBlackColor,
            child: ListView(
              physics: NeverScrollableScrollPhysics(),

              children: [
                SizedBox(
                  height: 30,
                ),
                Text("About Tornado", textAlign: TextAlign.center, style: fontMontserrat(color: kWhiteColor, fontSize: 28, letterSpacing: 1)),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                  child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, "
                      "sunt in culpa qui officia deserunt mollit anim id est laborum.",
                      textAlign: TextAlign.center,
                      style: fontMontserrat(
                        color: kSecondaryColor,
                        fontSize: 13,
                         fontWeight: FontWeight.w100,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 28.0),
                  child: Image.asset(
                    "assets/tractor.jpg",
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
