import 'package:flutter/material.dart';
import 'package:todo_sapient_assignment/utils/sizeConfig.dart';

class OnBoarding1 extends StatefulWidget {
  @override
  _OnBoarding1State createState() => _OnBoarding1State();
}

class _OnBoarding1State extends State<OnBoarding1>
    with SingleTickerProviderStateMixin {
  Animation<Offset> _animation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 500),
      vsync: this,
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.forward();
    });
  }

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
                        new TextSpan(text: 'Clear sorts items by '),
                        new TextSpan(
                            text: 'priority',
                            style: new TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 3.5 * SizeConfig.heightMultiplier,
                  ),
                  Container(
                    child: Text(
                      'Important items are highlighted at the top',
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
