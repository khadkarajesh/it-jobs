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
  double _opacity = 1.0;

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
      end: BorderRadius.circular(80),
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
                  setState(() {
                    _opacity = _opacity == 0.0 ? 1.0 : 0.0;
                  });
                  _controller.reset();
                  _controller.forward();
                },
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 16, right: 32, left: 32, bottom: 16),
                  child: AnimatedOpacity(
                    opacity: _opacity,
                    duration: Duration(milliseconds: 600),
                    child: Text(
                      "Sign in",
                      style: TextStyle(),
                    ),
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
