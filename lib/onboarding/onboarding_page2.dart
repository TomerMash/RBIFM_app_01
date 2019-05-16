import 'package:reut_buy_it_for_me/utils/assets.dart';
import 'package:flutter/material.dart';

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          new Padding(
            padding: const EdgeInsets.fromLTRB(40, 50, 40, 16),
            child: SizedBox(
              child: Image(
                image: AssetImage(Assets.popupLogo),
                fit: BoxFit.fitHeight,
              ),
              height: 70,
              width: 152,
            ),
          ),
          new FlatButton(
              onPressed: () { Navigator.pop(context, "favorite"); },
              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Image.asset(Assets.welcome2BOX1Up)),
          new FlatButton(
              onPressed: () { Navigator.pop(context, "main"); },
              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Image.asset(Assets.welcome2BOX2Middle)),
          new FlatButton(
              onPressed: () { Navigator.pop(context, "calculator"); },
              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Image.asset(Assets.welcome2BOX3Down)),
        ],
      );
  }
}
