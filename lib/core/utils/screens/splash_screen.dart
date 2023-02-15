import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_students/core/utils/colors/colors.dart';
import 'package:my_students/core/utils/screens/home_layout.dart';
import 'package:my_students/core/utils/widgets/txt_style.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
        Duration(seconds: 5),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeLayout())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: Container(
                width: 150.w,
                height: 150.h,
                child: Image.asset(
                  "assets/logo.png",
                  color: darkGrey,
                  width: 50.w,
                  height: 50.h,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            TxtStyle("طُـلّابي", 50, Colors.white, FontWeight.bold),

            SizedBox(
              height: 100,
            ),
            SpinKitWanderingCubes(
              color: Colors.white,
              size: 50,
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: TxtStyle(
            //     "حـفّز طُـلابَـك بدون مجـهود!",
            //     16,
            //     darkGrey,
            //     FontWeight.bold,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
