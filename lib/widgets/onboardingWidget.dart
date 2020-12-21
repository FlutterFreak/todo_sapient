library easy_onboarding;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:todo_sapient_assignment/utils/sizeConfig.dart';

class EasyOnboarding extends StatefulWidget {
  final Color backgroundColor;
  final Color bottomBackgroundColor;
  final Color indicatorSelectedColor;
  final Color indicatorUnselectedColor;
  final Color startButtonColor;
  final Color backButtonColor;
  final Icon backButtonIcon;
  final Color nextButtonColor;
  final Icon nextButtonIcon;
  final Function onStart;
  final Text startButtonText;
  final List<Widget> children;
  final Color skipButtonColor;
  final Text skipButtonText;
  final ValueNotifier<double> notifier;
  final ValueNotifier<ScrollDirection> directionNotifier;

  EasyOnboarding({
    this.backgroundColor = Colors.white,
    this.bottomBackgroundColor = Colors.white,
    this.indicatorSelectedColor = Colors.red,
    this.indicatorUnselectedColor = Colors.grey,
    this.startButtonColor = Colors.red,
    @required this.startButtonText,
    this.backButtonColor = Colors.red,
    @required this.backButtonIcon,
    this.nextButtonColor = Colors.red,
    @required this.nextButtonIcon,
    @required this.onStart,
    @required this.children,
    this.skipButtonColor,
    @required this.skipButtonText,
    this.notifier,
    this.directionNotifier,
  });
  @override
  _EasyOnboardingState createState() => _EasyOnboardingState();
}

class _EasyOnboardingState extends State<EasyOnboarding>
    with TickerProviderStateMixin {
  PageController _pageController;

  Widget pageIndexIndicator(bool isCurrentPage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      height: isCurrentPage ? 15.0 : 10.0,
      width: isCurrentPage ? 15.0 : 10.0,
      decoration: BoxDecoration(
        color: isCurrentPage
            ? widget.indicatorSelectedColor
            : widget.indicatorUnselectedColor,
        shape: BoxShape.circle,
      ),
    );
  }

  AnimationController _imageController;
  Animatable<Offset> _animation;
  AnimationController _controller;
  var _imageAnimation;
  int _currentIndex = 0;
  bool animateImage = false;
  var initialPosition;
  var distance;
  int _previousPage;
  ScrollDirection direction;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _imageController = AnimationController(
      duration: const Duration(seconds: 1),
      reverseDuration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _pageController = new PageController(initialPage: 0)
      ..addListener(_onScroll);
    _animation = Tween<Offset>(begin: Offset(0.0, 0.05), end: Offset(-2, 0))
        .chain(CurveTween(curve: Curves.ease));
  }

  void _onScroll() {
    print(
        'page scroll from 0 to 1 : ${_pageController.page.toStringAsFixed(1)}');
    widget.notifier?.value = _pageController.page;
    widget.directionNotifier?.value =
        _pageController.position.userScrollDirection;
    print('reached page  : ${_pageController.page}');

    direction = _pageController.position.userScrollDirection;
    print('scroll Direction:${_pageController.position.userScrollDirection}');
    print('currentIndex:$_currentIndex');
    if (direction == ScrollDirection.reverse &&
        _pageController.page.toStringAsFixed(1) == "0.3") {
      _controller.forward();
    } else if (direction == ScrollDirection.forward &&
        _pageController.page.toStringAsFixed(1) == "0.9") {
      _controller.reverse();
    } else if (direction == ScrollDirection.reverse &&
        _pageController.page.toStringAsFixed(1) == "1.1") {
      _imageController.forward();
    } else if (direction == ScrollDirection.reverse &&
        _pageController.page.toStringAsFixed(1) == "1.1") {
      _controller.forward();
    } else if (direction == ScrollDirection.forward &&
        _pageController.page.toStringAsFixed(1) == "1.9") {
      _imageController.reverse();
    } else if (direction == ScrollDirection.reverse &&
        _pageController.page.toStringAsFixed(1) == '5.1') {
      _controller.reverse();
    } else if (direction == ScrollDirection.forward &&
        _pageController.page.toStringAsFixed(1) == '5.9') {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            PageView(
              controller: _pageController,
              children: widget.children,
              onPageChanged: (val) {
                print('index:$val');
                setState(() {
                  _currentIndex = val;
                });
              },
            ),
            _currentIndex != 0
                ? Align(
                    alignment: Alignment.bottomCenter,
                    // left: 150,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: Offset(0.0, 0.95),
                        end: Offset(0.0, 0.35),
                      ).animate(CurvedAnimation(
                        parent: _controller,
                        curve: Curves.easeIn,
                      )),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(
                          horizontal: 3.5 * SizeConfig.heightMultiplier,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (int i = 0; i < 8; i++)
                                  _currentIndex == i
                                      ? pageIndexIndicator(true)
                                      : pageIndexIndicator(false)
                              ],
                            ),
                            SizedBox(
                              height: 3.5 * SizeConfig.heightMultiplier,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 35),
                              child: SlideTransition(
                                  position: _imageController.drive(_animation),
                                  child: Image.asset("assets/Screenshot1.png")),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
