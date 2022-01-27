import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_records/controller/studenrecordcontroller.dart';
import 'package:student_records/pages/add_record.dart';
import 'package:student_records/pages/student_search.dart';
import 'package:student_records/pages/record_adapter.dart';

class HomePage extends StatelessWidget {
  var names;
  late Uint8List imageBytes;

  @override
  Widget build(BuildContext context) {
    final studentcolloer=Get.put(studentrecordcontrollee());
    final studentcontroler=Get.find<studentrecordcontrollee>();
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended( 
          onPressed:()=> showDialog(
            context: context,
            builder: (context) => Addrecord(),
          ), 
          label: Text("add students"),
          icon: Icon(Icons.add),
          
          backgroundColor: Colors.teal,
       
        ),
        backgroundColor: Colors.grey[200],
      
       
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text("Student Records"),
          centerTitle: true,
          // actions: [
          //   IconButton(onPressed: ()=>StudentSearch()

          //   , icon: Icon(Icons.search,color: Colors.white,))
          // ],
        ),
        
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
          
            Container(
              padding: EdgeInsets.all(
                20,
              ),
              child: ValueListenableBuilder(
                valueListenable: Hive.box<Record>('records').listenable(),
                builder: (context, Box<Record> box, _) {
                  // if (box.values.isEmpty) {
                  //   return Center(
                  //     child: Text(
                  //       "No records !",
                  //       textAlign: TextAlign.center,
                  //       style: TextStyle(
                  //         // fontFamily: 'Montserrat',
                  //         fontSize: 17,
                  //         fontWeight: FontWeight.w400,
                  //       ),
                  //     ),
                  //   );
                  // }
                  return Column(
                    children: [
                      StudentSearch(),
                    ],
                  );
                
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
