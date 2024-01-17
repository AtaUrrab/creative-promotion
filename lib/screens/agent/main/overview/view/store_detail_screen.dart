import 'package:creativepromotion/core/widgets/others.dart';
import 'package:creativepromotion/screens/agent/main/overview/controller/store_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../models/store_model.dart';

class StoreDetailScreen extends StatelessWidget {
  final StoreModel store;
  const StoreDetailScreen({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StoreDetailController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          store.storeName,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text(
                    "Store Information",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => controller.downloadStoreData(store),
                    icon: const Icon(Icons.download),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 15,
                        offset: const Offset(0, 15),
                        color: Colors.black.withOpacity(0.1))
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Name: ",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        store.storeName,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Address: ",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        store.storeAddress,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Phone: ",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        store.storePhone,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Email: ",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        store.storeEmail,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Designation: ",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        store.designation.designation,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        store.designation.name,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        store.designation.email,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      if (store.additionalInfo.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            const Text(
                              "Additional Information: ",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              store.additionalInfo,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(height: 10),
                      const Text(
                        "Full Synthethic - OW-20 :",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        store.fullySyntyheticOW20,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Full Synthethic - 5W-20 :",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        store.fullySyntyhetic5W20,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Full Synthethic - 5W-30 :",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        store.fullySyntyhetic5W30,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "High Mileag - OW-20 :",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        store.highMileageOW20,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "High Mileag - 5W-20 :",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        store.highMileage5W20,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "High Mileag - 5W-30 :",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        store.highMileage5W30,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Advance - OW-20',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        store.advanceOW20,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Advance - 5W-20',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        store.advance5W20,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Advance - 5W-30',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        store.advance5W30,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Store Images",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 15,
                      offset: const Offset(0, 15),
                      color: Colors.black.withOpacity(0.1),
                    )
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ImagePreviewWidget(
                            imgUrl: store.images[0].imgUrl,
                          ),
                          const SizedBox(width: 10),
                          ImagePreviewWidget(
                            imgUrl: store.images[1].imgUrl,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Oil Placement Images",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 15,
                      offset: const Offset(0, 15),
                      color: Colors.black.withOpacity(0.1),
                    )
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ImagePreviewWidget(imgUrl: store.images[2].imgUrl),
                          const SizedBox(width: 10),
                          ImagePreviewWidget(imgUrl: store.images[3].imgUrl),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Visibility(
                  visible: store.images[4].imgUrl.isNotEmpty,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        "Cold Vault",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 15,
                              offset: const Offset(0, 15),
                              color: Colors.black.withOpacity(0.1),
                            )
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ImagePreviewWidget(
                                      imgUrl: store.images[4].imgUrl),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
              const SizedBox(height: 20),
              const Text(
                "Signature",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 15,
                      offset: const Offset(0, 15),
                      color: Colors.black.withOpacity(0.1),
                    )
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: AspectRatio(
                              aspectRatio: 4 / 1,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CachedImageWithLoader(
                                  imgUrl: store.signature.imgUrl,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class ImagePreviewWidget extends StatelessWidget {
  final String imgUrl;
  const ImagePreviewWidget({
    super.key,
    required this.imgUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: CachedImageWithLoader(
            fit: BoxFit.cover,
            imgUrl: imgUrl,
          ),
        ),
      ),
    );
  }
}
