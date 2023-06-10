import 'package:flutter/material.dart';
import '../../../constant/my_color.dart';
import '../button/secondary_button.dart';

class CreateEditGroupBox extends StatelessWidget {
  final int? itemCount;
  final String label;
  final void Function()? onPressedButton;
  final Widget? Function(BuildContext, int) itemBuilder;
  final IconData icon;

  const CreateEditGroupBox({
    super.key,
    required this.itemCount,
    required this.icon,
    required this.label,
    required this.onPressedButton,
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
          SecondaryButton(
            icon: icon,
            label: label,
            onPressedEvent: onPressedButton,
          ),
          const SizedBox(
            height: 10,
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
