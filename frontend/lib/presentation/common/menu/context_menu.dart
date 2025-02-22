import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/presentation/common/text/body_medium.dart';

class ContextMenu extends StatelessWidget {
  final IconData icon;
  final List<MenuItemButton> children;

  const ContextMenu({required this.icon, required this.children});

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      style: MenuStyle(elevation: WidgetStateProperty.all(0)),
      clipBehavior: Clip.none,
      menuChildren: children,
      builder:
          (context, controller, child) => IconButton(
            visualDensity: VisualDensity.compact,
            padding: const EdgeInsets.all(0),
            icon: Icon(icon, size: 22),
            onPressed: () {
              if (controller.isOpen) {
                controller.close();
              } else {
                controller.open();
              }
            },
          ),
    );
  }
}

class ContextMenuItem extends MenuItemButton {
  final IconData icon;
  final String text;
  final Color color;

  ContextMenuItem({
    required this.icon,
    required this.text,
    required this.color,
    required super.onPressed,
  }) : super(
         child: Row(
           crossAxisAlignment: CrossAxisAlignment.center,
           mainAxisSize: MainAxisSize.min,
           children: [
             Icon(icon, size: 18, color: color),
             const HBox(4),
             BodyMedium(text: text, color: color),
           ],
         ),
       );
}
