import 'package:flutter/material.dart';
import '../../../constant/my_color.dart';

class SecondaryButton extends StatelessWidget {
  final void Function()? onPressedEvent;
  final IconData icon;
  final String label;

  const SecondaryButton(
      {super.key,
      required this.icon,
      required this.label,
      required this.onPressedEvent});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressedEvent,
      icon: Icon(
        icon,
        size: 22,
        color: MyColor.primaryColor,
      ),
      label: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: MyColor.primaryColor,
        ),
      ),
      style: OutlinedButton.styleFrom(
        backgroundColor: MyColor.whiteColor,
        elevation: 0,
        side: const BorderSide(color: MyColor.primaryColor, width: 2),
        fixedSize: Size(MediaQuery.of(context).size.width, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}
