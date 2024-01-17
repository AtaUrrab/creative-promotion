import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../utils/loading_helper.dart';
import '../widgets/native_action_sheet.dart';

class HelperClass {
  final ImagePicker _imagePicker = ImagePicker();

  bottomSheetImagePicker(BuildContext context) async {
    XFile? file;
    await showAdaptiveActionSheet(
      context: context,
      title: const Text('Profile photo'),
      androidBorderRadius: 30,
      actions: [
        BottomSheetAction(
            title: const Text('Gallery'),
            onPressed: () async {
              file = await _pickImage(ImageSource.gallery);
              Get.back();
            }),
        BottomSheetAction(
            title: const Text('Camera'),
            onPressed: () async {
              file = await _pickImage(ImageSource.camera);
              Get.back();
            }),
      ],
      cancelAction: CancelAction(title: const Text('Cancel')),
    );
    if (file != null) {
      return file;
    } else {
      return;
    }
  }

  _pickImage(ImageSource source) async {
    try {
      await Permission.photos.status;
      LoadingHelper.showLoading();
      final XFile? pickedFile = await _imagePicker.pickImage(
          source: source, maxHeight: 200, maxWidth: 200);
      // if (pickedFile != null) {
      //   final dir = await path_provider.getTemporaryDirectory();
      //   final targetPath =
      //       '${dir.absolute.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
      //   final XFile? compressedImage =
      //       await FlutterImageCompress.compressAndGetFile(
      //     pickedFile.path,
      //     targetPath,
      //     minHeight: 1080,
      //   );
      LoadingHelper.hideLoading();
      return pickedFile;
      // }
    } catch (e) {
      LoadingHelper.hideLoading();
      return null;
    }
  }
}
