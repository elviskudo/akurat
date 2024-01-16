import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../pages/article/tag/page.dart';
import '../menu_model.dart';

class AppDrawerItem extends StatelessWidget {
  const AppDrawerItem({
    super.key,
    required this.menu,
  });

  final Menu menu;

  @override
  Widget build(BuildContext context) {
    if (menu.child != null && menu.child!.isNotEmpty) {
      return ExpansionTile(
        leading: const Icon(LucideIcons.shapes),
        title: Text(menu.title),
        children: [
          for (final child in menu.child!)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text(child.title),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TagPage(tag: child.name),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
        ],
      );
    }

    return ListTile(
      leading: const Icon(LucideIcons.shapes),
      title: Text(menu.title),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TagPage(tag: menu.name),
          ),
        );
      },
    );
  }
}
