import 'package:flutter/material.dart';

const Color kPrimaryColor = Color(0xff03253A);
const Color kGryColor = Color(0xFF8F8F8F);
const Color kTextColor = Color(0xff000000);
const Color kLightTextColor = Color(0xffA4A0A0);
const Color kDarkTextColor = Color(0xff403838);
const Color kGreenColor = Color(0xff85BF7A);

const String homeVideo = "assets/videos/home_video.mp4";

String getImage(String imageName) {
  return 'assets/images/$imageName';
}

String getProductImage(String imageName) {
  return 'assets/images/products/$imageName';
}

String getIcons(String imageName) {
  return 'assets/icons/$imageName';
}

String getNetworkImage(String imageName) {
  return 'https://ghinaanalshshama.com/public/img/$imageName';
}
