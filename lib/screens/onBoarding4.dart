import 'package:flutter/material.dart';
import 'package:todo_sapient_assignment/utils/sizeConfig.dart';

class OnBoarding4 extends StatefulWidget {
  @override
  _OnBoarding4State createState() => _OnBoarding4State();
}

class _OnBoarding4State extends State<OnBoarding4> {
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
                            text: 'Pinch together vertically ',
                            style: new TextStyle(fontWeight: FontWeight.bold)),
                        new TextSpan(
                            text:
                                'to collapse your current level and navigate up'),
                      ],
                    ),
                  ),
                ],
              ),
              Image.asset("assets/Screenshot6.png")
            ],
          ),
        ),
      ),
    );
  }
}
