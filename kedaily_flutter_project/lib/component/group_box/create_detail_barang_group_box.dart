import 'package:flutter/material.dart';
import '../../../constant/my_color.dart';

class DisplayGroupBox extends StatelessWidget {
  final int? itemCount;
  final String label;
  final Widget? Function(BuildContext, int) itemBuilder;

  const DisplayGroupBox({
    super.key,
    required this.label,
    required this.itemCount,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: MyColor.subInfoColor,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(14)),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: MyColor.infoColor,
            ),
          ),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: itemCount,
              itemBuilder: itemBuilder,
            ),
          ),
        ],
      ),
    );
  }
}
