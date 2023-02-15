import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_students/core/utils/colors/colors.dart';

class SearchTextField extends StatelessWidget {
  final String? hint;
  final TextEditingController? controller;
  final void Function(String?)? onChanged;

  const SearchTextField(
      {super.key,
      required this.controller,
      required this.hint,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: 47.h,
        width: 332.w,
        decoration: BoxDecoration(
          color: softGrey,
          borderRadius: BorderRadius.circular(30.0.r),
        ),
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 25,
          top: 14,
          bottom: 11,
        ),
        child: TextFormField(
          onChanged: onChanged,
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "من فضلك لا تترك الحقل فارغاً";
            } else {
              return null;
            }
          },
          controller: controller,
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(color: Colors.transparent)),
            hintText: hint,
            hintStyle: TextStyle(
                fontFamily: 'Cairo',
                color: darkGrey,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
        ),
      ),
    );
  }
}
