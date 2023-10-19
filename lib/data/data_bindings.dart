import 'package:get/get.dart';
import 'package:tag_app/controllers/auth_controller.dart';
import 'package:tag_app/controllers/home_controller.dart';

import '../controllers/general_controller.dart';

Future  DataBindings() async{



  Get.lazyPut(() => AuthController(),fenix: true);
  Get.lazyPut(() => HomeController(),fenix: true);
  Get.lazyPut(() => GeneralController(),fenix: true);



}