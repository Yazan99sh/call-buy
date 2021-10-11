import 'package:callobuy/View/Settings/Formates.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:url_launcher/url_launcher.dart' as url;
import 'package:url_launcher/url_launcher.dart';

import '../../main.dart';
class AboutDev extends StatefulWidget {
  @override
  _AboutDevState createState() => _AboutDevState();
}

class _AboutDevState extends State<AboutDev> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:themeNotifier.getbackground(),
        elevation: 0,
        iconTheme: IconThemeData(
          color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(height: MediaQuery.of(context).size.height*0.25,),
              Text("Shekh Express",style: TextStyle(
                color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black,
                fontFamily: ArabicFonts.Cairo,
                package: 'google_fonts_arabic',
                fontSize:25,
              ),textScaleFactor: 1,),
              Text("Version 1.0.1+2",style: TextStyle(
                color:fontColor(themeNotifier.getbackground())?Colors.white54:Colors.black54,
                fontFamily: ArabicFonts.Cairo,
                package: 'google_fonts_arabic',
                fontSize:16,
              ),textScaleFactor: 1,),
              Image.asset('images/logo.png',width: 150,height: 150,color: themeNotifier.getTheme(),),
              Text("© 2019-2020 YazanShekhMohammed",style: TextStyle(
                color:fontColor(themeNotifier.getbackground())?Colors.white54:Colors.black54,
                fontFamily: ArabicFonts.Cairo,
                package: 'google_fonts_arabic',
                fontSize:16,
              ),textScaleFactor: 1,),
             Padding(
               padding: const EdgeInsets.all(25.0),
               child: InkWell(
                 onTap: (){
                   var Url = "https://yazanshmo.000webhostapp.com/";
                   canLaunch(Url)!=null
                       ? url.launch(Url)
                       :  Directionality(
                     textDirection: TextDirection.rtl,
                     child: Flushbar(
                       borderRadius:14,
                       backgroundColor: Colors.red,
                       duration: Duration(seconds: 5),
                       messageText:Text('هناك مشكلة ما',textScaleFactor: 1,style: TextStyle(
                         fontFamily: ArabicFonts.Cairo,
                         package: 'google_fonts_arabic',
                         color: Colors.white,
                       ),textDirection: TextDirection.rtl,),
                     )..show(context),
                   );
                 },
                 splashColor:themeNotifier.getTheme(),
                 highlightColor:themeNotifier.getTheme(),
                 borderRadius: BorderRadius.circular(10),
                 child: Container(
                   width: 100,
                   height: 40,
                   child: Center(
                     child:Text("زيارة الموقع",style: TextStyle(
                       color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black,
                       fontFamily: ArabicFonts.Cairo,
                       package: 'google_fonts_arabic',
                       fontSize:16,
                     ),textScaleFactor: 1,),
                   ),
                 ),
               ),
             )
            ],
          ),
        ),
      ),
    );
  }
}

