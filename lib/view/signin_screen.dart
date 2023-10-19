import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tag_app/utils/colors.dart';
import 'package:tag_app/utils/images.dart';
import 'package:tag_app/view/dashboard.dart';
import 'package:tag_app/view/home_screen.dart';

import '../controllers/auth_controller.dart';
import '../utils/size_config.dart';
import '../utils/text_styles.dart';
import '../widgets/custom_password_textfeild.dart';
import '../widgets/custom_textfield.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  AuthController authController = Get.find();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: primaryColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: getHeight(200),
                ),
                Text(
                  "sign1".tr.toString().toUpperCase(),
                  style: kSize18W700ColorWhite,
                ),
                SizedBox(
                  height: getHeight(12),
                ),
                GetBuilder<AuthController>(builder: (context) {
                  return CustomTextField(
                    backgroundColor: white,
                    height: getHeight(48),
                    text: "Enter username",
                    length: 30,
                    controller: authController.nameController,
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode:
                        authController.nameController.text.isNotEmpty
                            ? AutovalidateMode.onUserInteraction
                            : AutovalidateMode.disabled,
                    onChanged: (value) {
                      authController.update();
                    },
                    inputFormatters:
                        FilteringTextInputFormatter.singleLineFormatter,
                    // FilteringTextInputFormatter.deny(RegExp('[ ]')),
                  );
                }),
                SizedBox(
                  height: getHeight(12),
                ),
                Text(
                  "sign2".tr.toString().toUpperCase(),
                  style: kSize18W700ColorWhite,
                ),
                SizedBox(
                  height: getHeight(12),
                ),
                GetBuilder<AuthController>(builder: (context) {
                  return CustomTextField(
                    backgroundColor: white,
                    height: getHeight(48),
                    text: "Enter email",
                    length: 30,
                    controller: authController.emailController,
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode:
                        authController.emailController.text.isNotEmpty
                            ? AutovalidateMode.onUserInteraction
                            : AutovalidateMode.disabled,
                    onChanged: (value) {
                      authController.update();
                    },
                    inputFormatters:
                        FilteringTextInputFormatter.deny(RegExp('[ ]')),
                  );
                }),
                SizedBox(
                  height: getHeight(12),
                ),
                Row(
                  children: [
                    Text(
                      "sign3".tr.toString().toUpperCase(),
                      style: kSize18W700ColorWhite,
                    ),
                    SizedBox(
                      width: getWidth(5),
                    ),
                    Image.asset(
                      map_pin,
                      height: getHeight(24),
                      width: getWidth(24),
                      color: white,
                    )
                  ],
                ),
                SizedBox(
                  height: getHeight(12),
                ),
                GetBuilder<AuthController>(builder: (context) {
                  return CustomTextField(
                    backgroundColor: white,
                    height: getHeight(48),
                    text: "Enter location",
                    length: 30,
                    controller: authController.locationController,
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode:
                        authController.locationController.text.isNotEmpty
                            ? AutovalidateMode.onUserInteraction
                            : AutovalidateMode.disabled,
                    onChanged: (value) {
                      authController.update();
                    },
                    inputFormatters:
                        FilteringTextInputFormatter.singleLineFormatter,
                  );
                }),
                SizedBox(
                  height: getHeight(12),
                ),
                Text(
                  "sign4".tr.toString().toUpperCase(),
                  style: kSize18W700ColorWhite,
                ),
                SizedBox(
                  height: getHeight(12),
                ),
                GetBuilder<AuthController>(builder: (context) {
                  return CustomTextField(
                    backgroundColor: white,
                    height: getHeight(48),
                    text: "Enter phone",
                    length: 30,
                    controller: authController.phoneController,
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode:
                        authController.phoneController.text.isNotEmpty
                            ? AutovalidateMode.onUserInteraction
                            : AutovalidateMode.disabled,
                    onChanged: (value) {
                      authController.update();
                    },
                    inputFormatters:
                        FilteringTextInputFormatter.deny(RegExp('[ ]')),
                  );
                }),
                SizedBox(
                  height: getHeight(12),
                ),
                Text(
                  "sign6".tr.toString().toUpperCase(),
                  style: kSize18W700ColorWhite,
                ),
                SizedBox(
                  height: getHeight(12),
                ),
                GetBuilder<AuthController>(builder: (context) {
                  return CustomPasswordTextField(
                    backgroundColor: white,
                    height: getHeight(48),
                    text: "********",
                    obscureText: true,
                    sufficon: 1,
                    length: 30,
                    controller: authController.passwordController,
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode:
                        authController.passwordController.text.isNotEmpty
                            ? AutovalidateMode.onUserInteraction
                            : AutovalidateMode.disabled,
                    onChanged: (value) {
                      authController.update();
                    },
                    inputFormatters:
                        FilteringTextInputFormatter.deny(RegExp('[ ]')),
                  );
                }),
                SizedBox(
                  height: getHeight(50),
                ),
                GestureDetector(
                  onTap: () {
                    authController.signInFunc();
                  },
                  child: Center(
                    child: Text("sign5".tr.toString().toUpperCase(),
                        style: kSize28W700ColorWhite),
                  ),
                ),
                SizedBox(
                  height: getHeight(12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
