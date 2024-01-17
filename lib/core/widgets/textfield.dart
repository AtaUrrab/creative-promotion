import 'package:flutter/material.dart';

import '../utils/colors.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final bool? enabled;
  final Widget? suffixIcon;
  final String? hintText;
  final bool obscureText;
  final bool obscureT;
  final Color? fillColor;
  final String? Function(String?)? validator;
  final void Function(String)? onChange;
  final void Function()? onTap;
  final bool? readyOnly;
  final TextInputType? keyboardType;
  final BorderSide? borderSide;
  final Widget? labelWidget;
  final FocusNode? focusNode;
  final int? maxlines;
  final bool isSnableMaxLines;
  const TextFieldWidget({
    super.key,
    this.controller,
    this.hintText,
    this.validator,
    this.fillColor,
    this.onChange,
    this.enabled,
    this.onTap,
    this.readyOnly,
    this.suffixIcon,
    this.obscureText = false,
    this.obscureT = false,
    this.keyboardType,
    this.borderSide,
    this.labelWidget,
    this.focusNode,
    this.maxlines,
    this.isSnableMaxLines = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChange,
      enabled: enabled,
      onTap: onTap,
      obscureText: obscureText,
      readOnly: readyOnly ?? false,
      keyboardType: keyboardType,
      focusNode: focusNode,
      maxLines: !isSnableMaxLines ? 1 : maxlines,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        border: InputBorder.none,
        hintText: hintText,
        filled: true,
        label: labelWidget,
        fillColor: fillColor ?? Colors.white,
        contentPadding:
            const EdgeInsets.only(left: 14.0, bottom: 6.0, top: 10.0),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.red),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: borderSide ?? const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.red),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      controller: controller,
      validator: validator,
    );
  }
}

class SearchTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;
  final String hintText;
  const SearchTextFieldWidget(
      {super.key,
      required this.controller,
      required this.hintText,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      decoration: InputDecoration(
        suffixIcon: const Icon(Icons.search),
        border: InputBorder.none,
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.only(left: 14.0, bottom: 6.0, top: 8.0),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      controller: controller,
    );
  }
}
