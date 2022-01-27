import 'dart:convert';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_records/pages/record_adapter.dart';
import 'package:student_records/pages/student_detials.dart';
class studentrecordcontrollee extends GetxController{

  Box<Record> box =Hive.box('records');
  Uint8List ? imagebyte;
  

  addStudent(String title, int age, String place, pic) {
    box.add(
     Record(title, age, place, pic)
    );
    update();
  }

  deletestudent(int key){
    box.deleteAt(key);
    update();
  }
 dynamic  pickImage(ImageSource source) async {
   dynamic pic;
    final image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      Uint8List imageBytes = await image.readAsBytes();
      pic = base64Encode(imageBytes);
    }
    
  
}
}
class StudentBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(studentrecordcontrollee());
  }
}