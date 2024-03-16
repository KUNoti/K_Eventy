import 'package:flutter/material.dart';
import 'package:k_eventy/pages/home/home_page.dart';
import 'package:k_eventy/pages/search/search_page.dart';
import 'package:k_eventy/pages/user/user_setting.dart';

class NavigationBottom extends StatefulWidget {
  const NavigationBottom({Key? key}) : super(key: key);

  @override
  State<NavigationBottom> createState() => _NavigationBottomState();
}

class _NavigationBottomState extends State<NavigationBottom> {
  int currentPageIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentPageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        children: <Widget>[
          HomePage(),
          SearchPage(),
          Container(
            color: Colors.blue, // Example page color
            child: Center(
              child: Text('My Events Page'),
            ),
          ),
          UserSettingPage(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        height: 70,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
            _pageController.animateToPage(
              index,
              duration: Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.search),
            icon: Icon(Icons.search_outlined),
            label: 'Search',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.favorite),
            icon: Icon(Icons.favorite_outline),
            label: 'My Events',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class NavigationBar extends StatelessWidget {
  final ValueChanged<int> onDestinationSelected;
  final int selectedIndex;
  final List<Widget> destinations;
  final double height;

  const NavigationBar({
    Key? key,
    required this.onDestinationSelected,
    required this.selectedIndex,
    required this.destinations,
    this.height = kBottomNavigationBarHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: destinations
          .map((destination) => BottomNavigationBarItem(
                icon: destination,
                label: '',
              ))
          .toList(),
      currentIndex: selectedIndex,
      onTap: onDestinationSelected,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      selectedFontSize: 0,
      unselectedFontSize: 0,
    );
  }
}

class NavigationDestination extends StatelessWidget {
  final Widget selectedIcon;
  final Widget icon;
  final String label;

  const NavigationDestination({
    Key? key,
    required this.selectedIcon,
    required this.icon,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        selectedIcon,
        SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
