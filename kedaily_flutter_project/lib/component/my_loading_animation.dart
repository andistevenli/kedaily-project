import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../constant/my_color.dart';

class MyLoadingAnimation {
  static Widget staggeredDotsWave() {
    return LoadingAnimationWidget.staggeredDotsWave(
        color: MyColor.primaryColor, size: 50);
  }

  static Widget stretchedDots() {
    return LoadingAnimationWidget.stretchedDots(
        color: MyColor.primaryColor, size: 50);
  }

  static Widget fourRotatingDots() {
    return LoadingAnimationWidget.fourRotatingDots(
        color: MyColor.primaryColor, size: 50);
  }
}
