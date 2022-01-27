// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_instance/src/extension_instance.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hive/hive.dart';
// import 'package:student_records/controller/studenrecordcontroller.dart';

// import 'package:student_records/pages/record_adapter.dart';
// import 'package:student_records/pages/student_detials.dart';

// class UpdateRecord extends StatelessWidget {
//   UpdateRecord({
//     Key? key,
//     required this.title2,
//     required this.age2,
//     required this.place2,
//     required this.box2,
//     required this.index2,
//   }) : super(key: key);

//   late String title2;
//   late int age2;
//   late String place2;
//   late dynamic box2;
//   late int index2;
 
//   final formkey = GlobalKey<FormState>();
//   Box<Record> box = Hive.box<Record>('records');
//   final studentrecordcontrolleer = Get.put(studentrecordcontrollee);
//   final studencontrol = Get.find<studentrecordcontrollee>();

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       // backgroundColor: Colors.grey[200],
//       title: Text(
//         "Edit Detials",
//         style: GoogleFonts.rubik(
//           fontStyle: FontStyle.normal,
//           fontWeight: FontWeight.w500,
//           fontSize: 20,
//         ),
//       ),
//       content: Form(
//         key: formkey,
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               SizedBox(height: 8),
//               buildName(),
//               SizedBox(height: 8),
//               buildAge(),
//               SizedBox(height: 8),
//               buildPlace(),
//             ],
//           ),
//         ),
//       ),
//       actions: <Widget>[
//         cancelButton(context),
//         submitButton(context),
//       ],
//     );
//   }

//   Widget buildAge() => Container(
//         child: Builder(
//           builder: (context) {
//             Record? record = box2.getAt(index2);
//             return TextFormField(
//               initialValue: age2.toString(),
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: ' Student Age',
//               ),
//               validator: (value) {
//                 if (value == "") {
//                   return "Student Age required";
//                 }
//               },
//               onChanged: (value) {
//                 if (value.isNotEmpty) {
//                   record!.age = int.parse(value);
//                   // record.save();
//                 }
//               },
//             );
//           },
//         ),
//       );

//   Widget buildName() => Container(
//         child: Builder(
//           builder: (context) {
//             Record? record = box2.getAt(index2);
//             return TextFormField(
//               initialValue: title2,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: 'Student Name',
//               ),
//               validator: (value) {
//                 if (value == "") {
//                   return "Student Name required";
//                 }
//               },
//               onChanged: (value) {
//                 record!.title = value;
//                 // record.save();
//               },
//             );
//           },
//         ),
//       );
//   Widget buildPlace() => Container(
//         child: Builder(
//           builder: (context) {
//             Record? record = box2.getAt(index2);
//             return TextFormField(
//               initialValue: place2,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: 'Student Place',
//               ),
//               validator: (value) {
//                 if (value == "") {
//                   return "Student Place required";
//                 }
//               },
//               onChanged: (value) {
//                 record!.place = value;
//                 // record.save();
//               },
//             );
//           },
//         ),
//       );
//   Widget cancelButton(BuildContext context) => TextButton(
//         child: Text(
//           'Cancel',
//           style: TextStyle(color: Colors.black),
//         ),
//         onPressed: () => Navigator.of(context).pop(),
//       );
//   Widget submitButton(BuildContext context) => Builder(
//         builder: (context) {
//           Record? record = box2.getAt(index2);
//           return ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               primary: Colors.grey[200],
//             ),
//             onPressed: () {
//               if (formkey.currentState!.validate()) {
//                 // Navigator.pop(context);
//                 // Get.back();

//                 Get.off(StudentDetails(record!.title, record.age, record.place,
//                     record.pic, index2, box2));
//                 studencontrol.update();
//                 record.save();

//                 Get.back();
//               }
//             },
//             child: Text(
//               'Save',
//               style: TextStyle(color: Colors.teal[300]),
//             ),
//           );
//         },
//       );
// }
