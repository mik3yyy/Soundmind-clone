import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
    Routes.chatNAme,
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
    // TODO: implement initState

    super.initState();
    print(widget.routeState);
    // if(Routes.homePath )
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant MainPage oldWidget) {
    // TODO: implement didUpdateWidget
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
    } else if (path.contains(Routes.chatNAme)) {
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
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            label: 'Find a doc',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Blogs',
          ),
        ],
      ),
    );
  }
}
