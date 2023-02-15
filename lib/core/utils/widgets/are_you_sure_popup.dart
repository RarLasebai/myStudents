import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_students/core/utils/colors/colors.dart';
import 'package:my_students/core/utils/widgets/loading_widget.dart';
import 'package:my_students/core/utils/widgets/txt_style.dart';
import 'package:my_students/features/day/application/student_bloc/student_cubit.dart';
import 'package:my_students/features/day/application/student_bloc/student_states.dart';

class AreYouSurePopup extends StatelessWidget {
  final bool isDeleteStudents;
  const AreYouSurePopup({this.isDeleteStudents = false, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<StudentCubit>(context),
      child: Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
          elevation: 0.0,
          backgroundColor: Colors.white,
          child: Container(
            width: 302.w,
            height: 146.h,
            decoration: BoxDecoration(
                border: Border.all(color: primary, width: 1.5),
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0.r)),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const TxtStyle(
                  "هل أنت متأكد؟", 15, Colors.black, FontWeight.bold),
              // SizedBox(height: 33.h),
              const TxtStyle(
                "إذا ضغطت على موافق، لا يمكنك\n التراجع عن هذا الإجراء",
                11,
                darkGrey,
                FontWeight.bold,
                sure: true,
                textAlignm: TextAlign.center,
              ),
              Center(
                child: Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const TxtStyle(
                            "إلغاء", 11, primary, FontWeight.bold)),
                            isDeleteStudents == false ?
                    BlocBuilder<StudentCubit, StudentStates>(
                        builder: (context, state) {
                      StudentCubit studentCubit = StudentCubit.get(context);
                      if (state is ResetGradesLoadingState) {
                        return const LoadingWidget();
                      } else {
                        return TextButton(
                            onPressed: () {
                              studentCubit
                                  .resetGrades()
                                  .then((value) => studentCubit.getStudents())
                                  .then((value) => Navigator.pop(context));
                            },
                            child: const TxtStyle(
                                "موافق", 11, Colors.red, FontWeight.bold));
                      }
                    }):
                     BlocBuilder<StudentCubit, StudentStates>(
                        builder: (context, state) {
                      StudentCubit studentCubit = StudentCubit.get(context);
                      if (state is DeleteStudentsLoadingState) {
                        return const LoadingWidget();
                      } else {
                        return TextButton(
                            onPressed: () {
                              studentCubit
                                  .deleteStudents()
                                  .then((value) => studentCubit.getStudents())
                                  .then((value) => Navigator.pop(context));
                            },
                            child: const TxtStyle(
                                "موافق", 11, Colors.red, FontWeight.bold));
                      }
                    }) ,
                  ],
                ),
              ),
            ]),
          )),
    );
  }
}
