import 'dart:convert';

import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:student_records/controller/studenrecordcontroller.dart';
import 'package:student_records/pages/home_page.dart';
import 'package:student_records/pages/record_adapter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Addrecord extends StatelessWidget {
  final formkey = GlobalKey<FormState>();

//   @override
//   _AddrecordState createState() => _AddrecordState();
// }

// class _AddrecordState extends State<Addrecord> {
  final studentrecordcontrolleer = Get.find<studentrecordcontrollee>();
  // final studentcolloer = Get.put(studentrecordcontrollee());
  String? title, place;
  int? age;
  dynamic pic;
  
  // submitData(context) async {
  //   if (formkey.currentState!.validate()) {
  //     // Box<Record> todoBox = Hive.box<Record>('records');
  //     // todoBox.add(
  //     //   Record(title, age, place, pic),
  //     // );
  //     studentrecordcontrolleer.addStudent(title!, age!, place!, pic);
  //     // Navigator.pushReplacement(
  //     //   context,
  //     //   MaterialPageRoute(
  //     //     builder: (context) => HomePage(),
  //     //   ),
  //     // );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[200],
      title: Text(
        "Add  Student",
        style: GoogleFonts.rubik(
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500,
          fontSize: 20,
        ),
      ),
      content: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 5),
              ProfileImage(),
              SizedBox(height: 8),
              buildName(),
              SizedBox(height: 5),
              buildAge(),
              SizedBox(height: 5),
              buildPlace(),
              // SizedBox(height: 5),
              // buildImage(),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        cancelButton(context),
        submitButton(context),
      ],
    );
  }

  Widget ProfileImage() => GetBuilder<studentrecordcontrollee>(
      builder: (_) => GestureDetector(
            child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: studentrecordcontrolleer.imagebyte == null
                    ? CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/download.png'),
                        radius: 70,
                      )
                    : Image.memory(
                        studentrecordcontrolleer.imagebyte!,
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      )),
                      onTap: () async{
                        pic=await studentrecordcontrolleer.pickImage(ImageSource.gallery);
                        
                      },
          ));
  // if (pic != null) {
  //   Uint8List imageBytes = base64Decode(pic);
  //   return Container(
  //     child: GestureDetector(
  //       child: Container(
  //         clipBehavior: Clip.hardEdge,
  //         decoration: BoxDecoration(
  //           shape: BoxShape.circle,
  //         ),
  //         child: Image.memory(
  //           imageBytes,
  //           height: 130,
  //           width: 130,
  //           fit: BoxFit.cover,
  //         ),
  //       ),
  //       // onTap: () => pickImage(ImageSource.gallery),
  //     ),
  //   );
  // }
  // return GestureDetector(
  //   child: CircleAvatar(

  //     backgroundImage: AssetImage(
  //       "assets/images/download.png",

  //     ),
  //     radius: 50,

  //   ),
  //   // onTap: () => pickImage(ImageSource.gallery),
  // );

  File? image;
  dynamic path;
  // pickImage(ImageSource source) async {
  //   final image = await ImagePicker().pickImage(source: source);
  //   if (image != null) {
  //     Uint8List imageBytes = await image.readAsBytes();
  //     pic = base64Encode(imageBytes);
  //   }
  //   setState(
  //     () {
  //       if (image != null) {
  //         path = image.path;

  //       }
  //     },
  //   );
  //     // if (image != null) {
  //     //     path = image.path;

  //     //   }

  // }

  Widget buildName() => Container(
        child: TextFormField(
          decoration: InputDecoration(
            // border: OutlineInputBorder(),
            hintText: 'Enter Name',
          ),
          validator: (value) {
            if (value == "") {
              return "Student Name required";
            }
          },
          onChanged: (value) {
            title = value;
          },
        ),
      );

  Widget buildPlace() => Container(
        child: TextFormField(
          decoration: InputDecoration(
            // border: OutlineInputBorder(),
            hintText: ' Place',
          ),
          validator: (value) {
            if (value == "") {
              return "Place Name required";
            }
          },
          onChanged: (value) {
            place = value;
          },
        ),
      );
  Widget buildAge() => Container(
        child: TextFormField(
          decoration: InputDecoration(
            // border: OutlineInputBorder(),
            hintText: 'Enter  Age',
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == "") {
              return "Age required";
            }
          },
          onChanged: (value) {
            age = int.parse(value);
          },
        ),
      );
  Widget cancelButton(BuildContext context) => TextButton(
        child: Text(
          'Cancel',
          style: TextStyle(color: Colors.black),
        ),
        onPressed: () => Navigator.of(context).pop(),
      );
  Widget submitButton(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.teal[300],
        ),
        onPressed: () {
          if (formkey.currentState!.validate()) {
            // Box<Record> Boxto = Hive.box<Record>('records');
            // Boxto.add(
            //   Record(
            //     title,
            //     age,
            //     place,
            //     pic,
            //   ),
            // );
            studentrecordcontrolleer.addStudent(title!, age!, place!, pic);
            studentrecordcontrolleer.imagebyte==null;

            Get.back();
          }
        },
        child: Text(
          'Save',
          style: TextStyle(color: Colors.black),
        ),
      );
}
