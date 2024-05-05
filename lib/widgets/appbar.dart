import 'package:flutter/material.dart';
import 'package:projectresearch/consts/colors/colors.dart';

class MainAppbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppbarColors.appbarBackGround,
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {},
        color: AppbarColors.iconButtonBackGround,
      ),
      actions: [
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {},
              color: AppbarColors.iconButtonBackGround,
            ),
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () {},
              color: AppbarColors.iconButtonBackGround,
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
              color: AppbarColors.iconButtonBackGround,
            ),
          ],
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
