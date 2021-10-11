import 'package:callobuy/View/Settings/Formates.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../PageViews.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  var alerts = true;

  var update = true;
  var ads = true;
  Color switchColor;

  @override
  Widget build(BuildContext context) {
    if (alerts) {
      switchColor = fontColor(themeNotifier.getbackground())
          ? Colors.white
          : Colors.black;
    } else
      switchColor = fontColor(themeNotifier.getbackground())
          ? Colors.white54
          : Colors.black54;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
          color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black,
        ),
        backgroundColor: themeNotifier.getbackground(),
        centerTitle: true,
        title: Text(
          "الإشعارات",
          style: TextStyle(
            fontFamily: ArabicFonts.Cairo,
            package: 'google_fonts_arabic',
            color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black,
          ),
          textScaleFactor: 1,
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: <Widget>[
            Card(
              color: themeNotifier.getbackground(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: 5,
              child: SwitchListTile(
                title: Text(
                  "السماح بالإشعارات ",
                  style: TextStyle(
                    fontFamily: ArabicFonts.Cairo,
                    package: 'google_fonts_arabic',
                    fontWeight: FontWeight.bold,
                    color: fontColor(themeNotifier.getbackground())
                        ? Colors.white
                        : Colors.black,
                  ),
                  textScaleFactor: 1,
                ),
                value: alerts,
                onChanged: (bool value) async {
                  sharedPreferences = await SharedPreferences.getInstance();
                  setState(() {
                    alerts = value;
                    sharedPreferences.setBool('notifications', alerts);
                    if (alerts==true){
                      ads=true;
                      update=true;
                    }
                  });
                },
                secondary: Icon(
                  Icons.notifications_none,
                  color: fontColor(themeNotifier.getbackground())
                      ? Colors.white
                      : Colors.black54,
                ),
                activeColor: themeNotifier.getTheme(),
              ),
            ),
            SwitchListTile(
              title: Text(
                "تنبيهات الإعلانات",
                style: TextStyle(
                  fontFamily: ArabicFonts.Cairo,
                  package: 'google_fonts_arabic',
                  fontWeight: FontWeight.bold,
                  color: switchColor,
                ),
                textScaleFactor: 1,
              ),
              value: ads,
              onChanged: alerts == true
                  ? (bool value) async {
                      sharedPreferences = await SharedPreferences.getInstance();
                      setState(() {
                        ads = value;
                        sharedPreferences.setBool('adsNotifications', ads);
                      });
                    }
                  : null,
              secondary: Icon(
                Icons.new_releases,
                color: fontColor(themeNotifier.getbackground())
                    ? Colors.white
                    : Colors.black54,
              ),
              activeColor: themeNotifier.getTheme(),
            ),
            Divider(
              color: switchColor,
            ),
            SwitchListTile(
              title: Text(
                "تنبيهات التحديثات",
                style: TextStyle(
                  fontFamily: ArabicFonts.Cairo,
                  package: 'google_fonts_arabic',
                  fontWeight: FontWeight.bold,
                  color: switchColor,
                ),
                textScaleFactor: 1,
              ),
              value: update,
              onChanged: alerts == true
                  ? (bool value) async {
                      sharedPreferences = await SharedPreferences.getInstance();
                      setState(() {
                        update = value;
                        sharedPreferences.setBool('updateNotifications', update);
                      });
                    }
                  : null,
              secondary: Icon(
                Icons.update,
                color: fontColor(themeNotifier.getbackground())
                    ? Colors.white
                    : Colors.black54,
              ),
              activeColor: themeNotifier.getTheme(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    NotificationStatus();
  }

  SharedPreferences sharedPreferences;

  NotificationStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (this.mounted)
      setState(() {
        alerts = sharedPreferences.getBool('notifications');
        ads = sharedPreferences.getBool('adsNotifications');
        update = sharedPreferences.getBool('updateNotifications');
        if (alerts == null) {
          alerts = true;
          ads = true;
          update = true;
        }
        if (alerts==false){
          ads=false;
          update=false;
        }
        if (ads==null)ads=true;
        if(update==null)update=true;
      });
  }
}
