import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_sapient_assignment/screens/home.dart';
import 'package:todo_sapient_assignment/utils/sizeConfig.dart';

class OnBoarding7 extends StatefulWidget {
  final FirebaseUser user;

  OnBoarding7({Key key, this.user}) : super(key: key);
  @override
  _OnBoarding7State createState() => _OnBoarding7State();
}

class _OnBoarding7State extends State<OnBoarding7> {
  @override
  Widget build(BuildContext context) {
    print('user 2:${widget.user}');
    return Scaffold(
      body: Center(
        child: Container(
          width: 70 * SizeConfig.widthMultiplier,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20 * SizeConfig.heightMultiplier,
                  ),
                  Text(
                    'Sign up the newsletter and unlock a theme for your lists .',
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 5 * SizeConfig.heightMultiplier,
                  ),
                  Image.asset("assets/Screenshot2.png"),
                  SizedBox(
                    height: 5 * SizeConfig.heightMultiplier,
                  ),
                  Container(
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          hintText: 'Email address',
                          contentPadding: EdgeInsets.all(10)),
                    ),
                  ),
                  SizedBox(
                    height: 5 * SizeConfig.heightMultiplier,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 30 * SizeConfig.widthMultiplier,
                        child: FlatButton(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 1,
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(5)),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Home()),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Skip',
                                style: new TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            )),
                      ),
                      Container(
                        width: 30 * SizeConfig.widthMultiplier,
                        child: FlatButton(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 1,
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(5)),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Home()),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Join',
                                style: new TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            )),
                      )
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
