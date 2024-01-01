import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tag_app/utils/colors.dart';
import 'package:tag_app/utils/size_config.dart';
import 'package:get/get.dart';
import 'package:tag_app/utils/text_styles.dart';
import 'package:tag_app/widgets/progress_bar.dart';
import '../utils/get_gun_pin_data.dart';
import '../utils/images.dart';
import '../utils/suncfusion_map.dart';

class GetPinsMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: FutureBuilder<List<Map<String, dynamic>>?>(
        future: getPins(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ProgressBar();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }else if (snapshot.data!.isEmpty) {
            return Scaffold(
              backgroundColor: white,
              appBar: AppBar(
                backgroundColor: white,
                elevation: 0,
                centerTitle: true,
                leading: GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: Icon(
                    Icons.arrow_back,color: black,
                    size: getHeight(20),

                  ),
                ),
              ),
              body:
               Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text('No Pins to show!',style: kSize28W700ColorWhite.copyWith(color: black,fontWeight: FontWeight.w500),),
                   Center(child: Image.asset(no_image,height: getHeight(400),width: getWidth(200),),),
                 ],
               )
              ,
            );

          } else {
            final gunPins = snapshot.data ?? [];
            Get.log("gunpins $gunPins");
            return SyncfusionMap(gunPins: gunPins);
          }
        },
      ),
    );
  }
}
