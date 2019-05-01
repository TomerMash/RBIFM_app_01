import 'package:flutter/material.dart';
import './utils/AppColors.dart';
import './utils/assets.dart';

enum TabItem { home, favorites, buyMe, meetUs, calculator }

class TabHelper {
  static TabItem item({int index}) {
    switch (index) {
      case 0:
        return TabItem.home;
      case 1:
        return TabItem.favorites;
      case 2:
        return TabItem.buyMe;
      case 3:
        return TabItem.meetUs;
      case 4:
        return TabItem.calculator;
    }
    return TabItem.home;
  }

  static String description(TabItem tabItem) {
    switch (tabItem) {
      case TabItem.home:
        return 'ראשי';
      case TabItem.favorites:
        return 'המומלצים';
      case TabItem.buyMe:
        return 'תקני לי';
      case TabItem.meetUs:
        return 'הכירו את';
      case TabItem.calculator:
        return 'מחשבון';
    }
    return '';
  }

  static String url(TabItem tabItem) {
    switch (tabItem) {
      case TabItem.home:
        return 'https://reutbuyitforme.com/';
      case TabItem.favorites:
        return 'https://reutbuyitforme.com/%D7%91%D7%91%D7%A7%D7%A9%D7%94-%D7%90%D7%99%D7%A0%D7%93%D7%A7%D7%A1-%D7%94%D7%9E%D7%95%D7%A6%D7%A8%D7%99%D7%9D-%D7%94%D7%9E%D7%95%D7%9E%D7%9C%D7%A6%D7%99%D7%9D-%D7%A9%D7%9C%D7%99/';
      case TabItem.buyMe:
        return 'https://reutbuyitforme.com/category/%D7%A8%D7%A2%D7%95%D7%AA-%D7%AA%D7%A7%D7%A0%D7%99-%D7%9C%D7%99/';
      case TabItem.meetUs:
        return 'https://reutbuyitforme.com/category/%D7%94%D7%9B%D7%99%D7%A8%D7%95-%D7%90%D7%AA/';
      case TabItem.calculator:
        return 'https://reutbuyitforme.com/%D7%A9%D7%A2%D7%A8%D7%99-%D7%9E%D7%98%D7%91%D7%A2/';
    }
    return '';
  }

  static AssetImage icon(TabItem tabItem) {
    switch (tabItem) {
      case TabItem.home:
        return new AssetImage(Assets.iconHome);
      case TabItem.favorites:
        return new AssetImage(Assets.iconSpecials);
      case TabItem.buyMe:
        return new AssetImage(Assets.iconCart);
      case TabItem.meetUs:
        return new AssetImage(Assets.iconMeetUs);
      case TabItem.calculator:
        return new AssetImage(Assets.iconCalculator);
    }
    return null;
  }

  static MaterialColor color(TabItem tabItem) {
    // switch (tabItem) {
    //   case TabItem.home:
    //     return AppColors.pink;
    //   case TabItem.favorites:
    //     return AppColors.pink;
    //   case TabItem.buyMe:
    //     return AppColors.pink;
    //   case TabItem.meetUs:
    //     return AppColors.pink;
    //   case TabItem.calculator:
    //     return AppColors.pink;
    // }
    return AppColors.pink;
  }
}

class BottomNavigation extends StatelessWidget {
  BottomNavigation({this.currentTab, this.onSelectTab, this.onTabIndex});
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;
  final ValueChanged<int> onTabIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          _buildItem(tabItem: TabItem.home),
          _buildItem(tabItem: TabItem.favorites),
          _buildItem(tabItem: TabItem.buyMe),
          _buildItem(tabItem: TabItem.meetUs),
          _buildItem(tabItem: TabItem.calculator),
        ],
        onTap: (index) {
          onSelectTab(
            TabHelper.item(index: index),
          );
          onTabIndex(index);
        });
  }

  BottomNavigationBarItem _buildItem({TabItem tabItem}) {
    String text = TabHelper.description(tabItem);
    AssetImage icon = TabHelper.icon(tabItem);
    return BottomNavigationBarItem(
      icon:
          new ImageIcon(icon, color: _colorTabMatching(item: tabItem)), //Icon(
//        icon,
//        color: _colorTabMatching(item: tabItem),
//      ),
      title: Text(
        text,
        style: TextStyle(
          color: _colorTabMatching(item: tabItem),
        ),
      ),
    );
  }

  Color _colorTabMatching({TabItem item}) {
    return currentTab == item ? TabHelper.color(item) : Colors.grey;
  }
}
