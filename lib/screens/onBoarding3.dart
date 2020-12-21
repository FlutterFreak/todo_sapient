import 'package:flutter/material.dart';
import 'package:todo_sapient_assignment/utils/sizeConfig.dart';

class OnBoarding3 extends StatefulWidget {
  @override
  _OnBoarding3State createState() => _OnBoarding3State();
}

class _OnBoarding3State extends State<OnBoarding3> {
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
                  Container(
                    child: Text(
                      'There are 3 navigation levels',
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              Image.asset("assets/Screenshot5.png")
            ],
          ),
        ),
      ),
    );
  }
}
