import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_students/core/utils/colors/colors.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final bool isNote;
  final TextEditingController? controller;
  final int width;
  final bool isGrade, isUpdate;
  final VoidCallback? onTap;

  final FormFieldValidator<String> validator;

  const CustomTextField({
    required this.hint,
    required this.isGrade,
    required this.controller,
    required this.validator,
    this.isUpdate = false,
    this.onTap,
    this.width = 263,
    this.isNote = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Center(
        child: TextFormField(
          keyboardType:
              isGrade == true ? TextInputType.number : TextInputType.text,
          inputFormatters: [
            LengthLimitingTextInputFormatter(14),
          ],
          validator: validator,
          controller: controller,
          style: TextStyle(
              fontFamily: 'Cairo',
              color: Colors.black,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            suffixIcon: isNote
                ? GestureDetector(
                    onTap: onTap,
                    child: const Icon(
                      Icons.clear,
                      color: Colors.red,
                    ))
                : null,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(color: primary)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(color: primary)),
            hintText: hint,
            hintStyle: TextStyle(
                fontFamily: 'Cairo',
                color: isUpdate
                    ? Colors.black
                    : isUpdate && isNote
                        ? softGrey
                        : darkGrey,
                fontSize: isUpdate ? 14.sp : 12.sp,
                fontWeight:
                    isUpdate && isNote ? FontWeight.normal : FontWeight.bold),
            errorStyle: TextStyle(
                height: 0,
                fontFamily: 'Cairo',
                color: Colors.red,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(color: Colors.red)),
            errorBorder: OutlineInputBorder(
              gapPadding: 0,
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(8.r),
            ),
            enabledBorder: OutlineInputBorder(
              gapPadding: 0,
              borderSide: const BorderSide(color: primary),
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
        ),
      ),
    );
  }
}
