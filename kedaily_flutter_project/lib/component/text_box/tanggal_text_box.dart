import 'package:flutter/material.dart';

class DateTextBox extends StatelessWidget {
  final TextEditingController textEditingController;

  const DateTextBox({
    super.key,
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: false,
      controller: textEditingController,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.calendar_month),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}
