import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class AnimatedButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StateAnimationButton();
  }
}

class _StateAnimationButton extends State<AnimatedButton> {
  bool squeezed = false;
  double _opacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        InkWell(
          onTap: () {
            setState(() {
              squeezed = !squeezed;
              _opacity = _opacity == 1.0 ? 0.0 : 1.0;
            });
          },
          child: AnimatedContainer(
            width: squeezed ? 55 : 200,
            height: 50,
            duration: Duration(milliseconds: 700),
            curve: Curves.fastOutSlowIn,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(squeezed ? 70 : 30),
              color: Colors.lightBlueAccent,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AnimatedOpacity(
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  opacity: _opacity,
                  duration: Duration(seconds: 1),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              squeezed = !squeezed;
              _opacity = _opacity == 1.0 ? 0.0 : 1.0;
            });
          },
          child: AnimatedContainer(
            width: squeezed ? 55 : 200,
            height: 50,
            duration: Duration(milliseconds: 700),
            curve: Curves.fastOutSlowIn,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(squeezed ? 70 : 30),
            ),
            child: AnimatedOpacity(
              child: Padding(
                padding: EdgeInsets.all(1),
                child: CircularProgressIndicator(
                    backgroundColor: Colors.lightBlueAccent,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        squeezed ? Colors.pinkAccent : Colors.lightBlueAccent)),
              ),
              opacity: _opacity == 0.0 ? 1.0 : 0.0,
              duration: Duration(milliseconds: 700),
            ),
          ),
        ),
      ],
    );
  }
}
