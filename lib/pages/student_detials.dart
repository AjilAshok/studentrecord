import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_records/pages/home_page.dart';
import 'package:student_records/pages/record_adapter.dart';
import 'package:student_records/pages/update_record.dart';
import 'package:get/get.dart';
import 'package:student_records/controller/studenrecordcontroller.dart';

class StudentDetails extends StatelessWidget {
  final studentcolloer=Get.put(studentrecordcontrollee());
  final studentrecordcontrolleer=Get.find<studentrecordcontrollee>();
 
  // String name;
  Record? student;
  // int age;
  // String place;
  // dynamic pic;
  // final ind;
  // var box;
  StudentDetails({
    // this.name,
    // this.age,
    // this.place,
    // this.pic,
    // this.ind,
    // this.box,
     required this.student, 
  }
    
  );

  @override
  Widget build(BuildContext context) {
    // print(ind);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.edit,
              color: Colors.black,
            ),
            onPressed: () {
              // showDialog(
              //   context: context,
              //   builder: (context) => UpdateRecord(
              //     title2: name,
              //     age2: age,
              //     place2: place,
              //     box2: box,
              //     index2: ind,
              //   ),
              // );
            },
          ),
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.black,
            ),
            onPressed: ()  {
              // await box.deleteAt(ind);

              studentrecordcontrolleer.deletestudent(student!.key);
              Get.back();
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => HomePage(),
              //   ),
              // );
              Get.off(HomePage());
            },
          ),
        ],
        elevation: 0.0,
        leadingWidth: 75,
        toolbarHeight: 70,
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
           
            Get.back();

          },
        ),
      ),
      body: ListView(
        children: [
          showProfile(student!.pic),
          // Details("Name:  ",student.name),
          details(student!.title, "Name: "),
          // Details("Age :  ", age.toString()),
          // Details(
          //   "Place :  ",
          //   place,
          // )
          details(student!.age.toString(), "Age: "),
          details(student!.place,"Place: ")
        ],
      ),
    );
  }
}

class Details extends StatelessWidget {
  String name;
  String heading;
  Details(
    String this.heading,
    String this.name,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 10,
        left: 40,
        right: 40,
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 0.0,
          horizontal: 16.0,
        ),
        tileColor: Colors.white,
        title: Row(
          children: [
            Container(
              child: Text(heading),
            ),
            Container(
              child: Text(
                name,
                style: GoogleFonts.rubik(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 Widget details(String name, String heading)=>Container(
     padding: EdgeInsets.only(
        top: 10,
        left: 40,
        right: 40,
      ),
       child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 0.0,
          horizontal: 16.0,
        ),
        tileColor: Colors.white,
        title: Row(
          children: [
            Container(
              child: Text(heading),
            ),
            Container(
              child: Text(
                name,
                style: GoogleFonts.rubik(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
          ],
        ),
      ),

 );



Widget showProfile(dynamic pic) {
  if (pic != null) {
    Uint8List imageBytes = base64Decode(pic);
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: Image.memory(
        imageBytes,
        height: 200,
        width: 200,
        fit: BoxFit.cover,
      ),
    );
  }
  return Container(
    clipBehavior: Clip.hardEdge,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
    ),
    child: Image.asset(
      "assets/images/avv1.png",
      height: 200,
      width: 200,
    ),
  );
}
