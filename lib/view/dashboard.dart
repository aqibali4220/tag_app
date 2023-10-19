import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tag_app/utils/size_config.dart';
import 'package:tag_app/utils/text_styles.dart';
import 'package:tag_app/view/signin_screen.dart';

import '../utils/colors.dart';
import 'login_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: primaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: getHeight(200),
            ),
            Center(
                child: Text(
              "mission1".tr,
              style: kSize26W700ColorYellow,
            )),
            SizedBox(
              height: getHeight(50),
            ),
            Text(
              "mission2".tr,
              style: kSize22ColorWhite.copyWith(height: 1.5),
              textAlign: TextAlign.center,

            ),
            SizedBox(
              height: getHeight(12),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    Get.to(()=>LoginScreen());
                  },
                  child: Text(
                    "mission4".tr,
                    style: kSize24W700ColorYellow.copyWith(
                        decorationColor: yellow,
                        decoration: TextDecoration.underline,
                        ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Get.to(()=>SignInScreen());
                  },
                  child: Text(
                    "mission3".tr,
                    style: kSize24W700ColorYellow.copyWith(
                        decorationColor: yellow,
                        decoration: TextDecoration.underline,
                        ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: getHeight(50),
            ),
          ],
        ),
      ),
    );
  }
}
