import 'package:flutter/material.dart';

import '../utils/colors.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  final Color? color;
  final TextStyle? titleStyle;
  final bool? isLoading;
  const AppButton({
    super.key,
    required this.onTap,
    required this.title,
    this.color,
    this.titleStyle,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      focusElevation: 0,
      onPressed: onTap,
      disabledColor: Colors.grey,
      color: color ?? AppColor.red,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: isLoading ?? false
          ? const CircularProgressIndicator()
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                title,
                style: titleStyle ?? const TextStyle(color: Colors.white),
              ),
            ),
    );
  }
}

class MyRadioListTile<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final String leading;
  final Widget? title;
  final ValueChanged<T?> onChanged;

  const MyRadioListTile({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.leading,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final title = this.title;
    return InkWell(
      onTap: () => onChanged(value),
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            _customRadioButton,
            const SizedBox(width: 12),
            if (title != null) title,
          ],
        ),
      ),
    );
  }

  Widget get _customRadioButton {
    final isSelected = value == groupValue;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : null,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.grey[300]!,
          width: 2,
        ),
      ),
      child: Text(
        leading,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.grey[600]!,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}
