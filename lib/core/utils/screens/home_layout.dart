// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_students/core/app_cubit/app_cubit.dart';
import 'package:my_students/core/app_cubit/app_states.dart';
import 'package:my_students/core/utils/colors/colors.dart';
import 'package:my_students/core/utils/widgets/build_drawer.dart';
import 'package:my_students/core/utils/widgets/top_nav_bar.dart';
import 'package:my_students/features/day/application/student_bloc/student_cubit.dart';
// import 'package:my_students/features/day/application/student_bloc/student_cubit.dart';
import 'package:my_students/features/day/presentation/widgets/add_student_popup.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AppCubit()),
        BlocProvider(
          create: (BuildContext context) => StudentCubit()..getStudents(),
        )
      ],
      child: BlocConsumer<AppCubit, AppStates>(
          // AppCubit appCubit = AppCubit.get(context);
          listener: ((context, appState) {}),
          builder: ((context, appState) {
            AppCubit appCubit = AppCubit.get(context);
            StudentCubit studentCubit = StudentCubit.get(context);
            return Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                appBar: TopNavBar(appCubit.title[appCubit.currentIndex]),
                drawer: BlocProvider.value(
                    value: studentCubit,
                    child: BuildDrawer(
                      studentCubit: studentCubit,
                    )),
                body: appCubit.screens[appCubit.currentIndex],
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => BlocProvider.value(
                            value: studentCubit, child: AddStudentPopup()));
                    // .then((value) => appCubit.getStudents());
                  },
                  backgroundColor: const Color.fromARGB(255, 125, 147, 255),
                  child: const Icon(Icons.add),
                ),
                bottomNavigationBar: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.8),
                        spreadRadius: 1,
                        blurRadius: 13,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.r),
                      topRight: Radius.circular(8.r),
                    ),
                    child: BottomNavigationBar(
                      onTap: ((value) {
                        appCubit.changeBottomNavBarScreen(value);
                      }),
                      unselectedItemColor: Colors.black,
                      showUnselectedLabels: false,
                      currentIndex: appCubit.currentIndex,
                      selectedItemColor: primary,
                      selectedLabelStyle: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontFamily: 'Cairo',
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      backgroundColor: const Color(0xffECECEC),
                      items: const [
                        BottomNavigationBarItem(
                          icon: ImageIcon(
                            AssetImage("assets/day_star.png"),
                          ),
                          label: "درجات اليوم",
                        ),
                        BottomNavigationBarItem(
                            icon: ImageIcon(
                              AssetImage("assets/week_star.png"),
                            ),
                            label: "درجات الأسبوع")
                      ],
                    ),
                  ),
                ),
              ),
            );
          })),
    );
  }
}
