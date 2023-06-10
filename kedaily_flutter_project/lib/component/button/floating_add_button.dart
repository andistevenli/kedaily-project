import 'package:flutter/material.dart';

class FloatingAddButton extends StatelessWidget {
  final void Function()? onPressed;
  final String toolTip;

  const FloatingAddButton(
      {super.key, required this.toolTip, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      tooltip: toolTip,
      onPressed: onPressed,
      child: const Icon(Icons.add),
    );
  }
}
