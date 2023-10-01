import 'package:flutter/material.dart';

class NavigationTab extends StatelessWidget {
  final IconData icon;
  final IconData selectedIcon;
  final bool isSelected;
  final VoidCallback onTap;

  const NavigationTab(
      {super.key,
      required this.icon,
      required this.selectedIcon,
      required this.isSelected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onTap,
        child: AnimatedOpacity(
          opacity: isSelected ? 1 : 0.7,
          duration: const Duration(milliseconds: 150),
          child: Icon(
            isSelected ? selectedIcon : icon,
            size: isSelected ? 32 : 30,
          ),
        ),
      ),
    );
  }
}
