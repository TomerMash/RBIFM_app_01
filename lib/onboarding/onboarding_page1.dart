import 'package:reut_buy_it_for_me/onboarding/circles_with_image.dart';
import 'package:reut_buy_it_for_me/utils/assets.dart';
import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container( 
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage(Assets.popupBackground),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          new Padding(
                  padding: const EdgeInsets.fromLTRB(40, 40, 40, 16),
                  child: SizedBox(
                  child: Image(
                    image: AssetImage(Assets.popupLogo),
                    fit: BoxFit.fitHeight,
                  ),
                  height: 70,
                  width: 152,
                ),
          ),
          Text('ברוכים הבאים ותודה שהורדתם את\n (:  האפליקציה שלי',
                    style: Theme.of(context).textTheme.title.copyWith(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
          new Padding(
                  padding: const EdgeInsets.fromLTRB(40, 32, 40, 16),
                  child: Text('?מה זה רעות תקני לי',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26.0),
                    textAlign: TextAlign.center,
                  ),
          ),
          Text(',אני חופרת ברשת, עוקבת אחר מוצרים\nמשיגה דילים, סוגרת שיתופי פעולה שווים\n.ואתם קונים חכם',
                    style: Theme.of(context).textTheme.title.copyWith(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
          new Padding(
                  padding: const EdgeInsets.fromLTRB(40, 32, 40, 16),
                  child: Text('.יאללה, מתחילים, תהנו',
                    style: Theme.of(context).textTheme.title.copyWith(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
          ),
        ],
      ),
    );
  }
}