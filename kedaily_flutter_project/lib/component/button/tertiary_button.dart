import 'package:flutter/material.dart';

class TertiaryButton extends StatelessWidget {
  final void Function()? onPressedEvent;
  final String label;
  final Color buttonColor;
  final Color labelColor;

  const TertiaryButton(
      {super.key,
      required this.label,
      required this.buttonColor,
      required this.labelColor,
      required this.onPressedEvent});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressedEvent,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        elevation: 0,
        fixedSize: Size(MediaQuery.of(context).size.width, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: labelColor,
        ),
      ),
    );
  }
}
