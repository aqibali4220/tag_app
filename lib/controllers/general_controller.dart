import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tag_app/utils/size_config.dart';

import '../data/permissions.dart';
import '../utils/colors.dart';
import '../utils/const.dart';

class GeneralController extends GetxController {
  final gunBox = Hive.box(cGunBoxKey);

  XFile? image;
  File? imageFile;

  var imagePath = "".obs;


}
