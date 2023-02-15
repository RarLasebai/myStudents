import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_students/core/utils/widgets/custom_button.dart';
import 'package:my_students/core/utils/widgets/custom_text_field.dart';
import 'package:my_students/core/utils/widgets/top_nav_bar.dart';
import 'package:my_students/core/utils/widgets/txt_style.dart';
import 'package:my_students/features/day/data/model/student_model.dart';

import '../../../../core/utils/widgets/loading_widget.dart';
import '../../application/student_bloc/student_cubit.dart';
import '../../application/student_bloc/student_states.dart';

class UpdateStudentScreen extends StatelessWidget {
  final StudentModel studentModel;
  const UpdateStudentScreen({required this.studentModel, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<StudentCubit>(context),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: TopNavBar(
            "تعديل البيانات",
            isMainScreen: false,
          ),
          body: Padding(
            padding: const EdgeInsets.only(right: 46.0, left: 21, top: 27),
            child: Center(
                child: BlocConsumer<StudentCubit, StudentStates>(
                    listener: (context, s) {},
                    builder: (context, state) {
                      StudentCubit studentCubit = StudentCubit.get(context);
                      // StudentModel updatedStudentModel = StudentModel(
                      //   studentId: studentModel.studentId,
                      //   studentGrade: studentModel.studentGrade,
                      //   studentName: studentCubit.nameController.text.toString(),
                      //   studentNote: studentCubit.noteController.text.toString(),
                      //   studentStars: studentModel.studentStars,
                      //   studentTotalGrades: studentModel.studentTotalGrades,
                      // );

                      if (state is StudentUpdateState) {
                        return const LoadingWidget();
                      } else if (state is StudentUpdatedState) {
                        return CustomButton(
                            text: "تم التعديل بنجاح",
                            onTap: () {
                              Navigator.pop(context);
                            });
                      } else {
                        return Form(
                          key: studentCubit.formKeyUpdateStudent,
                          child: Column(
                            children: [
                              Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: const [
                                        Icon(Icons.person_outline_sharp),
                                        TxtStyle("   تعديل الاسم", 12,
                                            Colors.black, FontWeight.normal)
                                      ],
                                    ),
                                    CustomTextField(
                                      isUpdate: true,
                                      hint: studentModel.studentName!,
                                      isGrade: false,
                                      controller: studentCubit.nameController,
                                      width: 293,
                                      validator: (value) {
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, bottom: 32),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: const [
                                        Icon(Icons.edit_note),
                                        TxtStyle("   تعديل الملاحظة", 12,
                                            Colors.black, FontWeight.normal)
                                      ],
                                    ),
                                    CustomTextField(
                                      isNote: true,
                                      isUpdate: true,
                                      onTap: () {
                                        studentCubit.noteController.text = " ";
                                      },
                                      hint: studentModel.studentNote!,
                                      isGrade: false,
                                      controller: studentCubit.noteController,
                                      width: 293,
                                      validator: (value) {
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              CustomButton(
                                  text: "حفظ التعديلات",
                                  onTap: () {
                                    studentCubit
                                        .updateStudent(studentModel)
                                        .then((value) =>
                                            studentCubit.getStudents())
                                        .then(
                                            (value) => Navigator.pop(context));
                                  })
                            ],
                          ),
                        );
                      }
                    })),
          ),
        ),
      ),
    );
  }
}
/*
   
*/