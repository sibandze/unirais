import 'dart:async';

import 'package:flutter/material.dart';

import './../model/_model.dart';
import './../presentation/_presentation.dart' as PRESENTATION;
import './../util/_util.dart';
import './login/login_screen.dart';
import './registration/sign_up_screen.dart';
import './slide_dots.dart';
import './slide_item.dart';

class GettingStartScreen extends StatefulWidget {
  @override
  _GettingStartScreenState createState() => _GettingStartScreenState();
}

class _GettingStartScreenState extends State<GettingStartScreen> {
  int _currentPage = 0;
  Timer _timer;
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 5), (time) {
      if (_currentPage < slideList.length - 1)
        _currentPage++;
      else
        _currentPage = 0;

      _pageController.animateToPage(_currentPage,
          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    });
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    PageView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: _pageController,
                      onPageChanged: _onPageChanged,
                      itemCount: slideList.length,
                      itemBuilder: (context, index) => SlideItem(index: index),
                    ),
                    Stack(
                      alignment: AlignmentDirectional.topStart,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                            bottom: 36,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              for (int _count = 0;
                                  _count < slideList.length;
                                  _count++)
                                (_count == _currentPage)
                                    ? SlideDot(isActive: true)
                                    : SlideDot()
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      push(context, SignUpScreen());
                    },
                    child: Text(
                      'Sign Up',
                      style: PRESENTATION.GETTING_STARTED_BUTTON_TEXT_STYLE,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.all(15),
                    color: PRESENTATION.PRIMARY_COLOR,
                    textColor: Colors.white,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Have an account?',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          push(context, LoginScreen());
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 18,
                            color: PRESENTATION.PRIMARY_COLOR,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
