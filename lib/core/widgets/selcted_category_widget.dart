import 'package:flutter/material.dart';

import '../utils/colors.dart';

class SelectCategoryWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final bool? isSelectedBox;
  const SelectCategoryWidget({
    super.key,
    this.onTap,
    this.isSelectedBox = false,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Row(
          children: [
            Icon(
              isSelectedBox == false
                  ? Icons.check_box_outline_blank_outlined
                  : Icons.check_box_sharp,
              color: isSelectedBox == false ? Colors.black : AppColor.blue,
            ),
            const SizedBox(width: 20),
            Text(
              title,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
