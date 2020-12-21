import 'package:flutter/material.dart';
import 'package:todo_sapient_assignment/utils/sizeConfig.dart';

class OnBoarding2 extends StatefulWidget {
  @override
  _OnBoarding2State createState() => _OnBoarding2State();
}

class _OnBoarding2State extends State<OnBoarding2> {
  @override
  Widget build(BuildContext context) {
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
                  new RichText(
                    textAlign: TextAlign.center,
                    text: new TextSpan(
                      // Note: Styles for TextSpans must be explicitly defined.
                      // Child text spans will inherit styles from parent
                      style: new TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        new TextSpan(
                            text: 'Tap and hold ',
                            style: new TextStyle(fontWeight: FontWeight.bold)),
                        new TextSpan(text: 'to pick an item up '),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 3.5 * SizeConfig.heightMultiplier,
                  ),
                  Container(
                    child: Text(
                      'Drag it up or down to change its priority',
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              Image.asset("assets/Screenshot7.png")
            ],
          ),
        ),
      ),
    );
  }
}
