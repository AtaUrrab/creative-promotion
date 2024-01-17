import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../screens/delete_account.dart';
import '../utils/references.dart';
import 'tiles.dart';

class ProfileDeleteButton extends StatelessWidget {
  const ProfileDeleteButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: Get.width * .01),
        Expanded(
          child: InkWell(
            onTap: () => Get.to(() => const DeleteUserAccount()),
            child: Container(
              // margin: EdgeInsets.only(
              //   left: Get.width * .01,
              //   // right: Get.width * .2,
              // ),
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8.0)),
              child: TapTileWidget(
                onTap: () => Get.to(() => const DeleteUserAccount()),
                title: "Delete Account",
                iconRef: Assets.deleteIcon,
                textColor: Colors.white,
                iconColor: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(width: 50),
      ],
    );
  }
}
