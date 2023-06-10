import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../constant/my_reg_exp.dart';

class NameTextBox extends StatelessWidget {
  final bool enabled;
  final TextEditingController textEditingController;
  final String helperText;
  final String hintText;
  final String labelText;
  final IconData icon;
  final int maxLength;

  const NameTextBox({
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
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
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
        FilteringTextInputFormatter.allow(MyRegExp.hurufSpasi),
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$labelText harus diisi';
        } else {
          if (!MyRegExp.hurufSpasi.hasMatch(value)) {
            return '$labelText hanya boleh diisi huruf dan spasi';
          }
          final List<String> word = value.split(' ');
          for (int i = 0; i < word.length; i++) {
            if (word[i].substring(0, 1) !=
                word[i].substring(0, 1).toUpperCase()) {
              return 'Setiap kata harus diawali huruf kapital';
            }
          }
        }
        return null;
      },
    );
  }
}
