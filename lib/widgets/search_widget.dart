  import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/constants.dart';

Container searchWidget(String hint) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SvgPicture.asset(AppAssets.search,
                height: 20,
                colorFilter: const ColorFilter.mode(
                  AppConstants.iconColor,
                  BlendMode.srcATop,
                )),
          ),
          hintText:hint,
          hintStyle: const TextStyle(
            color: AppConstants.grey400,
            fontWeight: FontWeight.normal,
            fontSize: AppConstants.large,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: AppConstants.grey300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: AppConstants.primaryColor),
          ),
        ),
      ),
    );
  }