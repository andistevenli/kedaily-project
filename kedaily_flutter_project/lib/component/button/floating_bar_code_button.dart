import 'package:flutter/material.dart';

class FloatingBarCodeButton extends StatelessWidget {
  final void Function()? onPressed;
  final String toolTip;

  const FloatingBarCodeButton(
      {super.key, required this.toolTip, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      tooltip: toolTip,
      onPressed: onPressed,
      child: const Icon(Icons.barcode_reader),
    );
  }
}
