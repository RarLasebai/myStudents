import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_students/core/utils/colors/colors.dart';
import 'package:my_students/core/utils/widgets/txt_style.dart';

// ignore: must_be_immutable
class TopNavBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final double titleSize;
  final bool isMainScreen;
  @override
  final Size preferredSize;
  TopNavBar(this.title,
      {Key? key, this.titleSize = 15, this.isMainScreen = true})
      : preferredSize = Size.fromHeight(46.0.h),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 30.w,
      // leading: GestureDetector(
      //   onTap: () {},
      //   child: const Icon(
      //     Icons.list_sharp,
      //     color: Colors.white,
      //   ),
      // ),
      iconTheme: const IconThemeData(color: Colors.white),
      elevation: 4,
      backgroundColor: primary,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isMainScreen
              ? Image.asset(
                  "assets/week_star.png",
                  height: 20.h,
                  width: 20.w,
                  color: Colors.white,
                )
              : Container(),
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: TxtStyle(
              title,
              titleSize,
              Colors.white,
              FontWeight.w700,
            ),
          ),
        ],
      ),
      centerTitle: true,
    );
  }
}
