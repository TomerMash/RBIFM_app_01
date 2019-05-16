import 'package:reut_buy_it_for_me/onboarding/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:reut_buy_it_for_me/onboarding/onboarding_page1.dart';
import 'package:reut_buy_it_for_me/onboarding/onboarding_page2.dart';

class _OnboardingMainPageState extends State<OnboardingMainPage> {
  final _controller = new PageController();
  final List<Widget> _pages = [
    Page1(),
    Page2(),
  ];
  int page = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isDone = page == _pages.length - 1;
    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Stack(
        children: <Widget>[
          new Positioned.fill(
            child: new PageView.builder(
              physics: new AlwaysScrollableScrollPhysics(),
              controller: _controller,
              itemCount: _pages.length,
              itemBuilder: (BuildContext context, int index) {
                return _pages[index % _pages.length];
              },
              onPageChanged: (int p){
                setState(() {
                  page = p;
                });
              },
            ),
          ),
          new Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            bottom: 16,
            child: new SafeArea(
              child: AppBar(
                brightness: Brightness.dark,
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                primary: false,
                leading: new Container(),
                title: Text(''),
                actions: <Widget>[
                  FlatButton(
                    child: Text(isDone ? 'DONE' : 'NEXT', style: TextStyle(color: Colors.white),),
                    onPressed: isDone ? (){
                      Navigator.pop(context);
                    } : (){
                      _controller.animateToPage(page + 1, duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                    },
                  )
                ],
              ),
            ),
          ),
          new Positioned(
            bottom: 10.0,
            left: 0.0,
            right: 0.0,
            child: new SafeArea(
              child: new Column(
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: isDone? new Container() : new DotsIndicator(
                      controller: _controller,
                      itemCount: _pages.length,
                      onPageSelected: (int page) {
                        _controller.animateToPage(
                          page,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      isDone? new Container() : new Container(
                        width: 130.0,
                        height: 42.0,
                        decoration: BoxDecoration(
                          borderRadius: new BorderRadius.circular(0.0),
                          border: Border.all(color: Colors.white, width: 2.0),
                          color: Colors.transparent,
                        ),
                        child: new Material(
                          child: FlatButton(
                            child: Text(isDone ? 'סגירה' : 'הבא',
                              style: TextStyle(fontSize: 20.0, color: Colors.white),
                            ),
                            onPressed: isDone ? (){
                              Navigator.pop(context);
                            } : (){
                              _controller.animateToPage(page + 1, duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                            },
                            highlightColor: Colors.white30,
                            splashColor: Colors.white30,
                          ),
                          color: Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}

class OnboardingMainPage extends StatefulWidget {
  OnboardingMainPage({Key key}) : super(key: key);

  @override
  _OnboardingMainPageState createState() => new _OnboardingMainPageState();
}