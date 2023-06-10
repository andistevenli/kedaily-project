import 'package:flutter/material.dart';
import '../../../constant/my_color.dart';

class PrimaryButton extends StatelessWidget {
  final void Function()? onPressedEvent;
  final IconData icon;
  final String label;

  const PrimaryButton(
      {super.key,
      required this.icon,
      required this.label,
      required this.onPressedEvent});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressedEvent,
      icon: Icon(
        icon,
        size: 22,
        color: MyColor.whiteColor,
      ),
      label: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: MyColor.whiteColor,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: MyColor.primaryColor,
        elevation: 0,
        fixedSize: Size(MediaQuery.of(context).size.width, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}
