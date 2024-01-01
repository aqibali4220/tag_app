import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tag_app/controllers/general_controller.dart';
import 'package:tag_app/utils/singleton.dart';

import '../utils/const.dart';
import '../widgets/custom_toasts.dart';

class HomeController extends GetxController {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  // TextEditingController controller5 = TextEditingController();

  CollectionReference taglist = FirebaseFirestore.instance.collection('tag_pins');

  RxInt radioValue = 0.obs;

  void setGunPin() {
    String randomString = generateRandomString(8);

    final data = {
      "chatRoomId":randomString,
      "user_name": Get.find<GeneralController>().gunBox.get(cUserName),
      "where are you": controller1.text,
      "describe the person": controller2.text,
      "describe the situation": controller3.text,
      "do you feel safe": controller4.text,
      "shooter_pic": "",
      "current_lat": SingleToneValue.instance.currentLat,
      "current_lng": SingleToneValue.instance.currentLng,
      "dv_token":
          Get.find<GeneralController>().gunBox.get(cDvToken, defaultValue: ""),
      'userId': FirebaseAuth
          .instance.currentUser!.uid, // Replace with the actual user's ID
      'timestamp': DateTime.now(),
    };

    // Check if Firebase data is empty, and initialize with a default list if necessary.
    setFireStoreData(data);
  }

  void setGunPinWithPic() async {
    final downloadUrl = await uploadImageToFirebaseStorage(
        Get.find<GeneralController>().imageFile!);
    String randomString = generateRandomString(8);

    if (downloadUrl != null) {
      final data = {
        "chatRoomId":randomString,
        "user_name": Get.find<GeneralController>().gunBox.get(cUserName),
        // "user_email": Get.find<GeneralController>().gunBox.get(cUserEmail),
        "where are you": controller1.text,
        "describe the person": controller2.text,
        "describe the situation": controller3.text,
        "do you feel safe": controller4.text,
        "current_lat": SingleToneValue.instance.currentLat,
        "current_lng": SingleToneValue.instance.currentLng,
        "shooter_pic": downloadUrl,
        "dv_token": Get.find<GeneralController>().gunBox.get(cDvToken),
        'userId': FirebaseAuth
            .instance.currentUser!.uid, // Replace with the actual user's ID
        'timestamp': DateTime.now(),
      };

      // Check if Firebase data is empty, and initialize with a default list if necessary.
      setFireStoreData(data);
    } else {
      // Handle the case where the image upload fails.
      // You can log an error or show an error message to the user.
    }
  }

  Future<void> setFireStoreData(Map<String, dynamic> data) async {
    try {
      await taglist.add(data);
      Get.back();
      cleanControllers();
      CustomToast.successToast(msg: "Pin Successfully Placed");
    } catch (error) {
      // Handle errors gracefully, e.g., throw custom exceptions or show specific error messages.
      Get.log("Failed to update data: $error");
      CustomToast.failToast(msg: "Failed to update data: $error");
    }
  }

  Future<String?> uploadImageToFirebaseStorage(File imageFile) async {
    try {

      final imgName = imageFile.path.split("/").last;
      final ref = FirebaseStorage.instance.ref('images/$imgName');
      Get.log("ref img$ref");
      final task = ref.putFile(imageFile);
      await task.whenComplete(() {});
      return await task.snapshot.ref.getDownloadURL();
    } catch (error) {
      // Handle errors gracefully, e.g., throw custom exceptions or show specific error messages.
      Get.log("Failed to upload image: $error");
      CustomToast.failToast(msg: "Failed to upload image: $error");
      return null;
    }
  }

  cleanControllers() {
    controller1.clear();
    controller2.clear();
    controller3.clear();
    controller4.clear();
    Get.find<GeneralController>().imageFile = null;
    Get.find<GeneralController>().image = null;
    Get.find<GeneralController>().update();
  }


  String generateRandomString(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    return List.generate(length, (index) => chars[random.nextInt(chars.length)]).join();
  }

}
