import 'package:flutter/material.dart';
import '../../constant/my_color.dart';

class BoxDetailInfo extends StatelessWidget {
  final String subInfo;
  final String info;

  const BoxDetailInfo({super.key, required this.subInfo, required this.info});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          subInfo,
          style: const TextStyle(color: MyColor.subInfoColor),
        ),
        Text(
          info,
          style: const TextStyle(color: MyColor.infoColor, fontSize: 16),
        ),
      ],
    );
  }
}
