import 'package:callobuy/View/PageViews.dart';
import 'package:callobuy/View/Settings/Formates.dart';
import 'package:callobuy/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_splash/flutter_splash.dart';
class MyIntroPage extends StatefulWidget {
  @override
  _MyIntroPageState createState() => _MyIntroPageState();
}

class _MyIntroPageState extends State<MyIntroPage> {
  @override
  Widget build(BuildContext context) {
    return Splash(
        seconds: 5,
        navigateAfterSeconds: PageViews(),
//        title: new Text('Welcome In SplashScreen',
//          style: new TextStyle(
//              fontWeight: FontWeight.bold,
//              fontSize: 20.0
//          ),),
        image:  Image.asset('images/logo.png',color: fontColor(themeNotifier.getTheme())?Colors.white:Colors.black,width: 200,),
        backgroundColor:themeNotifier.getTheme(),
        loadingText: Text('Powered By Yazan',textScaleFactor: 1,style: TextStyle(
color:fontColor(themeNotifier.getTheme())?Colors.white:Colors.black,
          fontSize: 20,
        ),),
        styleTextUnderTheLoader: new TextStyle(),
        photoSize:MediaQuery.of(context).size.height/4,
        loaderColor:fontColor(themeNotifier.getTheme())?Colors.white:Colors.black,
    );
  }
}
