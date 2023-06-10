import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../constant/my_reg_exp.dart';

class SearchTextBox extends StatelessWidget {
  final bool enabled;
  final TextEditingController textEditingController;
  final int maxLength;

  const SearchTextBox({
    super.key,
    required this.enabled,
    required this.textEditingController,
    required this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      controller: textEditingController,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      autocorrect: false,
      enableSuggestions: false,
      decoration: InputDecoration(
        errorMaxLines: 3,
        hintText: 'Ketikkan kata kunci',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      maxLength: maxLength,
      inputFormatters: [
        FilteringTextInputFormatter.allow(MyRegExp.hurufAngkaSpasi),
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Ketikkan dulu kata kunci yang diinginkan';
        } else {
          if (!MyRegExp.hurufAngkaSpasi.hasMatch(value)) {
            return 'Kata kunci hanya boleh diisi huruf,angka dan spasi';
          }
        }
        return null;
      },
    );
  }
}
