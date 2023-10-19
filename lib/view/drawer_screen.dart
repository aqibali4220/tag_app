import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tag_app/utils/colors.dart';
import 'package:tag_app/utils/images.dart';
import 'package:tag_app/utils/size_config.dart';
import 'package:tag_app/utils/suncfusion_map.dart';

import '../utils/text_styles.dart';

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
            onTap: (){
              Get.back();
            },
            child: Padding(
              padding:  EdgeInsets.only(left: getWidth(20)),
              child: Align(
                alignment: Alignment.topLeft,
                child: Icon(Icons.cancel,size: getHeight(35),color: white,),
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
                onTap: (){
                  Get.to(()=>SyncfusionMap());
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
              Material(
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
              SizedBox(
                height: getHeight(20),
              ),
              Material(
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
                      const Icon(
                        Icons.info_rounded,
                        color: yellow,
                      ),
                      SizedBox(
                        width: getWidth(32),
                      ),
                      Text(
                        "drawer3".tr.toString().toUpperCase(),
                        style: kSize18W700ColorLightBlueAccent,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          
         
        ],
      ),
    );
  }
}
