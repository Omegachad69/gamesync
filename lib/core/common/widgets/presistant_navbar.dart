import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:gameync/features/tournaments/presentation/pages/tournament_explore_page.dart';
import 'package:gameync/home/home_imports.dart';

import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class PresistentNavBar extends StatefulWidget {
  const PresistentNavBar({super.key});

  @override
  State<PresistentNavBar> createState() => _PresistentNavBarState();
}

class _PresistentNavBarState extends State<PresistentNavBar> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  late PersistentTabController persistentTabController;
  @override
  void initState() {
    super.initState();
    persistentTabController = PersistentTabController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
      child: PersistentTabView(
        backgroundColor: Colors.transparent,
        margin: EdgeInsets.all(15).copyWith(bottom: 10),
        tabs: [
          PersistentTabConfig(
            screen: TourExplorePage(),
            item: ItemConfig(
              icon: Icon(Icons.explore),
              title: "Messages",
            ),
          ),
          PersistentTabConfig(
            screen: HomePage(),
            item: ItemConfig(
              icon: Icon(Icons.home),
              title: "Home",
            ),
          ),
          // PersistentTabConfig(
          //   screen: name(),
          //   item: ItemConfig(
          //     icon: Icon(Icons.headphones),
          //     title: "Messages",
          //   ),
          // ),
        ],
        navBarBuilder: (navBarConfig) => CustomNavBar(
          navBarConfig: navBarConfig,
        ),
      ),
    );
  }
}

class CustomNavBar extends StatelessWidget {
  final NavBarConfig navBarConfig;
  final NavBarDecoration navBarDecoration;

  CustomNavBar({
    Key? key,
    required this.navBarConfig,
    this.navBarDecoration = const NavBarDecoration(),
  }) : super(key: key);

  Widget _buildItem(ItemConfig item, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: IconTheme(
              data: IconThemeData(
                  size: item.iconSize,
                  color: isSelected
                      ? const Color.fromARGB(255, 101, 39, 176)
                      : Colors.white.withOpacity(0.5)),
              child: isSelected ? item.icon : item.inactiveIcon,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: Material(
              type: MaterialType.transparency,
              child: FittedBox(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedNavBar(
      decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(23),
          border: Border.all(color: Colors.white.withOpacity(0.03)),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.grey.withOpacity(0.15),
                Colors.grey.withOpacity(0.15),
              ])),
      filter: ImageFilter.blur(
        sigmaX: 6,
        sigmaY: 6,
      ),
      opacity: 0.5,
      height: 65,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: this.navBarConfig.items.map((item) {
          int index = this.navBarConfig.items.indexOf(item);
          return Expanded(
            child: InkWell(
              onTap: () {
                this.navBarConfig.onItemSelected(
                    index); // This is the most important part. Without this, nothing would happen if you tap on an item.
              },
              child: _buildItem(
                item,
                this.navBarConfig.selectedIndex == index,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
