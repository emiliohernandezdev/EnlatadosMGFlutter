import 'package:flutter/material.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';

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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.black,
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: DotNavigationBar(
          margin: EdgeInsets.only(left: 10, right: 10),
          currentIndex: _SelectedTab.values.indexOf(_selectedTab),
          dotIndicatorColor: Colors.black,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey[300],
          // enableFloatingNavBar: false,
          onTap: _handleIndexChanged,
          items: [
            /// Home
            DotNavigationBarItem(
              icon: Icon(Icons.home),
              selectedColor: Colors.red,
            ),

            /// Likes
            DotNavigationBarItem(
              icon: Icon(Icons.people_alt_sharp),
              selectedColor: Colors.red,
            ),

            DotNavigationBarItem(
              icon: Icon(Icons.local_shipping),
              selectedColor: Colors.red,
            ),

            /// Search
            DotNavigationBarItem(
              icon: Icon(Icons.directions_car),
              selectedColor: Colors.red,
            ),

            /// Profile
            DotNavigationBarItem(
              icon: Icon(Icons.list_alt),
              selectedColor: Colors.red,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
        tooltip: 'Agregar',
      ),
    );
  }
}

enum _SelectedTab { home, clients, couriers, vehicles, orders }
