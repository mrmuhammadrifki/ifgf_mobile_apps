import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:ifgf_apps/config/themes/base_color.dart';
import 'package:ifgf_apps/core/utils/assets.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({super.key, required this.child});

  final StatefulNavigationShell child;

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 81,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                offset: Offset(0, -5),
                blurRadius: 14,
                spreadRadius: 0,
                color: BaseColor.black.withValues(alpha: 0.08),
              ),
            ],
          ),
          child: BottomNavigationBar(
            elevation: 0,
            currentIndex: widget.child.currentIndex,
            onTap: (index) {
              widget.child.goBranch(
                index,
                initialLocation: index == widget.child.currentIndex,
              );
              setState(() {});
            },
            items: navbarItems,
          ),
        ),
      ),
    );
  }

  static final navbarItems = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: SvgPicture.asset(AssetsIcon.home),
      activeIcon: SvgPicture.asset(AssetsIcon.homeFilled),
      label: 'Beranda',
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset(AssetsIcon.profile),
      activeIcon: SvgPicture.asset(AssetsIcon.profileFilled),
      label: 'Akun Saya',
    ),
  ];
}
