import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/presentation/common/text/body_medium.dart';
import 'package:testflow/utils/palette.dart';

class ContextMenu extends StatelessWidget {
  final IconData icon;
  final List<MenuItemButton> children;
  final Offset? offset;

  const ContextMenu({required this.icon, required this.children, this.offset});

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      alignmentOffset: offset,
      style: MenuStyle(
        elevation: WidgetStateProperty.all(0),
        backgroundColor: WidgetStateProperty.all(Palette.backgroundEmpty),
        padding: WidgetStateProperty.all(const EdgeInsets.all(0)),
        side: WidgetStateProperty.all(
          const BorderSide(color: Palette.borderInputEnabled, width: 1),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        ),
      ),
      clipBehavior: Clip.none,
      menuChildren: children,
      builder:
          (context, controller, child) => Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              border: Border.all(color: Palette.borderInputEnabled, width: 1),
            ),
            child: IconButton(
              visualDensity: VisualDensity.compact,
              padding: const EdgeInsets.all(0),
              iconSize: 22,
              color: Palette.iconButton,
              icon: Icon(icon),
              onPressed: () {
                if (controller.isOpen) {
                  controller.close();
                } else {
                  controller.open();
                }
              },
            ),
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
