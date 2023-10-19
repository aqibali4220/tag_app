import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tag_app/utils/colors.dart';
import 'package:tag_app/utils/size_config.dart';
import 'package:tag_app/utils/text_styles.dart';

import '../utils/images.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

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
          Padding(
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
          SizedBox(
            height: getHeight(30),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "chat1".tr.toString().toUpperCase(),
                style: kSize26W700ColorYellow,
              ),
              SizedBox(
                height: getHeight(20),
              ),
              Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: getHeight(500),
                  width: getWidth(300),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "chat2".tr,
                        style: kSize18W600ColorBlack,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: getHeight(20),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
