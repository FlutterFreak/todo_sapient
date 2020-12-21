import 'package:flutter/material.dart';
import 'package:todo_sapient_assignment/utils/sizeConfig.dart';

class OnBoarding6 extends StatefulWidget {
  @override
  _OnBoarding6State createState() => _OnBoarding6State();
}

class _OnBoarding6State extends State<OnBoarding6> {
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
                    height: 15 * SizeConfig.heightMultiplier,
                  ),
                  Image.asset("assets/Screenshot3.png"),
                  SizedBox(
                    height: 3 * SizeConfig.heightMultiplier,
                  ),
                  new RichText(
                    textAlign: TextAlign.center,
                    text: new TextSpan(
                      // Note: Styles for TextSpans must be explicitly defined.
                      // Child text spans will inherit styles from parent
                      style: new TextStyle(
                        fontSize: 35.0,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        new TextSpan(text: 'Use '),
                        new TextSpan(
                            text: 'iCloud ',
                            style: new TextStyle(fontWeight: FontWeight.bold)),
                        new TextSpan(text: '?'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 3 * SizeConfig.heightMultiplier,
                  ),
                  Text(
                    'Storing your list in iCloud allows you to keep your data in sync across, iphone, ipad and Mac.',
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 3 * SizeConfig.heightMultiplier,
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
                            onPressed: null,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Not Now',
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
                            onPressed: null,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Use iCloud',
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
