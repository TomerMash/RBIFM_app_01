import 'package:flutter/material.dart';
import 'package:reut_buy_it_for_me/utils/assets.dart';
import 'package:reut_buy_it_for_me/notifications/notification_model.dart';

class PushPopup extends StatelessWidget {
  PushPopup(this.message);
  final NotificationObject message;

  @override
  Widget build(BuildContext context) {
    return new Container( 
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage(Assets.popupBackground),
          fit: BoxFit.fitWidth,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: const EdgeInsets.fromLTRB(16, 36, 0, 16),
              child : new FlatButton(
                child: new Image.asset(Assets.closePopupButton),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            )
          ),
          SizedBox(
                  child: Image(
                    image: AssetImage(Assets.popupLogo),
                    fit: BoxFit.fitHeight,
                  ),
                  height: 70,
                  width: 152,
                ),
          Text(message.notification.title)
        ],
      ),
    );
  }

}