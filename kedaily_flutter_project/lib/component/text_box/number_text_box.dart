import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../constant/my_reg_exp.dart';

class NumberTextBox extends StatelessWidget {
  final bool enabled;
  final TextEditingController textEditingController;
  final String helperText;
  final String hintText;
  final String labelText;
  final IconData icon;
  final int maxLength;

  const NumberTextBox({
    super.key,
    required this.enabled,
    required this.textEditingController,
    required this.helperText,
    required this.hintText,
    required this.labelText,
    required this.icon,
    required this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      maxLength: maxLength,
      controller: textEditingController,
      keyboardType: TextInputType.number,
      autocorrect: false,
      enableSuggestions: false,
      decoration: InputDecoration(
        errorMaxLines: 3,
        helperMaxLines: 3,
        helperText: helperText,
        hintText: hintText,
        prefixIcon: Icon(icon),
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow(MyRegExp.angka),
        FilteringTextInputFormatter.deny(MyRegExp.spasi),
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$labelText harus diisi';
        } else {
          if (!MyRegExp.angka.hasMatch(value) &&
              !MyRegExp.spasi.hasMatch(value)) {
            return '$labelText hanya boleh diisi angka';
          }
        }
        return null;
      },
    );
  }
}
