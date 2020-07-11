import 'package:flutter/material.dart';

import './bottom_nav_bar_options/_bottom_nav_bar_options.dart';
import './const/_const.dart' as CONSTANTS;
import './presentation/_presentation.dart' as PRESENTATION;

class NavBarHome extends StatefulWidget {
  final int selectedIndex;

  NavBarHome({Key key, this.selectedIndex = 1}) : super(key: key);

  @override
  _NavBarHomeState createState() => _NavBarHomeState();
}

class _NavBarHomeState extends State<NavBarHome> {
  int _selectedIndex;

  final List<Widget> _mainPages = [
    NewsFeedPage(),
    MarketPlacePage(),
    OrdersPage(),
    ProfilePage()
  ];

  @override
  void initState() {
    _selectedIndex = widget.selectedIndex;
    super.initState();
  } //static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _mainPages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        //type: BottomNavigationBarType.shifting,
        backgroundColor: Color(0xff1d2340),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(PRESENTATION.Font_awesome_icons.newspaper),
            title: Text(CONSTANTS.BOTTOM_NAV_BAR_NEWS_FEED),
          ),
          BottomNavigationBarItem(
            icon: Icon(PRESENTATION.Font_awesome_icons.cart_arrow_down),
            title: Text(CONSTANTS.BOTTOM_NAV_BAR_MARKET),
          ),
          BottomNavigationBarItem(
            icon: Icon(PRESENTATION.Font_awesome_icons.first_order),
            title: Text(CONSTANTS.BOTTOM_NAV_BAR_ORDERS),
          ),
          BottomNavigationBarItem(
            icon: Icon(PRESENTATION.Font_awesome_icons.user),
            title: Text(CONSTANTS.BOTTOM_NAV_BAR_PROFILE),
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: PRESENTATION.BOTTOM_NAV_BAR_UNSELECTED,
        selectedItemColor: PRESENTATION.BOTTOM_NAV_BAR_SELECTED,
        onTap: _onItemTapped,
      ),
    );
  }
}
