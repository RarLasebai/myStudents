// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_students/core/utils/colors/colors.dart';
import 'package:my_students/core/utils/widgets/txt_style.dart';

class WeeklyStudentGradeWidget extends StatelessWidget {
  final String? name, stars, grade;
  const WeeklyStudentGradeWidget({
    super.key,
    required this.name,
    required this.stars,
    required this.grade,
  });

  @override
  Widget build(BuildContext context) {
    //colors for grade logic
    Color color;
    double gradeToInt = double.parse(grade!);
    if (50 >= gradeToInt && gradeToInt >= 0) {
      color = Colors.red;
    } else if (75 >= gradeToInt && gradeToInt >= 51) {
      color = Color.fromARGB(255, 7, 83, 145);
    } else if (gradeToInt >= 76) {
      color = Colors.green;
    } else {
      color = Colors.black;
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 13.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: primary,
            ),
            borderRadius: BorderRadius.circular(30.0.r),
          ),
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20,
            top: 11,
            bottom: 11,
          ),
          child: Column(
            children: [
              TxtStyle(name!, 14, Colors.black, FontWeight.bold),
              SizedBox(
                height: 13.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const TxtStyle(
                          "المجموع", 12, darkGrey, FontWeight.normal),
                      TxtStyle(grade!, 16, color, FontWeight.bold),
                    ],
                  ),
                  Column(
                    children: [
                      const TxtStyle(
                          "عدد النجوم", 12, darkGrey, FontWeight.normal),
                      TxtStyle(stars!, 16, Colors.black, FontWeight.bold),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
