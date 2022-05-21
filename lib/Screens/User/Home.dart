import 'package:enlatadosmgapp/Screens/Dealer/Dealers.dart';
import 'package:enlatadosmgapp/Screens/Report/Reports.dart';
import 'package:enlatadosmgapp/Screens/User/Profile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        const Clients(),
        const Dealers(),
        const Vehicles(),
        const Orders(),
        const ProfilePage()
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
          duration: Duration(milliseconds: 500), curve: Curves.easeOutCirc);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: buildPageView(),
        bottomNavigationBar: BottomNavigationBar(
          enableFeedback: true,
          iconSize: 22.0,
          elevation: 2.0,
          currentIndex: bottomSelectedIndex,
          onTap: (int index) {
            setState(() {
              bottomSelectedIndex = index;
            });
            bottomTapped(index);
          },
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.black,
          items: [
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.users), label: "Clientes"),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.peopleCarryBox),
                label: "Repartidores"),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.car), label: "Vehículos"),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.box), label: "Órdenes"),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.userGroup), label: "Perfil")
          ],
        ));
  }
}

enum _SelectedTab { home, clients, couriers, vehicles, orders }
