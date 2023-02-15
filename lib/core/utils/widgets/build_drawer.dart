// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_students/core/utils/widgets/are_you_sure_popup.dart';
import 'package:my_students/core/utils/widgets/txt_style.dart';
import 'package:my_students/features/day/application/student_bloc/student_cubit.dart';

import '../colors/colors.dart';

class BuildDrawer extends StatelessWidget {
  final StudentCubit studentCubit;
  const BuildDrawer({required this.studentCubit, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: studentCubit,
      child: Drawer(
        backgroundColor: primary,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.only(top: 60),
                child: const Center(
                    child: TxtStyle(
                        "الاختصارات ", 16, Colors.white, FontWeight.bold)),
              ),
              SizedBox(
                height: 20.h,
              ),
              DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton(
                      borderRadius: BorderRadius.circular(30.r),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                        size: 25.sp,
                      ),
                      isExpanded: true,
                      alignment: Alignment.centerLeft,
                      hint: Padding(
                        padding: const EdgeInsets.only(top: 14),
                        child: Row(
                          children: [
                            Icon(
                              Icons.sort_by_alpha_rounded,
                              color: Colors.white,
                              size: 25.sp,
                            ),
                            SizedBox(
                              width: 27.w,
                            ),
                            Text(
                              "ترتيب الأسماء حسب:",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      style: TextStyle(
                        // decoration: textDecoration,
                        decorationColor: Colors.black,
                        fontFamily: 'Cairo',
                        color: Colors.black,
                        fontSize: 14.sp,

                        fontWeight: FontWeight.bold,
                      ),
                      items: [
                        DropdownMenuItem(
                          value: "الدرجات",
                          onTap: () {
                            studentCubit
                                .getStudents()
                                .then((value) => Navigator.pop(context));
                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "الدرجات",
                            ),
                          ),
                        ),
                        DropdownMenuItem(
                          value: "الأحرف الأبجدية",
                          onTap: () {
                            studentCubit
                                .getStudents(isAlpha: true)
                                .then((value) => Navigator.pop(context));
                          },
                          child: Align(
                              alignment: Alignment.center,
                              child: Text("الأحرف الأبجدية")),
                        ),
                      ],
                      onChanged: (value) {}),
                ),
              ),
              ListTile(
                leading:
                    const Icon(Icons.restore_outlined, color: Colors.white),
                title: const TxtStyle(
                    "تصفير الدرجات", 14, Colors.white, FontWeight.bold),
                onTap: () {
                  showDialog(
                          context: context,
                          builder: (_) => BlocProvider.value(
                              value: studentCubit,
                              child: const AreYouSurePopup()))
                      .then((value) => Navigator.pop(context));
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.delete_forever,
                  color: Colors.white,
                  size: 26,
                ),
                title: const TxtStyle(
                    "حذف جميع الطلبة", 14, Colors.white, FontWeight.bold),
                onTap: () {
                  showDialog(
                          context: context,
                          builder: (_) => BlocProvider.value(
                              value: studentCubit,
                              child: const AreYouSurePopup(
                                  isDeleteStudents: true)))
                      .then((value) => Navigator.pop(context));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
