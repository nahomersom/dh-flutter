 import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Container appIconWidget(color, iconColor, iconSvg, height, width) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: SvgPicture.asset(iconSvg,
          colorFilter: ColorFilter.mode(
            iconColor,
            BlendMode.srcATop,
          )),
    );
  }