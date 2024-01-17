import 'package:flutter/material.dart';

import '../utils/colors.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({
    super.key,
    required this.onTap,
    required this.title,
    this.padding,
    this.color,
  });
  final VoidCallback onTap;
  final String title;
  final EdgeInsetsGeometry? padding;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: color ?? Colors.black,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: AppColor.lightGrey,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
