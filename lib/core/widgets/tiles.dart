// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../helpers/functions/functions.dart';
import '../utils/colors.dart';
import '../utils/references.dart';

class CustomListTileWidget extends StatelessWidget {
  final String title;
  final String subtitle, imgurl;
  final String role;
  final VoidCallback? accpet, reject;
  const CustomListTileWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imgurl,
    required this.accpet,
    required this.reject,
    this.role = "",
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: imgurl.isNotEmpty ? NetworkImage(imgurl) : null,
        child: imgurl.isEmpty ? Text(getInitialCharacters(title)) : null,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          reject != null
              ? IconButton(
                  constraints: const BoxConstraints(),
                  splashRadius: 25,
                  onPressed: reject,
                  icon: SvgPicture.asset(Assets.reject))
              : const Offstage(),
          accpet != null
              ? IconButton(
                  constraints: const BoxConstraints(),
                  splashRadius: 25,
                  onPressed: accpet,
                  icon: SvgPicture.asset(Assets.accept))
              : const Offstage(),
        ],
      ),
      title: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: title),
            TextSpan(
                text: role,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
      ),
      subtitle: Text(subtitle),
    );
  }
}

class TapTileWidget extends StatelessWidget {
  final String? iconRef;
  final VoidCallback onTap;
  final String title;
  final Color? textColor;
  final Color? iconColor;
  const TapTileWidget({
    super.key,
    required this.onTap,
    required this.title,
    this.textColor,
    this.iconColor,
    this.iconRef,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SvgPicture.asset(
              iconRef ?? "",
              width: 20,
              color: iconColor ?? Colors.black,
            ),
            const SizedBox(width: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  const TitleWidget({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const radius = 12.0;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(radius),
      child: Ink(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(
                color: AppColor.blue,
              )),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Text(
              title,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ),
      ),
    );
  }
}

class CardTileWidget extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  const CardTileWidget({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
