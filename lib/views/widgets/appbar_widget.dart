import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool backgroundTransparent;
  const AppBarWidget({
    super.key,
    required this.title,
    this.backgroundTransparent = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:
          backgroundTransparent ? Colors.transparent : Colors.white,
      title: Text(
        title,
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
      ),
      actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.settings))],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}
