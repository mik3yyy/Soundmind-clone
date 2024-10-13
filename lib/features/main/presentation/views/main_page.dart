import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_mind/core/extensions/context_extensions.dart';
import 'package:sound_mind/core/gen/assets.gen.dart';
import 'package:sound_mind/core/routes/routes.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.child, required this.routeState});
  final Widget child;
  final GoRouterState routeState;
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static const List<String> _tabs = [
    Routes.homeName,
    Routes.findADocName,
    Routes.walletName,
    Routes.chatName,
    Routes.blogName,
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _navigateWithCustomTransition(context, _tabs[index]);
  }

  void _navigateWithCustomTransition(BuildContext context, String routeName) {
    GoRouter.of(context).goNamed(routeName, extra: _customPageTransition());
  }

  CustomTransitionPage _customPageTransition() {
    return CustomTransitionPage(
      child: widget.child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MainPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    String path = widget.routeState.fullPath ?? "";
    if (path.contains(Routes.homeName)) {
      setState(() {
        _selectedIndex = 0;
      });
    } else if (path.contains(Routes.findADocName)) {
      print("object");
      setState(() {
        _selectedIndex = 1;
      });
    } else if (path.contains(Routes.walletName)) {
      setState(() {
        _selectedIndex = 2;
      });
    } else if (path.contains(Routes.chatName)) {
      setState(() {
        _selectedIndex = 3;
      });
    } else if (path.contains(Routes.blogName)) {
      setState(() {
        _selectedIndex = 4;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: context.colors.black,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: _selectedIndex == 0
                ? Assets.application.assets.svgs.home2.svg()
                : Assets.application.assets.svgs.home1.svg(),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 1
                ? Assets.application.assets.svgs.search2.svg()
                : Assets.application.assets.svgs.search1.svg(),
            label: 'Find a doc',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 2
                ? Assets.application.assets.svgs.wallet2.svg()
                : Assets.application.assets.svgs.wallet1.svg(),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 3
                ? Assets.application.assets.svgs.message2.svg()
                : Assets.application.assets.svgs.message.svg(),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 4
                ? Assets.application.assets.svgs.blog2.svg()
                : Assets.application.assets.svgs.blog1.svg(),
            label: 'Blogs',
          ),
        ],
      ),
    );
  }
}
