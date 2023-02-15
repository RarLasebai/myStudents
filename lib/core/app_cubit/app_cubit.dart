import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_students/core/app_cubit/app_states.dart';
import 'package:my_students/features/day/presentation/screens/day_screen.dart';
import 'package:my_students/features/week/presentation/screens/week_screen.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  //Variables
  //Bottom Navigation Bar
  int currentIndex = 0;
  List<String> title = [
    "التقييم اليومي",
    "التقييم الأسبوعي",
  ];
  List<Widget> screens = [
    const DayScreen(),
    const WeekScreen(),
  ];

  //Methods
  //Bottom Navigation Bar
  void changeBottomNavBarScreen(int index) {
    currentIndex = index;
    emit(BottomNavBarChangeScreenState());
  }
}
