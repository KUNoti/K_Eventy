import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k_eventy/features/event/presentation/bloc/event/remote/remote_event_bloc.dart';
import 'package:k_eventy/features/event/presentation/bloc/event/remote/remote_event_state.dart';
import 'package:k_eventy/features/event/presentation/pages/home_page.dart';
import 'package:k_eventy/features/event/presentation/pages/myevent_page.dart';
import 'package:k_eventy/features/event/presentation/pages/search_page.dart';
import 'package:k_eventy/features/event/presentation/widgets/event/create_event_dialog.dart';
import 'package:k_eventy/features/users/presentation/pages/user_setting.dart';

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

  Future openDialog(BuildContext context) => showDialog(
    context: context,
    builder: (context) => const CreateEventDialog(),
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildCreateEventButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavbar(),
    );
  }

  Widget _buildCreateEventButton() {
    return SizedBox(
      width: 50,
      height: 50,
      child: FloatingActionButton(
          onPressed: () {
            openDialog(context);
          },
          tooltip: 'Add New Item',
          elevation: 3,
          child: const Icon(Icons.add)
      ),
    );
  }

  Widget _buildBody() {
    return PageView(
      controller: _pageController,
      onPageChanged: (int index) {
        setState(() {
          currentPageIndex = index;
        });
      },
      children: <Widget>[
        BlocBuilder<RemoteEventsBloc, RemoteEventsState>(
          builder: (_, state) {
            if (state is RemoteEventsLoading) {
              return const Center(child: CupertinoActivityIndicator());
            }
            if (state is RemoteEventsError) {
              return const Center(child: Icon(Icons.refresh));
            }
            if (state is RemoteEventsDone) {
              return HomePage(events: state.events);
            }
            return const SizedBox();
          },
        ),
        BlocBuilder<RemoteEventsBloc, RemoteEventsState>(
          builder: (_, state) {
            if (state is RemoteEventsLoading) {
              return const Center(child: CupertinoActivityIndicator());
            }

            if (state is RemoteEventsError) {
              return const Center(child: Icon(Icons.refresh));
            }

            if (state is RemoteEventsDone) {
              return SearchPage(events: state.events);
            }
            return const SizedBox();
          }
        ),
        MyEventsPage(),
        UserSettingsPage(),
      ],
    );
  }

  Widget _buildBottomNavbar() {
    return NavigationBar(
      height: 70,
      onDestinationSelected: (int index) {
        setState(() {
          currentPageIndex = index;
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
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
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
