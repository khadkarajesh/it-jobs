import 'package:flutter/material.dart';
import 'package:nepninja/nepninja.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StateLogin();
  }
}

class _StateLogin extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool animate = false;
  bool squeezed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.only(
        top: 64,
        left: 16,
        right: 16,
        bottom: 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              getHeader(),
              Padding(
                padding: const EdgeInsets.only(
                  top: 32,
                  bottom: 32,
                ),
                child: getForm(),
              )
            ],
          ),
          Text("Forgot Password?"),
          SizedBox(
            height: 32,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 1,
                  width: 30,
                  color: Colors.grey,
                ),
                Padding(
                  child: Text(
                    "OR",
                  ),
                  padding: EdgeInsets.only(
                    left: 8,
                    right: 8,
                  ),
                ),
                Container(
                  height: 1,
                  width: 30,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          Container(
            width: 200,
            height: 55,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: Colors.grey,
                  width: 2.0,
                )),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/images/google.png",
                    height: 24,
                    width: 24,
                  ),
                  Text(
                    "Sign In with Google",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            ),
          ),
//          SizedBox(
//            height: 80,
//          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: RichText(
                  text: TextSpan(
                children: [
                  TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(color: Colors.black)),
                  TextSpan(
                      text: 'Create Now',
                      style: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              )),
            ),
          )
        ],
      ),
    ));
  }

  Widget getHeader() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Welcome Back,",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            "Sign in to continue",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: 56,
          ),
          Image.asset(
            "assets/images/boy.png",
            height: 60,
            width: 60,
          )
        ],
      ),
    );
  }

  Widget getForm() {
    return Form(
      key: _formKey,
      autovalidate: _autoValidate,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter your email',
              labelText: "Email",
            ),
            validator: (value) => validateEmail(value),
            onChanged: (value) {},
          ),
          TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                hintText: 'Enter your password',
              ),
              validator: (value) =>
                  value.isEmpty ? "Password can't be empty" : null,
              onChanged: (value) {}),
          SizedBox(
            height: 32,
          ),
          CircularProgressButton(
            height: 55,
            width: 200,
            borderRadius: 30,
            backgroundColor: Colors.lightBlueAccent,
            fadeDurationInMilliSecond: 400,
            text: "Sign In",
            progressIndicatorColor: Colors.pinkAccent,
            fontSize: 20.0,
            onTap: (reset) {
              if (_formKey.currentState.validate()) {
                makeRequest(reset);
              } else {
                reset();
                setState(() => _autoValidate = true);
              }
            },
          ),
        ],
      ),
    );
  }

  void makeRequest(Function reset) {
    Future.delayed(Duration(seconds: 3), () {
      reset();
    });
  }

  bool isValidEmail(String email) {
    String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(email);
  }

  String validateEmail(String value) {
    return value.isNotEmpty && isValidEmail(value) ? null : "Enter valid email";
  }
}
