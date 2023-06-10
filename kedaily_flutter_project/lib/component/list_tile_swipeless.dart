import 'package:flutter/material.dart';

class ListTileSwipeless extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? trailing;

  const ListTileSwipeless({
    super.key,
    required this.title,
    required this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(),
      ),
      trailing: trailing,
    );
  }
}
