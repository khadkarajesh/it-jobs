import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StateAnimationButton();
  }
}

class _StateAnimationButton extends State<AnimatedButton>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> transitionTween;
  Animation<BorderRadius> borderRadius;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {}
      });

    transitionTween = Tween<double>(
      begin: 200,
      end: 50,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );
    borderRadius = BorderRadiusTween(
      begin: BorderRadius.circular(30),
      end: BorderRadius.circular(70),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget child) {
        return Stack(
          children: <Widget>[
//            Center(
//                child: Container(
//              alignment: Alignment.bottomCenter,
//              width: transitionTween.value,
//              height: transitionTween.value,
//              decoration: BoxDecoration(
//                color: Colors.black12,
//                borderRadius: borderRadius.value,
//              ),
//            )),
            Container(
              width: transitionTween.value,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: borderRadius.value,
                color: Colors.lightBlueAccent,
              ),
              child: RaisedButton(
                color: Colors.lightBlueAccent,
                textColor: Colors.white,
                onPressed: () {
                  _controller.reset();
                  _controller.forward();
                },
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 16, right: 32, left: 32, bottom: 16),
                  child: Text(
                    "Sign in",
                    style: TextStyle(),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
