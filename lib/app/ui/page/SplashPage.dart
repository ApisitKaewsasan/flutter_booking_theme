import 'dart:async';

import 'package:ds_book_app/app/ui/page/StartUpPage.dart';
import 'package:ds_book_app/config/Env.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_svg/svg.dart';

class SplashPage extends StatefulWidget {

  static const String PATH = '/';

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 2));
    animation =
        new CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => this.setState(() {}));
    animationController.forward();

    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.white,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Column(
                      children: [
                        Text("Dot Socket",style: GoogleFonts.kanit(fontSize: 16,fontWeight: FontWeight.w500),),
                        Text("Version 0.0.1",style: GoogleFonts.kanit(fontSize: 15,fontWeight: FontWeight.w500),)
                      ],
                    ))
              ],
            ),
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(
                  "assets/images/logo.svg",
                  width: animation.value * 180,
                  height: animation.value * 180,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  startTimer() async {
    var duration = new Duration(seconds: 3);
    return new Timer(duration, navigatorPage);
  }

  navigatorPage() {
     Navigator.pushAndRemoveUntil(context, PageTransition(type: PageTransitionType.fade, child:  StartUpPage()), (Route<dynamic> route) => false);
  }
}
