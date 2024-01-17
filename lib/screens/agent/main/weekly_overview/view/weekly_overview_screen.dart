// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../../../core/constant/constant.dart';
// import '../../../../../core/constant/enums.dart';
// import '../../../../../core/utils/colors.dart';
// import '../../../../../models/store_model.dart';
// import 'weekly_data_screen.dart';

// class WeeklyOverviewScreen extends StatelessWidget {
//   const WeeklyOverviewScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: const Text(
//           "Weekly Overview",
//           style: TextStyle(color: Colors.black),
//         ),
//       ),
//       body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
//           stream: FirebaseFirestore.instance
//               .collection(Collection.storeData.name)
//               .where("addById", isEqualTo: Constant.user!.uid)
//               .orderBy("createdAt")
//               .snapshots(),
//           builder: (context, snapshot) {
//             if (!snapshot.hasData || snapshot.data!.size == 0) {
//               return const Center(
//                 child: Text(
//                   "No Data Available!",
//                   style: TextStyle(fontSize: 16.0),
//                 ),
//               );
//             }
//             final List<StoreModel> stores = snapshot.data!.docs
//                 .map((doc) => StoreModel.fromMap(doc.data()))
//                 .toList();
//             List<StoreModel> currentWeek = [];
//             List<List<StoreModel>> weeklyData = [];
//             for (int i = 0; i < stores.length; i++) {
//               StoreModel currentDate = stores[i];
//               if (currentWeek.isEmpty ||
//                   currentDate.createdAt
//                           .toDate()
//                           .difference(currentWeek.first.createdAt.toDate())
//                           .inDays <=
//                       6) {
//                 currentWeek.add(currentDate);
//               } else {
//                 weeklyData.add(List.from(currentWeek));
//                 currentWeek.clear();
//                 currentWeek.add(currentDate);
//               }
//             }
//             weeklyData.add(currentWeek);
//             return ListView.builder(
//               itemCount: weeklyData.length,
//               shrinkWrap: true,
//               itemBuilder: (context, index) {
//                 final data = weeklyData[index];
//                 return Padding(
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//                   child: InkWell(
//                     splashColor: AppColor.red,
//                     onTap: () => _onTap(data, "Week ${index + 1}"),
//                     child: Container(
//                       padding: const EdgeInsets.all(15),
//                       decoration: BoxDecoration(
//                         border: Border.all(),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       child: Text(
//                         "Week ${index + 1}",
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
//           }),
//     );
//   }

//   void _onTap(List<StoreModel> data, String title) {
//     Get.to(() => WeeklyDataScreen(
//           data: data,
//           title: title,
//         ));
//   }
// }
