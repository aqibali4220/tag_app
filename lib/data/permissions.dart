import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

import '../controllers/general_controller.dart';

int i = 1;
// var imagePath = "".obs;


getitFromGallery(BuildContext context, Permission platform) async {
  var stauts = await Permission.photos.status;
  await platform.request();
  Get.log("status  $stauts ");
  if (await platform.status.isDenied) {
    // Permission.systemAlertWindow.isPermanentlyDenied;
    if (Platform.isIOS) {
      await platform.request();
    } else {
      showDeleteDialog(context);
    }
  } else if (await platform.status.isPermanentlyDenied) {
    if (Platform.isIOS) {
      showDialog(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
            title: Text("Settings "),
            content: Text(
                "Farm sharing want to access camera open settings and give permission"),
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text("No"),
                onPressed: () => Navigator.pop(context),
              ),
              CupertinoDialogAction(
                onPressed: () => openAppSettings(),
                child: Text("open settings"),
              )
            ],
          ));
    } else {
      showDeleteDialog(context);
    }
    print("is permanant");
  } else if (await platform.isGranted) {
    print("is grandted");
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      print("Picked File: ${pickedFile.path}");
      var imagePath = pickedFile.path;
      // image = File(imagePath);
      // update();

      var imageName = imagePath.split("/").last;
      print("Image Name: $imageName");
      final dir1 = Directory.systemTemp;
      final targetPath1 = "${dir1.absolute.path}/dp$i.jpg";
      var compressedFile1 = await FlutterImageCompress.compressAndGetFile(
          imagePath, targetPath1,
          quality: 60);
      print("compressedFile File: ${compressedFile1!.path}");
      Get.find<GeneralController>().image = compressedFile1;
      //convert XFile to File
      Get.find<GeneralController>().imageFile = File(Get.find<GeneralController>().image!.path);
      imagePath = compressedFile1.path;
      i++;
      Get.find<GeneralController>().update();
    }
    Get.log("ggranted");
    return true;
  } else if (await platform.isLimited) {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      print("Picked File: ${pickedFile.path}");
      var imagePath = pickedFile.path;
      // image = File(imagePath);
      // update();

      var imageName = imagePath.split("/").last;
      print("Image Name: $imageName");
      final dir1 = Directory.systemTemp;
      final targetPath1 = "${dir1.absolute.path}/dp$i.jpg";
      var compressedFile1 = await FlutterImageCompress.compressAndGetFile(
          imagePath, targetPath1,
          quality: 60);
      print("compressedFile File: ${compressedFile1!.path}");
      Get.find<GeneralController>().image = compressedFile1;
      //convert XFile to File
      Get.find<GeneralController>().imageFile = File(Get.find<GeneralController>().image!.path);
      imagePath = compressedFile1.path;
      i++;
      Get.find<GeneralController>().update();
    }
    return true;

  }
}

/// Get from Camera
getitFromCamera(BuildContext context) async {
  //var status = await Permission.camera.status;
  var status = await Permission.camera.status; //
  await Permission.camera.request();
  if (await Permission.camera.status.isDenied) {
    if (Platform.isIOS) {
      await Permission.camera.request();
    } else {
      showDeleteDialog(context);
    }
  }
  if (await Permission.camera.status.isPermanentlyDenied) {
    if (Platform.isIOS) {
      showDialog(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
            title: Text("Settings"),
            content: Text(
                "Farm sharing want to access camera open settings and give permission"),
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text("Not now"),
                onPressed: () => Navigator.pop(context),
              ),
              CupertinoDialogAction(
                child: Text("Open settings"),
                onPressed: openAppSettings,
              )
            ],
          ));
    } else {
      showDeleteDialog(context);
    }
  } else if (await Permission.camera.isGranted ||
      await Permission.camera.isLimited) {
    print("is grandted");
    final pickedFile =await  ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      print("Picked File: ${pickedFile.path}");
      var imagePath = pickedFile.path;
      // image = File(imagePath);
      // update();

      var imageName = imagePath.split("/").last;
      print("Image Name: $imageName");
      final dir1 = Directory.systemTemp;
      final targetPath1 = dir1.absolute.path + "/dp${i}.jpg";
      var compressedFile1 = await FlutterImageCompress.compressAndGetFile(
          imagePath, targetPath1,
          quality: 60);
      print("compressedFile File: ${compressedFile1!.path}");
      Get.find<GeneralController>().image = compressedFile1;
      Get.find<GeneralController>().imageFile = File(Get.find<GeneralController>().image!.path);

      imagePath = compressedFile1.path;
      i++;
      Get.find<GeneralController>().update();
    }
    Get.log("ggranted");
    return true;
    // Either the permission was already granted before or the user just granted it.
  }
}

bottomSheet(BuildContext context,Permission platform) {
  Get.bottomSheet(Container(
    height: 170,
    color: Colors.white,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(
                Icons.photo_camera,
                size: 30,
              ),
              onPressed: () {
                Get.back();
                getitFromCamera(context);
              },
            ),
            Text("From Camera")
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(
                Icons.photo,
                size: 30,
              ),
              onPressed: () {
                Get.back();
                getitFromGallery(context, platform);
              },
            ),
            Text("From Gallery")
          ],
        ),
      ],
    ),
  ));
}

showDeleteDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = GestureDetector(
    onTap: () {
      Navigator.pop(context);
    },
    child: Text(
      "Not now",
      style: TextStyle(fontSize: 12),
    ),
  );
  Widget continueButton = GestureDetector(
    onTap: () async {
      openAppSettings();
    },
    child: Text("Open settings".tr,
        style: TextStyle(fontStyle: FontStyle.normal, fontSize: 12)),
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    actionsPadding: EdgeInsets.only(right: 15, bottom: 15),
    title: Text(
      "Settings".tr,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
    ),
    content: Text(
      "For the best experience, FarmSharing needs to use your current location to find closest farmer"
          .tr,
      style: TextStyle(fontWeight: FontWeight.w400),
    ),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      });
}
