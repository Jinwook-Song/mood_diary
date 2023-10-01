import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_diary/common/widgets/navigation_tab.dart';
import 'package:mood_diary/features/main/views/home_screen.dart';
import 'package:mood_diary/features/main/views/write_screen.dart';

const List<String> _tabs = [
  'home',
  'write',
];

class MainNavigation extends StatefulWidget {
  final String tab;

  const MainNavigation({super.key, required this.tab});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  late int _currentIndex = _tabs.indexOf(widget.tab);

  void _onBottomNavigationTap(int tab) {
    context.go('/${_tabs[tab]}');
    setState(() {
      _currentIndex = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Offstage(
            offstage: _currentIndex != 0,
            child: const HomeScreen(),
          ),
          Offstage(
            offstage: _currentIndex != 1,
            child: const WriteScreen(),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
          elevation: 1,
          shadowColor: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              NavigationTab(
                  icon: Icons.home_filled,
                  selectedIcon: Icons.home_filled,
                  isSelected: _currentIndex == 0,
                  onTap: () => _onBottomNavigationTap(0)),
              NavigationTab(
                  icon: Icons.brush_outlined,
                  selectedIcon: Icons.brush_rounded,
                  isSelected: _currentIndex == 1,
                  onTap: () => _onBottomNavigationTap(1)),
            ],
          )),
    );
  }
}
