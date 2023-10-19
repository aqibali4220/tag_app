import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tag_app/controllers/general_controller.dart';
import 'package:tag_app/utils/singleton.dart';

import '../widgets/custom_toasts.dart';

class HomeController extends GetxController {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  // TextEditingController controller5 = TextEditingController();

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  RxInt radioValue = 0.obs;

  setGunPin() async {
    DocumentReference docRef =
        users.doc(FirebaseAuth.instance.currentUser!.uid);

    final docSnapshot = await docRef.get();
    // if (docSnapshot.exists) {
    // await deleteGunPostDataInFirebase();
    docRef
        .collection("tag_pins")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      "gun_pin_list": FieldValue.arrayUnion([
        {
          "where are you": controller1.text,
          "describe the person": controller2.text,
          "describe the situation": controller3.text,
          "do you feel safe": controller4.text,
          "shooter_pic": "",
          "current_lat": SingleToneValue.instance.currentLat,
          "current_lng": SingleToneValue.instance.currentLng,
        }
      ]),
    }).whenComplete(() {
      cleanControllers();
      Get.back();
    }).catchError((error) {
      // Get.back();
      Get.log("Failed to add data: $error");

      CustomToast.failToast(msg: "Failed to add data: $error");
    });
    // }
  }

  setGunPinWithPic() async {
    int i = 0;
    // Create a reference to the file you want to upload.
    // final file = File('path/to/file');
    String imgName = Get.find<GeneralController>().image!.path.split("/").last;

    final ref = FirebaseStorage.instance.ref('images/$imgName');

    // Create a `UploadTask` object and start the upload.
    final task = ref.putFile(Get.find<GeneralController>().imageFile!);
    // Get the download URL of the uploaded file.

    // Wait for the upload to complete.
    task.whenComplete(() async {
      final downloadUrl = await task.snapshot.ref.getDownloadURL();

      Get.log("img  url ${downloadUrl.toString()}");
      DocumentReference docRef =
          users.doc(FirebaseAuth.instance.currentUser!.uid);

      // await deleteGunPostDataInFirebase();
      docRef
          .collection("tag_pins")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        "gun_pin_list": FieldValue.arrayUnion([
          {
            "where are you": controller1.text,
            "describe the person": controller2.text,
            "describe the situation": controller3.text,
            "do you feel safe": controller4.text,
            "current_lat": SingleToneValue.instance.currentLat,
            "current_lng": SingleToneValue.instance.currentLng,
            "shooter_pic": downloadUrl.toString(),
          }
        ]),
      }).whenComplete(() {
        i++;
        cleanControllers();
        Get.find<GeneralController>().imageFile = null;
        Get.find<GeneralController>().image = null;
        Get.back();
      }).catchError((error) {
        // Get.back();
        Get.log("Failed to add data: $error");

        CustomToast.failToast(msg: "Failed to add data: $error");
      });
    });
  }

  deleteGunPostDataInFirebase() async {
    CollectionReference collectionRef = users
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("tag_pins");

    QuerySnapshot querySnapshot = await collectionRef.get();
    List<DocumentSnapshot> documents = querySnapshot.docs;

    for (DocumentSnapshot document in documents) {
      await document.reference.delete();
    }
  }

  cleanControllers() {
    controller1.clear();
    controller2.clear();
    controller3.clear();
    controller4.clear();
  }

  setTagPins() {
    DocumentReference docRef =
        users.doc(FirebaseAuth.instance.currentUser!.uid);
    docRef
        .collection("tag_pins")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      "gun_pin_list": FieldValue.arrayUnion([
        {
          "where are you": "",
          "describe the person": "",
          "describe the situation": "",
          "do you feel safe": "",
          "shooter_pic": "",
          "current_lat": "",
          "current_lng": "",
        }
      ])
    }, SetOptions(merge: true)).whenComplete(() {

    }).catchError((error) {
      // Get.back();
      Get.log("Failed to add data: $error");

      CustomToast.failToast(msg: "Failed to add data: $error");
    });
  }
}
