import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../style.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StateProfileScreen();
}

class _StateProfileScreen extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.clear,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: Container(
        color: Theme.of(context).accentColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            CircleAvatar(
              radius: 55,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/profile_image.jpg'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "Rajesh Khadka",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.location_on,
                  color: Colors.white,
                ),
                Text(
                  "Kathmandu, Nepal",
                  style: description,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                "Software Engineer at Nepninja, Have been in this industry with since 2013",
                textAlign: TextAlign.center,
                style: description,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
