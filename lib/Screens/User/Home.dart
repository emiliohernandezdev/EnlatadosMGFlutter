import 'package:enlatadosmgapp/Screens/Dealer/Dealers.dart';
import 'package:enlatadosmgapp/Screens/Report/Reports.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../Client/Clients.dart';
import '../Order/Orders.dart';
import '../Vehicle/Vehicles.dart';

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  var _selectedTab = _SelectedTab.home;

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
      pageController.jumpToPage(i);
    });
  }

  int bottomSelectedIndex = 0;
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      allowImplicitScrolling: false,
      children: <Widget>[
        const Reports(),
        const Clients(),
        const Dealers(),
        const Vehicles(),
        const Orders()
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: buildPageView(),
        bottomNavigationBar: SalomonBottomBar(
          duration: Duration(milliseconds: 1000),
          currentIndex: bottomSelectedIndex,
          onTap: (i) => setState(
              () => {bottomSelectedIndex = i, pageController.jumpToPage(i)}),
          items: [
            /// Home
            SalomonBottomBarItem(
              icon: Icon(Icons.date_range),
              title: Text("Reportes"),
              selectedColor: Colors.purple,
            ),

            /// Likes
            SalomonBottomBarItem(
              icon: Icon(Icons.people_rounded),
              title: Text("Clientes"),
              selectedColor: Colors.pink,
            ),

            /// Search
            SalomonBottomBarItem(
              icon: Icon(Icons.motorcycle_sharp),
              title: Text("Repartidores"),
              selectedColor: Colors.orange,
            ),

            /// Profile
            SalomonBottomBarItem(
              icon: Icon(Icons.directions_car_sharp),
              title: Text("Vehículos"),
              selectedColor: Colors.teal,
            ),

            SalomonBottomBarItem(
              icon: Icon(Icons.list_sharp),
              title: Text("Órdenes"),
              selectedColor: Colors.red,
            ),
          ],
        ));
  }
}

enum _SelectedTab { home, clients, couriers, vehicles, orders }
