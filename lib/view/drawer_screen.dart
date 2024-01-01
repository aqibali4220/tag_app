import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:tag_app/utils/chat_module/Screens/HomeScreen.dart';
import 'package:tag_app/utils/colors.dart';
import 'package:tag_app/utils/images.dart';
import 'package:tag_app/utils/size_config.dart';
import 'package:tag_app/utils/suncfusion_map.dart';
import 'package:tag_app/view/get_pins_screen.dart';
import 'package:tag_app/view/login_screen.dart';

import '../controllers/general_controller.dart';
import '../utils/chat_module_by_aqib/view/chat_screen.dart';
import '../utils/const.dart';
import '../utils/text_styles.dart';
import '../widgets/custom_button.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: getHeight(50),
          ),
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Padding(
              padding: EdgeInsets.only(left: getWidth(20)),
              child: Align(
                alignment: Alignment.topLeft,
                child: Icon(
                  Icons.cancel,
                  size: getHeight(35),
                  color: white,
                ),
              ),
            ),
          ),
          SizedBox(
            height: getHeight(50),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "drawer4".tr.toString().toUpperCase(),
                style: kSize26W700ColorYellow,
              ),
              SizedBox(
                height: getHeight(20),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => GetPinsMap());
                },
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: getHeight(70),
                    width: getWidth(300),
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          map_pin,
                          height: getHeight(24),
                          width: getWidth(24),
                          color: lightBlueAccent,
                        ),
                        SizedBox(
                          width: getWidth(12),
                        ),
                        Text(
                          "drawer1".tr.toString().toUpperCase(),
                          style: kSize18W700ColorLightBlueAccent,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: getHeight(20),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => GetPinsMap());

                },
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: getHeight(70),
                    width: getWidth(300),
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          map_pin,
                          height: getHeight(24),
                          width: getWidth(24),
                          color: lightBlueAccent,
                        ),
                        SizedBox(
                          width: getWidth(12),
                        ),
                        Text(
                          "drawer2".tr.toString().toUpperCase(),
                          style: kSize18W700ColorLightBlueAccent,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: getHeight(20),
              ),
              // Material(
              //   elevation: 5,
              //   borderRadius: BorderRadius.circular(10),
              //   child: Container(
              //     height: getHeight(70),
              //     width: getWidth(300),
              //     decoration: BoxDecoration(
              //       color: white,
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         const Icon(
              //           Icons.info_rounded,
              //           color: yellow,
              //         ),
              //         SizedBox(
              //           width: getWidth(32),
              //         ),
              //         Text(
              //           "drawer3".tr.toString().toUpperCase(),
              //           style: kSize18W700ColorLightBlueAccent,
              //         )
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
          Spacer(),
          ListTile(
            title: InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        child: Container(
                            height: getHeight(225),
                            width: getWidth(374),
                            // padding: EdgeInsets.only(left: getWidth(12)),
                            decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: getHeight(20),
                                ),
                                Text(
                                  "Delete Account".tr,
                                  style: kSize24W500ColorWhite.copyWith(
                                      color: black),
                                ),
                                SizedBox(
                                  height: getHeight(20),
                                ),
                                Text(
                                  "Are you sure you want to delete account?".tr,
                                  style: kSize16W400ColorBlack,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: getHeight(36),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CustomButton(
                                      width: getWidth(145),
                                      text: "Cancel".tr,
                                      onPressed: () {
                                        Get.back();
                                      },
                                      textColor: red,
                                      color: white,
                                      borderColor: red,
                                    ),
                                    CustomButton(
                                      color: red,
                                      width: getWidth(145),
                                      text: "Delete".tr,
                                      onPressed: () {
                                        // Get the current user.
                                        User? user =
                                            FirebaseAuth.instance.currentUser;

                                        // Check if the user is signed in.
                                        if (user != null) {
                                          // Delete the user's account.
                                          user.delete().then((_) {
                                            Get.offAll(() => LoginScreen());
                                            print('Account deleted');
                                          }).catchError((error) {
                                            print(
                                                'Error deleting account: $error');
                                          });
                                        } else {
                                          print('User is not signed in');
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: getHeight(32),
                                ),
                              ],
                            )),
                      );
                    });
              },
              child: const Text(
                'Delete Account',
              ),
            ),
            trailing: const Icon(
              Icons.logout,
              color: Color(0xFF303030),
              size: 20,
            ),
            tileColor: const Color(0xFFF5F5F5),
            dense: false,
          ),
          SizedBox(
            height: getHeight(20),
          ),
          ListTile(
            title: InkWell(
              onTap: () {
                // Get.back();

                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        child: Container(
                            height: getHeight(225),
                            width: getWidth(374),
                            // padding: EdgeInsets.only(left: getWidth(12)),
                            decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: getHeight(20),
                                ),
                                Text(
                                  "Logout Account".tr,
                                  style: kSize24W500ColorWhite.copyWith(
                                      color: black),
                                ),
                                SizedBox(
                                  height: getHeight(20),
                                ),
                                Text(
                                  "Are you sure you want to logout?".tr,
                                  style: kSize16W400ColorBlack,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: getHeight(36),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CustomButton(
                                      width: getWidth(145),
                                      text: "Cancel".tr,
                                      onPressed: () {
                                        Get.back();
                                      },
                                      textColor: red,
                                      color: white,
                                      borderColor: red,
                                    ),
                                    CustomButton(
                                      width: getWidth(145),
                                      color: red,
                                      text: "Logout".tr,
                                      onPressed: () {
                                        FirebaseAuth.instance.signOut();
                                        Get.find<GeneralController>()
                                            .gunBox
                                            .put(cUserSession, false);

                                        Get.offAll(
                                          () => LoginScreen(),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: getHeight(32),
                                ),
                              ],
                            )),
                      );
                    });
              },
              child: const Text(
                'Logout',
              ),
            ),
            trailing: const Icon(
              Icons.logout,
              color: Color(0xFF303030),
              size: 20,
            ),
            tileColor: const Color(0xFFF5F5F5),
            dense: false,
          ),
          SizedBox(
            height: getHeight(60),
          ),
        ],
      ),
    );
  }
}
