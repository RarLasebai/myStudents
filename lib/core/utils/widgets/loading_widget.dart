import 'package:flutter/material.dart';
import 'package:my_students/core/utils/colors/colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: primary),
    );
  }
}
