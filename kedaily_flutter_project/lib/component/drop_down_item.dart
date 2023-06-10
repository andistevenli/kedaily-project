import 'package:flutter/material.dart';

class DropDownItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final int listLength;
  final DropdownMenuItem<int> Function(int) generator;
  final void Function(int?)? onChanged;
  final int? value;

  const DropDownItem(
      {super.key,
      required this.label,
      required this.icon,
      required this.value,
      required this.listLength,
      required this.generator,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      borderRadius: const BorderRadius.all(Radius.circular(14)),
      decoration: InputDecoration(
        errorMaxLines: 3,
        helperMaxLines: 3,
        helperText: 'Pilih salah satu $label yang tersedia',
        label: Text(label),
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      value: value,
      isExpanded: true,
      hint: Text('Pilih $label'),
      items: List.generate(listLength, generator),
      onChanged: onChanged,
      validator: (value) {
        if (value == null) {
          return '$label harus dipilih';
        }
        return null;
      },
    );
  }
}
