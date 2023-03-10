import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:my_students/core/utils/colors/colors.dart';
import 'package:my_students/core/utils/widgets/custom_button.dart';
import 'package:my_students/core/utils/widgets/custom_text_field.dart';
import 'package:my_students/core/utils/widgets/txt_style.dart';
import 'package:my_students/features/day/application/student_bloc/student_cubit.dart';
import 'package:my_students/features/day/data/model/student_model.dart';

import '../../../../core/utils/widgets/loading_widget.dart';
import '../../application/student_bloc/student_states.dart';

class AddStudentPopup extends StatelessWidget {
  // final StudentCubit cubit;
  const AddStudentPopup({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController noteController = TextEditingController();
    TextEditingController gradeController = TextEditingController();
//  BlocProvider.of<StudentCubit>(context);

    return BlocProvider.value(
      value: BlocProvider.of<StudentCubit>(context),
      child: BlocConsumer<StudentCubit, StudentStates>(
          listener: (_, state) {},
          builder: (context, state) {
            StudentCubit cubit = StudentCubit.get(context);
            return Form(
              key: cubit.formKeyNewStudent,
              child: Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r)),
                elevation: 0.0,
                backgroundColor: Colors.white,
                child: Container(
                  width: 302.w,
                  height: 400.h,
                  decoration: BoxDecoration(
                      border: Border.all(color: primary, width: 1.5),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0.r)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 9, right: 16, left: 23, bottom: 13),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const TxtStyle("?????????? ???????? ????????", 15, Colors.black,
                            FontWeight.bold),
                        Padding(
                          padding: const EdgeInsets.only(top: 16, bottom: 11),
                          child: CustomTextField(
                            hint: "?????? ????????????",
                            isGrade: false,
                            controller: nameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "???? ???????? ???????? ??????????!";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        CustomTextField(
                            hint: "????????????",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "???? ???????? ???? ???????? ?????????? ????????????";
                              } else if (int.parse(value) > 100) {
                                return "???????? ???????? ?????? ???? ????????!";
                              } else {
                                return null;
                              }
                            },
                            isGrade: true,
                            controller: gradeController),
                        Padding(
                          padding: const EdgeInsets.only(top: 11, bottom: 11),
                          child: CustomTextField(
                            hint: " ????????????",
                            isGrade: false,
                            controller: noteController,
                            validator: (value) {
                              return null;
                            },
                          ),
                        ),
                        if (state is LoadingStudentState)
                          const LoadingWidget()
                        else if (state is ErrorStudentState)
                          const TxtStyle(
                              "?????? ?????? ????", 12, Colors.red, FontWeight.bold)
                        else
                          CustomButton(
                            text: "??????",
                            onTap: () {
                              if (cubit.formKeyNewStudent.currentState!
                                  .validate()) {
                                StudentModel studentMode = StudentModel(
                                  studentName: nameController.text,
                                  studentGrade:
                                      double.parse(gradeController.text),
                                  studentNote: noteController.text,
                                  studentStars: 0,
                                  studentTotalGrades:
                                      double.parse(gradeController.text),
                                );
                                cubit
                                    .addStudent(studentMode)
                                    .then((value) => Navigator.pop(context))
                                    .then((value) => cubit.getStudents())
                                    .then((value) {});
                              }
                            },
                            width: 100,
                          )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
