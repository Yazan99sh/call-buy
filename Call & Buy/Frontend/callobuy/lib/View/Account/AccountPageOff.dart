import 'package:callobuy/View/Account/Login_page.dart';
import 'package:callobuy/View/Settings/Formates.dart';
import 'package:callobuy/View/Account/SignUpPage.dart';
import 'package:callobuy/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
class AccountPageOff extends StatefulWidget {
  @override
  _AccountPageOffState createState() => _AccountPageOffState();
}

class _AccountPageOffState extends State<AccountPageOff> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(18))
        ),
        title: Text("مرحبا بك",style: TextStyle(
          fontFamily: ArabicFonts.Cairo,
          package: 'google_fonts_arabic',
        ),textScaleFactor: 1,),
        elevation: 0,
        centerTitle:true,
      ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
            SafeArea(
              top: true,
              child: Container(
                width: MediaQuery.of(context).copyWith().size.width/2.5,
                height:MediaQuery.of(context).copyWith().size.width/2.5,
                child:Image.asset("images/logo.png",color:fontColor(themeNotifier.getbackground())?(fontColor(themeNotifier.getbackground())?Colors.white:Colors.black):themeNotifier.getTheme(),
                ),
              ),
            ),
      Container(
       width: MediaQuery.of(context).copyWith().size.width*0.85,
        child: RaisedButton(
              onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder:(_)=>LoginPage()));
              },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child:Text("تسجيل الدخول",style: TextStyle(
                fontFamily: ArabicFonts.Cairo,
                package: 'google_fonts_arabic',
              color: fontColor(themeNotifier.getTheme())
                  ? Colors.white
                  : Colors.black,
            ),textScaleFactor: 1,),
            color: themeNotifier.getTheme(),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).copyWith().size.width*0.85,
          child: RaisedButton(
              onPressed:(){
                Navigator.push(context,MaterialPageRoute(builder:(_)=>SignUpPage()));
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child:Text("تسجيل الاشتراك",style: TextStyle(
                fontFamily: ArabicFonts.Cairo,
                package: 'google_fonts_arabic',
                color: fontColor(themeNotifier.getTheme())
                    ? Colors.white
                    : Colors.black,
              ),textScaleFactor: 1,),
              color:themeNotifier.getTheme(),
          ),
        ),
      ),
      ],
    ),
        ),
    );
  }
}
