import 'package:flutter/material.dart';

class DisabledTextBox extends StatelessWidget {
  final TextEditingController textEditingController;
  final String teks;
  final IconData icon;
  final String label;

  const DisabledTextBox({
    super.key,
    required this.textEditingController,
    required this.icon,
    required this.teks,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    textEditingController.text = teks;
    return TextFormField(
      enabled: false,
      controller: textEditingController,
      decoration: InputDecoration(
        label: Text(label),
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}
