import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tag_app/controllers/home_controller.dart';
import 'package:tag_app/utils/permissions.dart';

import '../utils/const.dart';
import '../view/dashboard.dart';
import '../view/home_screen.dart';
import '../widgets/custom_toasts.dart';
import '../widgets/progress_bar.dart';
import 'general_controller.dart';

class AuthController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  signInFunc() {
    // Get.dialog(ProgressBar(), barrierDismissible: false);

    try {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((value) async {
        Get.find<GeneralController>().gunBox.put(cUserSession, true);
        await getCurrentLocation();

        await addUserData();
        Get.find<HomeController>().setTagPins();

        Get.to(() => HomeScreen());
        nameController.clear();
        emailController.clear();
        locationController.clear();
        phoneController.clear();
        passwordController.clear();
      },onError: (e){
        Get.back();
        print(e.toString());
        // CustomToast.failToast(msg: "sign8".tr);

        if (e.toString().contains("user-not-found")) {
          CustomToast.failToast(msg: "sign7".tr);
        } else if (e.toString().contains("wrong-password")) {
          CustomToast.failToast(msg: "sign8".tr);
        }else if (e.toString().contains("The email address is already in use by another account")) {
          CustomToast.failToast(msg: "Change email , user already exist".tr);
        }
      });
    } on FirebaseAuthException catch (e) {
      Get.back();
      if (e.code == 'user-not-found') {
        CustomToast.failToast(msg: "sign7".tr);
      } else if (e.code == 'wrong-password') {
        CustomToast.failToast(msg: "sign8".tr);
      }
    } catch (e) {
      Get.back();
      if (e.toString().contains("user-not-found")) {
        CustomToast.failToast(msg: "sign7".tr);
      } else if (e.toString().contains("wrong-password")) {
        CustomToast.failToast(msg: "sign8".tr);
      }
      print(e);
    }
  }

  Future addUserData() {
    return users.doc(FirebaseAuth.instance.currentUser!.uid).set({
      'user_name': nameController.text,
      'email': emailController.text,
      'location': locationController.text,
      'phone': phoneController.text,
    }).then((value) {
      ///optional
    }).catchError(
        (error) => CustomToast.failToast(msg: "Failed to add user: $error"));
  }

  loginUserFunc() {
    Get.dialog(ProgressBar(), barrierDismissible: false);

    try {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((value) async {
        await getCurrentLocation();
        Get.find<HomeController>().setTagPins();

        Get.find<GeneralController>().gunBox.put(cUserSession, true);
        Get.to(() => HomeScreen());
        emailController.clear();
        passwordController.clear();
      }, onError: (e) {
        Get.back();
        if (e.toString().contains("user-not-found")) {
          CustomToast.failToast(msg: "sign7".tr);
        }
        if (e.toString().contains("wrong-password")) {
          CustomToast.failToast(msg: "sign8".tr);
        }
        Get.log("aaaaaa $e");
      });
    } on FirebaseAuthException catch (e) {
      Get.log("eeeeeee $e");
      if (e.code == 'user-not-found') {
        CustomToast.failToast(msg: "sign7".tr);
      } else if (e.code == 'wrong-password') {
        CustomToast.failToast(msg: "sign8".tr);
      }
      Get.back();
    } catch (e) {
      Get.log(" wwwwww $e");
    }
  }

  checkSession() async {
    if (Get.find<GeneralController>()
            .gunBox
            .get(cUserSession, defaultValue: false) ==
        true) {
      await getCurrentLocation();
      // Get.find<GeneralController>().gunBox.put(cUserSession, false);

      Get.to(() => HomeScreen());
    } else {
      Get.offAll(() => DashboardScreen());
    }
  }
}
