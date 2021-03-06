import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_records/controller/studenrecordcontroller.dart';
import 'package:student_records/pages/record_adapter.dart';
import 'package:student_records/pages/student_detials.dart';

class StudentSearch extends StatefulWidget {
  @override
  State<StudentSearch> createState() => _StudentSearchState();
}

class _StudentSearchState extends State<StudentSearch> {
  String _searchText = "";
  dynamic ind;
  late Uint8List imageBytes;

  final studentcontrol=Get.find<studentrecordcontrollee>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(7),
          child: TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Search ",
                suffixIcon:Icon(Icons.search)
            ),
            onChanged: (value) {
              setState(
                () {
                  _searchText = value;
                },
              );
            },
          ),
        ),
        Container(
          child: ValueListenableBuilder(
            valueListenable: Hive.box<Record>('records').listenable(),
            builder: (context, Box<Record> box, _) {
              var results = _searchText.isEmpty
                  ? box.values.toList()
                  : box.values
                      .where(
                        (c) => c.title
                            .toLowerCase()
                            .contains(_searchText.toLowerCase()),
                      )
                      .toList();

              return results.isEmpty
                  ? Center(
                      child: Text(
                        'No results found !',
                        style: TextStyle(fontSize: 15),
                      ),
                    )
                  : Container(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: results.length,
                        itemBuilder: (context, index) {
                          var getIndex = box.values.toList();
                          var get = box.values
                              .where(
                                (c) => c.title.contains(results[index].title),
                              )
                              .toList();

                          final ind = getIndex.indexOf(get.first);
                          final records=studentcontrol.box.getAt(index);
                          if (results[index].pic != null) {
                            imageBytes = base64Decode(results[index].pic);

                            return Container(
                              padding: EdgeInsets.all(6),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 7.0,
                                  horizontal: 16.0,
                                ),
                                leading: Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.memory(
                                    imageBytes,
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                tileColor: Colors.white,
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => StudentDetails(
                                  //         // results[index].title,
                                  //         // results[index].age,
                                  //         // results[index].place,
                                  //         // results[index].pic,
                                  //         // ind,
                                  //         // box
                                  //         student:records
                                          
                                  //         ),
                                  //   ),
                                  // );
                                  Get.to(
                                    ()=>StudentDetails(student:records)


                                  );
                                },
                                title: Text(
                                  results[index].title,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ),
                            );
                          }
                          return Container(
                            padding: EdgeInsets.all(6),
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 7.0,
                                horizontal: 16.0,
                              ),
                              leading: CircleAvatar(
                                backgroundImage: AssetImage(
                                  "assets/images/avv1.png",
                                ),
                                radius: 25,
                              ),
                              tileColor: Colors.white,
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => StudentDetails(
                                //       results[index].title,
                                //       results[index].age,
                                //       results[index].place,
                                //       results[index].pic,
                                //       ind,
                                //       box,
                                //     ),
                                //   ),
                                // );
                                 Get.to(
                                    ()=>StudentDetails(student:records)


                                  );
                              },
                              title: Text(
                                results[index].title,
                                style: GoogleFonts.montserrat(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
            },
          ),
        )
      ],
    );
  }
}
// class StudentSearch extends StatelessWidget {
//    StudentSearch({ Key? key }) : super(key: key);
//    String _searchText = "";

//   @override
//   Widget build(BuildContext context) {
//     final studentrecordcontrolleer=Get.find<studentrecordcontrollee>();
//     final studentrecordcontroller=Get.put(studentrecordcontrollee);

//     return Column(children: [
//        Container(
//           padding: EdgeInsets.all(7),
//           child: TextFormField(
//             decoration: InputDecoration(
//               border: OutlineInputBorder(),
//               hintText: "Search ",
//                 suffixIcon:Icon(Icons.search)
//             ),
//             onChanged: (value) {
//               // setState(
//               //   () {
//                   _searchText = value;
//                   studentrecordcontrolleer.update();
//               //   },
//               // );
//             },
//           ),
//         ),
//         Container(
//           child: ValueListenableBuilder(
//             valueListenable: Hive.box<Record>('records').listenable(),
//             builder: (context, Box<Record> box, _) {
//               var results = _searchText.isEmpty
//                   ? box.values.toList()
//                   : box.values
//                       .where(
//                         (c) => c.title
//                             .toLowerCase()
//                             .contains(_searchText.toLowerCase()),
//                       )
//                       .toList();

//               return results.isEmpty
//                   ? Center(
//                       child: Text(
//                         'No results found !',
//                         style: TextStyle(fontSize: 15),
//                       ),
//                     )
//                   : Container(
//                       height: MediaQuery.of(context).size.height,
//                       child: ListView.builder(
//                         scrollDirection: Axis.vertical,
//                         itemCount: results.length,
//                         itemBuilder: (context, index) {
//                           var getIndex = box.values.toList();
//                           var get = box.values
//                               .where(
//                                 (c) => c.title.contains(results[index].title),
//                               )
//                               .toList();

//                           final ind = getIndex.indexOf(get.first);
//                           if (results[index].pic != null) {
//                             // imageBytes = base64Decode(results[index].pic);

//                             return Container(
//                               padding: EdgeInsets.all(6),
//                               child: ListTile(
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.all(
//                                     Radius.circular(10),
//                                   ),
//                                 ),
//                                 contentPadding: EdgeInsets.symmetric(
//                                   vertical: 7.0,
//                                   horizontal: 16.0,
//                                 ),
//                                 leading: Container(
//                                   clipBehavior: Clip.hardEdge,
//                                   decoration: BoxDecoration(
//                                     shape: BoxShape.circle,
//                                   ),
//                                   // child: Image.memory(
//                                   //   imageBytes,
//                                   //   height: 50,
//                                   //   width: 50,
//                                   //   fit: BoxFit.cover,
//                                   // ),
//                                 ),
//                                 tileColor: Colors.white,
//                                 onTap: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => StudentDetails(
//                                           results[index].title,
//                                           results[index].age,
//                                           results[index].place,
//                                           results[index].pic,
//                                           ind,
//                                           box),
//                                     ),
//                                   );
//                                 },
//                                 title: Text(
//                                   results[index].title,
//                                   style: GoogleFonts.montserrat(
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w500,
//                                     fontStyle: FontStyle.normal,
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }
//                           return Container(
//                             padding: EdgeInsets.all(6),
//                             child: ListTile(
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.all(
//                                   Radius.circular(10),
//                                 ),
//                               ),
//                               contentPadding: EdgeInsets.symmetric(
//                                 vertical: 7.0,
//                                 horizontal: 16.0,
//                               ),
//                               leading: CircleAvatar(
//                                 backgroundImage: AssetImage(
//                                   "assets/images/avv1.png",
//                                 ),
//                                 radius: 25,
//                               ),
//                               tileColor: Colors.white,
//                               onTap: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => StudentDetails(
//                                       results[index].title,
//                                       results[index].age,
//                                       results[index].place,
//                                       results[index].pic,
//                                       ind,
//                                       box,
//                                     ),
//                                   ),
//                                 );
//                               },
//                               title: Text(
//                                 results[index].title,
//                                 style: GoogleFonts.montserrat(
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w500,
//                                   fontStyle: FontStyle.normal,
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     );
//             },
//           ),
//         )
        

//     ],

      
//     );
//   }
// }