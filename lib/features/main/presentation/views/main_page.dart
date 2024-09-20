import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_mind/core/routes/routes.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.child});
  final Widget child;

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
    context.goNamed(_tabs[index]);
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
            icon: Icon(Icons.local_hospital),
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
