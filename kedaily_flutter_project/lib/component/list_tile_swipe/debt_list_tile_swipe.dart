import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../constant/my_color.dart';

class DebtListTileSwipe extends StatelessWidget {
  final String title;
  final String subtitle;
  final String trailing;
  final void Function(BuildContext)? onPressedDelete;
  final void Function()? onTap;

  const DebtListTileSwipe(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.trailing,
      required this.onPressedDelete,
      required this.onTap});

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
          style: const TextStyle(color: MyColor.subInfoColor),
        ),
        trailing: Text(
          trailing,
          style: const TextStyle(color: MyColor.successColor),
        ),
        onTap: onTap,
      ),
    );
  }
}
