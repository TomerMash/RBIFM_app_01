import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reut_buy_it_for_me/models/side_menu_model.dart';
import 'package:reut_buy_it_for_me/providers/side_menu_provider.dart';
import 'package:reut_buy_it_for_me/utils/AppColors.dart';

class SideDrawer extends StatelessWidget {
  final Function itemTapped;

  SideDrawer(this.itemTapped);

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<SideMenuProvider>(context);
    data.fetchData();
    List<SideMenuItem> list = data.getResponseJson();
    print(data.isFetching);
    return (list != null && list.length > 0)
        ? Theme(
            data: Theme.of(context)
                .copyWith(canvasColor: Color.fromRGBO(244, 244, 244, 1)),
            child: Drawer(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 60, 24, 16),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                          height: 480.0,
                          child: new ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: list.length,
                              itemBuilder: (BuildContext ctxt, int index) {
                                return ListTile(
                                  title: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      '${list[index].name}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .title
                                          .copyWith(
                                              color: AppColors.menuText,
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  onTap: () {
                                    // if (list[index].type == 'url') {
                                    //   webView.loadUrl(list[index].action);
                                    //   itemTapped(list[index]);
                                    // }
                                    itemTapped(list[index]);
                                    // url = TabHelper.url(TabItem.favorites);
                                    // webView.loadUrl(url);
                                    //Navigator.pop(context);
                                  },
                                );
                              })
                          // ListTile(
                          //       title: Align(
                          //         alignment: Alignment.centerRight,
                          //         child: Text(
                          //           TabHelper.description(TabItem.home),
                          //           style: Theme.of(context).textTheme.title.copyWith(
                          //               color: AppColors.menuText,
                          //               fontWeight: FontWeight.bold),
                          //         ),
                          //       ),
                          //       onTap: () {
                          //         url = TabHelper.url(TabItem.home);
                          //         webView.loadUrl(url);
                          //         Navigator.pop(context);
                          //       },
                          //     ),
                          //     ListTile(
                          //       title: Align(
                          //         alignment: Alignment.centerRight,
                          //         child: Text(
                          //           TabHelper.description(TabItem.favorites),
                          //           style: Theme.of(context).textTheme.title.copyWith(
                          //               color: AppColors.menuText,
                          //               fontWeight: FontWeight.bold),
                          //         ),
                          //       ),
                          //       onTap: () {
                          //         url = TabHelper.url(TabItem.favorites);
                          //         webView.loadUrl(url);
                          //         Navigator.pop(context);
                          //       },
                          //     ),
                          //     ListTile(
                          //       title: Align(
                          //         alignment: Alignment.centerRight,
                          //         child: Text(
                          //           TabHelper.description(TabItem.buyMe),
                          //           style: Theme.of(context).textTheme.title.copyWith(
                          //               color: AppColors.menuText,
                          //               fontWeight: FontWeight.bold),
                          //         ),
                          //       ),
                          //       onTap: () {
                          //         url = TabHelper.url(TabItem.buyMe);
                          //         webView.loadUrl(url);
                          //         Navigator.pop(context);
                          //       },
                          //     ),
                          //     ListTile(
                          //       title: Align(
                          //         alignment: Alignment.centerRight,
                          //         child: Text(
                          //           TabHelper.description(TabItem.meetUs),
                          //           style: Theme.of(context).textTheme.title.copyWith(
                          //               color: AppColors.menuText,
                          //               fontWeight: FontWeight.bold),
                          //         ),
                          //       ),
                          //       onTap: () {
                          //         url = TabHelper.url(TabItem.meetUs);
                          //         webView.loadUrl(url);
                          //         Navigator.pop(context);
                          //       },
                          //     ),
                          //     ListTile(
                          //       title: Align(
                          //         alignment: Alignment.centerRight,
                          //         child: Text(
                          //           TabHelper.description(TabItem.calculator),
                          //           style: Theme.of(context).textTheme.title.copyWith(
                          //               color: AppColors.menuText,
                          //               fontWeight: FontWeight.bold),
                          //         ),
                          //       ),
                          //       onTap: () {
                          //         url = TabHelper.url(TabItem.calculator);
                          //         webView.loadUrl(url);
                          //         Navigator.pop(context);
                          //       },
                          //     ),
                          //     ListTile(
                          //       title: Align(
                          //         alignment: Alignment.centerRight,
                          //         child: Text(
                          //           "דרג/י אותנו",
                          //           style: Theme.of(context).textTheme.title.copyWith(
                          //               color: AppColors.pink, fontWeight: FontWeight.bold),
                          //         ),
                          //       ),
                          //       onTap: () {
                          //         LaunchReview.launch(
                          //             writeReview: false,
                          //             androidAppId: "com.reuttomer.reut_buy_it_for_me",
                          //             iOSAppId: "1460171905");
                          //         Navigator.pop(context);
                          //       },
                          //     ),
                          ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Center(child: CircularProgressIndicator());
  }
}
