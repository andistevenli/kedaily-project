import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../constant/my_color.dart';

class EditDeleteListTileSwipe extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? trailing;
  final void Function(BuildContext)? onPressedEdit;
  final void Function(BuildContext)? onPressedDelete;
  final void Function()? onTap;

  const EditDeleteListTileSwipe(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.trailing,
      required this.onPressedEdit,
      required this.onPressedDelete,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: onPressedEdit,
            backgroundColor: MyColor.editColor,
            foregroundColor: MyColor.infoColor,
            icon: Icons.edit,
            label: 'Ubah',
          ),
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
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            color: MyColor.subInfoColor,
          ),
        ),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}
