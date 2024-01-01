
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/size_config.dart';
import '../utils/text_styles.dart';



class CustomButton extends StatelessWidget {
  final double? height;
  final double? width;
  final double? roundCorner;
  final String text;
  final double? fontSize;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  void Function() onPressed;
  final bool? gradientt;
  final FontWeight? fontWeight;

  CustomButton(
      {this.height,
      this.width,
      required this.text,
      this.fontSize,
      this.borderColor,
      this.textColor,
      this.roundCorner,
      this.color,
      required this.onPressed,
      Key? key,
      this.gradientt,
      this.fontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
   SizeConfig().init(context);
    return Container(
      height: height ?? getHeight(52),
      width: width ?? getWidth(334),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(roundCorner ?? getHeight(8)),
          color: color ?? green,
          border: borderColor != null ? Border.all(color: borderColor!) : null),
      child: MaterialButton(
        shape: const RoundedRectangleBorder(
            // borderRadius: BorderRadius.circular(roundCorner ?? 30),
            ),
        onPressed: onPressed,
        child: Text(
          text,
          style: textColor == null
              ? kSize20WhiteW400Text
              : kSize20WhiteW400Text.copyWith(color: textColor),
        ),
      ),
    );
  }
}
