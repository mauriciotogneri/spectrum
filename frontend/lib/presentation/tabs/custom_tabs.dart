import 'package:dafluta/dafluta.dart';
import 'package:flutter/material.dart';
import 'package:testflow/presentation/common/text/custom_text.dart';
import 'package:testflow/utils/palette.dart';

class CustomTabs extends StatefulWidget {
  final List<TabItem> tabs;
  final List<Widget> children;

  const CustomTabs({required this.tabs, required this.children});

  @override
  State<CustomTabs> createState() => _CustomTabsState();
}

class _CustomTabsState extends State<CustomTabs> {
  int tabSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TabsHeader(
          tabs: widget.tabs,
          tabSelected: tabSelected,
          onSelected: _onTabSelected,
        ),
        const HorizontalDivider(color: Palette.borderInputEnabled, height: 1),
        widget.children[tabSelected],
      ],
    );
  }

  void _onTabSelected(int index) {
    setState(() {
      tabSelected = index;
    });
  }
}

class TabsHeader extends StatelessWidget {
  final List<TabItem> tabs;
  final int tabSelected;
  final Function(int) onSelected;

  const TabsHeader({
    required this.tabs,
    required this.tabSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < tabs.length; i++)
          TabButton(
            tabItem: tabs[i],
            isSelected: i == tabSelected,
            onPressed: () => onSelected(i),
          ),
      ],
    );
  }
}

class TabButton extends StatelessWidget {
  final TabItem tabItem;
  final bool isSelected;
  final VoidCallback onPressed;

  const TabButton({
    required this.tabItem,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Palette.transparent,
      child: InkWell(
        onTap: onPressed,
        child: SizedBox(
          width: tabItem.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 12,
                  bottom: 9,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (tabItem.icon != null)
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Icon(tabItem.icon!, size: 18),
                      ),
                    CustomText(
                      text: tabItem.title,
                      color: Palette.textTitle,
                      weight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ],
                ),
              ),
              HorizontalDivider(
                color:
                    isSelected
                        ? Palette.backgroundTabSelected
                        : Palette.transparent,
                height: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TabItem {
  final String title;
  final double width;
  final IconData? icon;

  const TabItem({required this.title, required this.width, this.icon});
}
