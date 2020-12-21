import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:todo_sapient_assignment/utils/sizeConfig.dart';

class OnBoarding5 extends StatefulWidget {
  final ValueNotifier<double> notifier;
  final ValueNotifier<ScrollDirection> directionNotifier;

  const OnBoarding5({Key key, this.notifier, this.directionNotifier})
      : super(key: key);

  @override
  _OnBoarding5State createState() => _OnBoarding5State();
}

class _OnBoarding5State extends State<OnBoarding5> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                        new TextSpan(
                            text: 'Tap on list ',
                            style: new TextStyle(fontWeight: FontWeight.bold)),
                        new TextSpan(text: 'to see its content'),
                      ],
                    ),
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
                            text: 'Tap on list title ',
                            style: new TextStyle(fontWeight: FontWeight.bold)),
                        new TextSpan(text: 'to edit it'),
                      ],
                    ),
                  ),
                ],
              ),
              Image.asset("assets/Screenshot4.png")
            ],
          ),
        ),
      ),
    );
  }
}
