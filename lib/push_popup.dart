import 'package:flutter/material.dart';

class PushPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container( 
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage("assets/popup_background.png"),
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
                child: new Image.asset("assets/close_popup_button.png"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            )
          ),
          Text('tesc')
        ],
      ),
    );
  }

}