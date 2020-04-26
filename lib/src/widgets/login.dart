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
        alignment: Alignment.topLeft,
        padding: EdgeInsets.only(top: 64, left: 16, right: 16, bottom: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            getHeader(),
            getForm(),
          ],
        ),
      ),
    );
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
            height: 32,
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

  bool isValid() {}

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
            onChanged: (value) {
              enableAutoValidate();
            },
          ),
          TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                hintText: 'Enter your password',
              ),
              validator: (value) =>
                  value.isEmpty ? "Password can't be empty" : null,
              onChanged: (value) {
                enableAutoValidate();
              }),
          SizedBox(
            height: 24,
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
              makeRequest(reset);
            },
          ),

//          AnimatedButton(),
        ],
      ),
    );
  }

  void makeRequest(Function reset) {
    Future.delayed(Duration(seconds: 3), () {
      reset();
    });
  }

  void enableAutoValidate() {
    if (!_autoValidate) {
      setState(() {
        _autoValidate = true;
      });
    }
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
