import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:todo_sapient_assignment/screens/onBoarding1.dart';
import 'package:todo_sapient_assignment/screens/onBoarding2.dart';
import 'package:todo_sapient_assignment/screens/onBoarding3.dart';
import 'package:todo_sapient_assignment/screens/onBoarding4.dart';
import 'package:todo_sapient_assignment/screens/onBoarding5.dart';
import 'package:todo_sapient_assignment/screens/onBoarding6.dart';
import 'package:todo_sapient_assignment/screens/onBoarding7.dart';
import 'package:todo_sapient_assignment/utils/sizeConfig.dart';
import 'package:todo_sapient_assignment/widgets/onboardingWidget.dart';

class Onboarding extends StatefulWidget {
  final FirebaseUser user;

  Onboarding({Key key, this.user}) : super(key: key);
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  ValueNotifier<double> notifier;
  ValueNotifier<ScrollDirection> directionNotifier;
  @override
  Widget build(BuildContext context) {
    print('user 1:${widget.user}');
    return EasyOnboarding(
      onStart: () {
        print("getting started ");
      },
      skipButtonColor: Colors.transparent,
      backButtonColor: Colors.blue[900],
      nextButtonColor: Colors.blue[900],
      backgroundColor: Colors.white,
      indicatorSelectedColor: Colors.blue[900],
      indicatorUnselectedColor: Colors.blueGrey,
      notifier: notifier,
      directionNotifier: directionNotifier,
      children: [
        Container(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40 * SizeConfig.heightMultiplier,
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
                          text: 'Welcome to ', style: TextStyle(fontSize: 50)),
                      new TextSpan(
                          text: 'Clear ',
                          style: new TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 50)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 3.5 * SizeConfig.heightMultiplier,
                ),
                Container(
                  child: Text(
                    'Tap or swipe to begin',
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        OnBoarding1(),
        OnBoarding2(),
        OnBoarding3(),
        OnBoarding4(),
        OnBoarding5(
          notifier: notifier,
          directionNotifier: directionNotifier,
        ),
        OnBoarding6(),
        OnBoarding7(
          user: widget.user,
        ),
      ],
    );
  }
}
