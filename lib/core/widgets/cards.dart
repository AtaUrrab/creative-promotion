import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../utils/colors.dart';
import '../utils/references.dart';
import 'others.dart';

class AgentsCardWidget extends StatelessWidget {
  final String imgUrl;
  final String name;
  final String email;
  final bool showIcon;
  final VoidCallback onTap;
  const AgentsCardWidget({
    super.key,
    required this.onTap,
    required this.showIcon,
    required this.name,
    required this.email,
    required this.imgUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              showIcon
                  ? const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [Icon(Icons.block, color: Colors.red)],
                    )
                  : const Offstage(),
              CircleImage(
                heading: name,
                imageUrl: imgUrl,
                size: 90,
                fontSize: 24,
              ),
              const SizedBox(height: 15),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              Text(
                email,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AttachImageWidget extends StatelessWidget {
  final String imgAssetPath;
  final String? imgUrl;
  final VoidCallback onTap;
  const AttachImageWidget({
    super.key,
    required this.imgAssetPath,
    required this.onTap,
    this.imgUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          child: imgAssetPath.isNotEmpty
              ? Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: Get.width * 0.45,
                  height: Get.width * 0.45,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.file(
                      File(imgAssetPath),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : imgUrl != null && imgUrl!.isNotEmpty
                  ? Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: Get.width * 0.45,
                      height: Get.width * 0.45,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: CachedImageWithLoader(
                          imgUrl: imgUrl!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : SvgPicture.asset(
                      Assets.scan,
                      width: Get.width * 0.45,
                    )),
    );
  }
}

class StockCardWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final void Function(BuildContext)? onEdit;
  final void Function(BuildContext)? onDelete;
  final bool isDisable;
  final String title;
  final String? quantity;
  final bool isSelected;
  final bool isPriceAvail;
  const StockCardWidget({
    super.key,
    required this.isSelected,
    required this.title,
    this.quantity,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.isDisable = false,
    this.isPriceAvail = false,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: isDisable
          ? null
          : ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: onEdit,
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  icon: Icons.edit,
                  spacing: 20,
                  label: 'Edit',
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                SlidableAction(
                  onPressed: onDelete,
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  spacing: 20,
                  label: 'Delete',
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                const SizedBox(width: 16)
              ],
            ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                  color: isSelected ? Colors.transparent : Colors.black),
              borderRadius: BorderRadius.circular(10),
              color: isSelected ? AppColor.red : null,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 35),
              child: isPriceAvail == false
                  ? Center(
                      child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: isSelected ? Colors.white : null,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ))
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: isSelected ? Colors.white : null,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 13.0),
                          child: Container(
                            height: 20,
                            width: 1.6,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            "$quantity  Pieces",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: isSelected ? Colors.white : null,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
