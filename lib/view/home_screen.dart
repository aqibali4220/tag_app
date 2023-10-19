import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tag_app/controllers/general_controller.dart';
import 'package:tag_app/controllers/home_controller.dart';
import 'package:tag_app/utils/colors.dart';
import 'package:tag_app/utils/size_config.dart';
import 'package:tag_app/view/drawer_screen.dart';
import 'package:tag_app/widgets/progress_bar.dart';

import '../utils/images.dart';
import '../utils/text_styles.dart';
import '../widgets/custom_textfield.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  HomeController homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    int selectedRadio = 0;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: primaryColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                SizedBox(
                  height: getHeight(50),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const DrawerScreen());
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: getWidth(20)),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Image.asset(
                        drawer_icon,
                        height: getHeight(50),
                        width: getWidth(50),
                        color: white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: getHeight(30),
                ),
                Center(
                    child: Text(
                  "home1".tr.toString().toUpperCase(),
                  style: kSize26W700ColorYellow,
                )),
                SizedBox(
                  height: getHeight(30),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: getWidth(10), vertical: getHeight(20)),
                  // height: getHeight(350),
                  width: getWidth(374),
                  decoration: BoxDecoration(
                      color: white, borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "home2".tr,
                        style: kSize16W500ColorBlack,
                      ),
                      GetBuilder<HomeController>(builder: (context) {
                        return CustomTextField(
                          backgroundColor: white,
                          height: getHeight(48),
                          text: "Enter your area",
                          length: 100,
                          controller: homeController.controller1,
                          keyboardType: TextInputType.emailAddress,
                          autovalidateMode:
                              homeController.controller1.text.isNotEmpty
                                  ? AutovalidateMode.onUserInteraction
                                  : AutovalidateMode.disabled,
                          onChanged: (value) {
                            homeController.update();
                          },
                          inputFormatters:
                              FilteringTextInputFormatter.singleLineFormatter,
                        );
                      }),
                      SizedBox(
                        height: getHeight(15),
                      ),
                      Text(
                        "home3".tr,
                        style: kSize16W500ColorBlack,
                      ),
                      GetBuilder<HomeController>(builder: (context) {
                        return CustomTextField(
                          backgroundColor: white,
                          height: getHeight(48),
                          text: "Enter your area",
                          length: 500,
                          // maxlines: 4,
                          controller: homeController.controller2,
                          keyboardType: TextInputType.emailAddress,
                          autovalidateMode:
                              homeController.controller2.text.isNotEmpty
                                  ? AutovalidateMode.onUserInteraction
                                  : AutovalidateMode.disabled,
                          onChanged: (value) {
                            homeController.update();
                          },
                          inputFormatters:
                              FilteringTextInputFormatter.singleLineFormatter,
                        );
                      }),
                      SizedBox(
                        height: getHeight(15),
                      ),
                      Text(
                        "home5".tr,
                        style: kSize16W500ColorBlack,
                      ),
                      GetBuilder<HomeController>(builder: (context) {
                        return CustomTextField(
                          backgroundColor: white,
                          height: getHeight(48),
                          width: getWidth(Get.width),
                          text: "Describe",
                          length: 500,
                          controller: homeController.controller3,
                          keyboardType: TextInputType.emailAddress,
                          autovalidateMode:
                              homeController.controller3.text.isNotEmpty
                                  ? AutovalidateMode.onUserInteraction
                                  : AutovalidateMode.disabled,
                          onChanged: (value) {
                            homeController.update();
                          },
                          inputFormatters:
                              FilteringTextInputFormatter.singleLineFormatter,
                        );
                      }),
                      SizedBox(
                        height: getHeight(15),
                      ),
                      Text(
                        "home6".tr,
                        style: kSize16W500ColorBlack,
                      ),
                      GetBuilder<HomeController>(builder: (context) {
                        return CustomTextField(
                          backgroundColor: white,
                          height: getHeight(48),
                          text: "Feelings",
                          length: 100,
                          controller: homeController.controller4,
                          keyboardType: TextInputType.emailAddress,
                          autovalidateMode:
                              homeController.controller4.text.isNotEmpty
                                  ? AutovalidateMode.onUserInteraction
                                  : AutovalidateMode.disabled,
                          onChanged: (value) {
                            homeController.update();
                          },
                          inputFormatters:
                              FilteringTextInputFormatter.singleLineFormatter,
                        );
                      }),
                      SizedBox(
                        height: getHeight(15),
                      ),
                      Text(
                        "home4".tr,
                        style: kSize16W500ColorBlack,
                      ),
                      SizedBox(
                        height: getHeight(8),
                      ),
                      GetBuilder<GeneralController>(builder: (context) {
                        return StatefulBuilder(
                          builder:
                              (BuildContext context, StateSetter setState) {
                            return Get.find<GeneralController>().image == null
                                ? Row(
                                    children: [
                                      SizedBox(
                                        width: getWidth(150),
                                        child: RadioListTile(
                                          value: 0,
                                          groupValue: selectedRadio,
                                          title: const Text("No"),
                                          onChanged: (int? value) {
                                            setState(() {
                                              selectedRadio = value!;
                                            });
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: getWidth(150),
                                        child: RadioListTile(
                                          value: 1,
                                          groupValue: selectedRadio,
                                          title: const Text("Yes"),
                                          onChanged: (int? value) {
                                            setState(() {
                                              selectedRadio = value!;
                                              Get.find<GeneralController>()
                                                  .bottomSheet(context);
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                : Image.file(
                                    Get.find<GeneralController>().imageFile!,
                                    height: getHeight(100),
                                    width: getWidth(100),
                                    frameBuilder: (BuildContext context,
                                        Widget child,
                                        int? frame,
                                        bool? wasSynchronouslyLoaded) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: child,
                                      );
                                    },
                                    errorBuilder: (context, e, stackTrace) =>
                                        Image.asset(error_image),
                                  );
                            // : FadeInImage.assetNetwork(
                            //     height: getHeight(100),
                            //     width: getWidth(100),
                            //
                            //     placeholder: loading_pic,
                            //     image:
                            //         "${Get.find<GeneralController>().image}",
                            //     fit: BoxFit.cover,
                            //     imageErrorBuilder: (context, e, stackTrace) =>
                            //         Image.asset(error_image),
                            //   );
                          },
                        );
                      }),
                      SizedBox(
                        height: getHeight(15),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: getHeight(40),
                ),
                GestureDetector(
                  onTap: () {
                    Get.dialog(ProgressBar(), barrierDismissible: false);

                    selectedRadio == 0 &&
                            Get.find<GeneralController>().imageFile == null
                        ? homeController.setGunPin()
                        : homeController.setGunPinWithPic();
                  },
                  child: Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      height: getHeight(70),
                      width: getWidth(374),
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: Text(
                          "home7".tr,
                          style: kSize32W700ColorBlack,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: getHeight(50),
                ),
                Text(
                  "home8".tr,
                  style: kSize16ColorWhite,
                ),
                SizedBox(
                  height: getHeight(20),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
