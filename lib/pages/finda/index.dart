import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../../config/size_config.dart';
import '../../widgets/bottom_navigation_item.dart';
import '../pages.dart';
import 'discover.dart';
import 'notifications.dart';
import 'wishlist.dart';

class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      extendBody: true,
      body: Center(
        child: IndexedStack(
          index: _selectedIndex,
          children: [
            Results(),
            Notifications(),
            Discover(),
            WishList(),
            Profile(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                padding: const EdgeInsets.only(bottom: 8, top: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Theme.of(context).primaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 0.9,
                      blurRadius: 3,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      BottomNavigationItem(
                        icon: FeatherIcons.home,
                        active: _selectedIndex == 0,
                        index: 0,
                        onTap: () => _onItemTapped(0),
                      ),
                      BottomNavigationItem(
                        icon: FeatherIcons.bell,
                        active: _selectedIndex == 1,
                        index: 1,
                        onTap: () => _onItemTapped(1),
                      ),
                      BottomNavigationItem(
                        icon: FeatherIcons.globe,
                        active: _selectedIndex == 2,
                        index: 2,
                        onTap: () => _onItemTapped(2),
                      ),
                      BottomNavigationItem(
                        icon: FeatherIcons.bookmark,
                        active: _selectedIndex == 3,
                        index: 3,
                        onTap: () => _onItemTapped(3),
                      ),
                      BottomNavigationItem(
                        icon: FeatherIcons.user,
                        active: _selectedIndex == 4,
                        index: 4,
                        onTap: () => _onItemTapped(4),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: Container(
      //   color: Colors.red,
      //   margin: EdgeInsets.symmetric(
      //     vertical: 10,
      //     horizontal: 30,
      //   ),
      //   child: InkWell(
      //     onTap: null,
      //     child: BottomAppBar(
      //       child: Column(
      //         mainAxisSize: MainAxisSize.min,
      //         crossAxisAlignment: CrossAxisAlignment.center,
      //         children: [
      //           Container(
      //             width: 100.w,
      //             margin: EdgeInsets.only(top: 40),
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceAround,
      //               mainAxisSize: MainAxisSize.max,
      //               children: [
      // BottomNavigationItem(
      //   icon: FeatherIcons.home,
      //   active: _selectedIndex == 0,
      //   onTap: () => _onItemTapped(0),
      // ),
      // BottomNavigationItem(
      //   icon: FeatherIcons.bell,
      //   active: _selectedIndex == 1,
      //   onTap: () => _onItemTapped(1),
      // ),
      // BottomNavigationItem(
      //   icon: FeatherIcons.globe,
      //   active: _selectedIndex == 1,
      //   onTap: () => _onItemTapped(1),
      // ),
      // BottomNavigationItem(
      //   icon: FeatherIcons.shoppingBag,
      //   active: _selectedIndex == 2,
      //   onTap: () => _onItemTapped(2),
      // ),
      // BottomNavigationItem(
      //   icon: FeatherIcons.user,
      //   active: _selectedIndex == 3,
      //   onTap: () => _onItemTapped(3),
      // ),
      //               ],
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
