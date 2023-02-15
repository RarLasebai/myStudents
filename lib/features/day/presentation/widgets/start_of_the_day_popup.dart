import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_students/core/utils/colors/colors.dart';
import 'package:my_students/core/utils/widgets/txt_style.dart';

class StarOfTheDayPopup extends StatelessWidget {
  final String name;
  final String starType;
  const StarOfTheDayPopup(
      {required this.name, this.starType = "الأسبوع", super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
      elevation: 0.0,
      backgroundColor: Colors.white,
      child: Container(
        width: 302.w,
        height: 316.h,
        decoration: BoxDecoration(
            border: Border.all(color: primary, width: 1.5),
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.0.r)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/yellow_star.png"),
            SizedBox(height: 33.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TxtStyle("نجم $starType", 18, Colors.black, FontWeight.bold),
                SizedBox(width: 29.w),
              ],
            ),
            TxtStyle(name, 20, star, FontWeight.bold)
          ],
        ),
      ),
    );
  }
}
