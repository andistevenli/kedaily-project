import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../constant/my_color.dart';

class DeleteListTileSwipe extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? trailing;
  final void Function(BuildContext)? onPressedDelete;

  const DeleteListTileSwipe({
    super.key,
    required this.title,
    required this.subtitle,
    required this.trailing,
    required this.onPressedDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: onPressedDelete,
            backgroundColor: MyColor.deleteColor,
            foregroundColor: MyColor.whiteColor,
            icon: Icons.delete,
            label: 'Hapus',
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: MyColor.infoColor,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            color: MyColor.subInfoColor,
          ),
        ),
        trailing: trailing,
      ),
    );
  }
}
