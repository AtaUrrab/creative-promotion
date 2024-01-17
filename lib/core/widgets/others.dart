import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helpers/functions/functions.dart';
import '../utils/colors.dart';

class CircleImage extends StatelessWidget {
  final String heading;
  final String? imageUrl;
  final File? imgAsset;
  final double size;
  final double? fontSize;
  final Color? circleColor, textColor;
  final bool isRegistration;
  final void Function()? onTap;
  final bool? isEditScreen;
  const CircleImage({
    Key? key,
    required this.heading,
    this.imageUrl,
    this.size = 60.0,
    this.fontSize,
    this.circleColor,
    this.textColor,
    this.isRegistration = false,
    this.onTap,
    this.imgAsset,
    this.isEditScreen = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: circleColor ?? Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                spreadRadius: 1.6,
                blurRadius: 2.1,
                offset: Offset(0, 2),
              ),
            ],
            border: Border.all(color: Colors.white, width: 2.0),
            shape: BoxShape.circle,
          ),
          child: (imageUrl == null || imageUrl!.isEmpty) && imgAsset == null
              ? Center(
                  child: isRegistration
                      ? const Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 40,
                        )
                      : Text(
                          getInitialCharacters(heading),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: true,
                          style: TextStyle(
                            fontSize: fontSize ?? 18.0,
                            color: textColor ?? AppColor.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(size / 2),
                  child: imgAsset == null
                      ? CachedImageWithLoader(
                          imgUrl: imageUrl!,
                          isRound: true,
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          imgAsset!,
                          fit: BoxFit.cover,
                        ),
                ),
        ),
        isEditScreen == false
            ? const Offstage()
            : Positioned(
                bottom: 0,
                right: 0,
                child: InkWell(
                  onTap: onTap,
                  child: const CircleAvatar(
                    radius: 19,
                    backgroundColor: Colors.grey,
                    child: Icon(
                      Icons.edit,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
      ]),
    );
  }
}

class CachedImageWithLoader extends StatelessWidget {
  final String imgUrl;
  final double? width, height;
  final BoxFit? fit;
  final Widget? errorWidget;
  final bool isRound;
  const CachedImageWithLoader({
    Key? key,
    required this.imgUrl,
    this.width,
    this.height,
    this.fit,
    this.errorWidget,
    this.isRound = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imgUrl,
      width: width,
      height: height,
      fit: fit,
      progressIndicatorBuilder: (context, s, p) => SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 160.0,
          child: const CupertinoActivityIndicator()),
      errorWidget: (context, s, d) =>
          errorWidget ??
          Container(
            width: MediaQuery.of(context).size.width,
            height: 300.0,
            color: Colors.black,
            child: const Icon(Icons.image, color: Colors.grey, size: 100.0),
          ),
    );
  }
}
