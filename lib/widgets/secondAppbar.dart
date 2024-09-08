import 'package:flutter/material.dart';

class SecondAppBar extends StatelessWidget implements PreferredSizeWidget {
  final IconButton leading;

  const SecondAppBar({Key? key, required this.leading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Image.asset('assets/logo.png', height: 120),
      centerTitle: true,
      leading: leading,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
