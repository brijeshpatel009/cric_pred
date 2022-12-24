// ignore_for_file: file_names
//
// import 'package:flutter/material.dart';
// import '../controller/User_Data.dart';
// import '../Custom/my_icons_icons.dart';
// import '../controller/variable.dart';
//
// AppBar appBar() {
//   return AppBar(
//     elevation: 0,
//     flexibleSpace: Container(
//       decoration: const BoxDecoration(
//         image: DecorationImage(image: AssetImage('asset/appbar.png'), fit: BoxFit.fill),
//       ),
//       child: Row(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(5.0),
//             child: ClipRRect(
//               borderRadius: const BorderRadius.only(
//                   bottomLeft: Radius.circular(12), bottomRight: Radius.circular(3), topRight: Radius.circular(3), topLeft: Radius.circular(3)),
//               child: GestureDetector(
//                 onTap: (){
//                   setState(() {
//                     tabBarIndex = 1;
//                   });
//                 },
//                 child: const Image(image: AssetImage('asset/prflImg.png'), fit: BoxFit.fill),
//               ),
//             ),
//           ),
//           Text(
//             userName,
//             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//           ),
//           const Spacer(),
//           Padding(
//             padding: const EdgeInsets.only(left: 80, right: 10, top: 10, bottom: 10),
//             child: Container(
//               width: 120,
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   color: Colors.black,
//                   width: 1.5,
//                 ),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(5.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: const [
//                     Icon(MyIcons.wallet__1_),
//                     Text(
//                       '0.00',
//                       style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     ),
//     automaticallyImplyLeading: false,
//     backgroundColor: Colors.transparent,
//   );
// }
