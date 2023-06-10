import 'package:flutter/material.dart';
import '../../../constant/my_color.dart';
import '../text_box/number_text_box.dart';

class BarCodeGroupBox extends StatelessWidget {
  final bool enabled;
  final TextEditingController textEditingController;
  final String helper;
  final String hint;
  final String label;
  final IconData icon;
  final int maxLength;
  final Widget widget;

  const BarCodeGroupBox({
    super.key,
    required this.enabled,
    required this.textEditingController,
    required this.helper,
    required this.hint,
    required this.label,
    required this.icon,
    required this.maxLength,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          NumberTextBox(
            enabled: enabled,
            textEditingController: textEditingController,
            helperText: helper,
            hintText: hint,
            labelText: label,
            icon: icon,
            maxLength: maxLength,
          ),
          const SizedBox(
            height: 10,
          ),
          widget,
        ],
      ),
    );
  }
}
