import 'package:flutter/material.dart';
import 'package:reut_buy_it_for_me/bottom_navigation.dart';
// import 'package:reut_buy_it_for_me/tab_webview.dart';
import 'onboarding/onboarding_controller.dart';
class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/detail';
}

class TabNavigator extends StatelessWidget {

  TabNavigator({this.navigatorKey, this.tabItem});
  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;

  void pushToDetail(BuildContext context, {int materialIndex: 500}) {
    var routeBuilders = _routeBuilders(context, materialIndex: materialIndex);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => routeBuilders[TabNavigatorRoutes.detail](context),
      ),
    );
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context,
      {int materialIndex: 500}) {
    //     switch (tabItem) {
    //   case TabItem.home:
    //     return {
    //       TabNavigatorRoutes.root: (context) => RTWebView("1רעות תקני לי",
    //       TabHelper.url(tabItem))
    //     };
    //   case TabItem.favorites:
    //     return {
    //       TabNavigatorRoutes.root: (context) => RTWebView("2רעות תקני לי",
    //       TabHelper.url(tabItem))
    //     };
    //   case TabItem.buyMe:
    //     return {
    //       TabNavigatorRoutes.root: (context) => RTWebView("רעות תקני לי",
    //       TabHelper.url(tabItem))
    //     };
    //   case TabItem.meetUs:
    //     return {
    //       TabNavigatorRoutes.root: (context) => RTWebView("רעות תקני לי",
    //       TabHelper.url(tabItem))
    //     };
    //   case TabItem.calculator:
    //     return {
    //       TabNavigatorRoutes.root: (context) => RTWebView("רעות תקני לי",
    //       TabHelper.url(tabItem))
    //     };
    // }
    return {
      // TabNavigatorRoutes.root: (context) => RTWebView("רעות תקני לי",
      //     TabHelper.url(tabItem)), //TabWebView(title: "רעות תקני לי",
      // url: TabHelper.url(tabItem)
      // ),
      // TabNavigatorRoutes.root: (context) => ColorsListPage(
      // color: TabHelper.color(tabItem),
      //       title: TabHelper.description(tabItem),
      //       onPush: (materialIndex) =>
      //           _push(context, materialIndex: materialIndex),
      //     ),
      // TabNavigatorRoutes.detail: (context) => ColorDetailPage(
      //       color: TabHelper.color(tabItem),
      //       title: TabHelper.description(tabItem),
      //       materialIndex: materialIndex,
      //     ),
      TabNavigatorRoutes.detail: (context) => OnboardingMainPage()
    };
  }

  @override
  Widget build(BuildContext context) {
    var routeBuilders = _routeBuilders(context);

    return Navigator(
        key: navigatorKey,
        initialRoute: TabNavigatorRoutes.root,
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) => routeBuilders[routeSettings.name](context),
          );
        });
  }
}
