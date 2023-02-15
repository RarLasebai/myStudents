import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_students/core/utils/colors/colors.dart';
import 'package:my_students/core/utils/widgets/custom_button.dart';
import 'package:my_students/core/utils/widgets/custom_text_field.dart';
import 'package:my_students/core/utils/widgets/txt_style.dart';
import 'package:my_students/features/day/application/student_bloc/student_cubit.dart';

import '../../../../core/utils/widgets/loading_widget.dart';
import '../../application/student_bloc/student_states.dart';
import '../../data/model/student_model.dart';

class AddGradePopup extends StatelessWidget {
  final StudentModel studentModel;

  const AddGradePopup({required this.studentModel, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<StudentCubit>(context),
      child: BlocConsumer<StudentCubit, StudentStates>(
          listener: ((context, state) {}),
          builder: (context, state) {
            StudentCubit cubit = StudentCubit.get(context);
            return Form(
              key: cubit.formKeyAddGrade,
              child: Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r)),
                elevation: 0.0,
                backgroundColor: Colors.white,
                child: Container(
                  // width: 302.w,
                  height: 240.h,
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
                        const TxtStyle("إضافة درجة اليوم", 15, Colors.black,
                            FontWeight.bold),
                        Padding(
                          padding: const EdgeInsets.only(top: 16, bottom: 11),
                          child: CustomTextField(
                            hint: "أدخل درجة اليوم",
                            isGrade: true,
                            controller: cubit.gradeController,
                            width: 118,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "من فضلك لا تترك الحقل فارغاً";
                              } else if (int.parse(value) > 100) {
                                return "أدخل قيمة أقل من مائة!";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        if (state is UpdateGradeLoadingState)
                          const LoadingWidget()
                        else if (state is UpdateGradeLoadedState)
                          CustomButton(
                              text: "تم الحفظ",
                              width: 100,
                              onTap: () => Navigator.pop(context))
                        else
                          CustomButton(
                              text: "حفظ",
                              width: 100,
                              onTap: () {
                                if (cubit.formKeyAddGrade.currentState!
                                    .validate()) {
                                  cubit
                                      .updateGrade(studentModel)
                                      .then((value) => cubit.getStudents())
                                      .then((value) => Navigator.pop(context));
                                }
                              })
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
