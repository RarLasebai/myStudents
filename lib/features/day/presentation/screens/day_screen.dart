// ignore_for_file: curly_braces_in_flow_control_structures, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_students/core/utils/widgets/txt_style.dart';
import 'package:my_students/features/day/application/student_bloc/student_states.dart';
import 'package:my_students/features/day/data/model/student_model.dart';
import 'package:my_students/features/day/presentation/widgets/daily_student_grade_widget.dart';
import 'package:my_students/features/day/presentation/widgets/start_of_the_day_popup.dart';

import '../../../../core/utils/widgets/loading_widget.dart';
import '../../application/student_bloc/student_cubit.dart';

class DayScreen extends StatelessWidget {
  const DayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    TextEditingController searchController = TextEditingController();

    return Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: BlocConsumer<StudentCubit, StudentStates>(
                listener: (context, studentState) {
              if (studentState is ErrorStudentState) {
                Center(
                  child: TxtStyle(studentState.message.toString(), 16,
                      Colors.black, FontWeight.bold),
                );
              }
            }, builder: (context, studentState) {
              // AppCubit cubit = AppCubit.get(context);
              StudentCubit cubit = StudentCubit.get(context);

              if (studentState is StudentsLoadedState) {
                if (studentState.students.isEmpty) {
                  return const Center(
                      child: TxtStyle("لا يوجد طلبة مسجلين بعد!", 16,
                          Colors.grey, FontWeight.w500,
                          textAlignm: TextAlign.center));
                } else {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        // SearchTextField(
                        //   hint: "أدخل اسم الطالب...",
                        //   controller: searchController,
                        //   onChanged: (text) {
                        //     cubit.filterdStudents = studentState.students
                        //         .where((studetn) => studetn.studentName!
                        //             .contains(text!.toLowerCase()))
                        //         .toList();
                        //         cubit.addToFilter(student);
                        //   },
                        // ),
                        SizedBox(height: 12.h),
                        ...studentState.students
                            .map(
                              (student) => GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return StarOfTheDayPopup(
                                            starType: "اليوم",
                                            name:
                                                student.studentName.toString(),
                                          );
                                        });
                                  },
                                  child: BlocProvider.value(
                                    value: cubit,
                                    child: Dismissible(
                                      onDismissed: (direction) {
                                        cubit
                                            .deleteOneStudent(
                                                student.studentId!)
                                            .then(
                                                (value) => cubit.getStudents());
                                      },
                                      direction: DismissDirection.endToStart,
                                      background: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(30.0.r),
                                        ),
                                        alignment: Alignment.centerLeft,
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                        ),
                                      ),
                                      key: Key(student.studentId.toString()),
                                      child: DailyStudentGradeWidget(
                                        cubit: cubit,
                                        studentModel: StudentModel(
                                          studentId: student.studentId,
                                          studentGrade: student.studentGrade,
                                          studentName: student.studentName,
                                          studentNote: student.studentNote,
                                          studentStars: student.studentStars,
                                          studentTotalGrades:
                                              student.studentTotalGrades,
                                        ),
                                      ),
                                    ),
                                  )),
                            )
                            .toList(),
                      ],
                    ),
                  );
                }
              } else {
                return const LoadingWidget();
              }
            })));
  }
}
