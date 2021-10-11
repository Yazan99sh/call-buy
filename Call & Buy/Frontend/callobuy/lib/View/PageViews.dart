import 'dart:convert';
import 'package:callobuy/View/Account/AccountPageOff.dart';
import 'package:callobuy/View/Account/AccountPageOn.dart';
import 'package:callobuy/View/Categories/CategoryPage.dart';
import 'package:callobuy/View/Home/HomeScreen.dart';
import 'package:callobuy/View/MyPostPage.dart';
import 'package:callobuy/View/PostItem.dart';
import 'package:callobuy/View/testnavy.dart';
import 'package:callobuy/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'Settings/Formates.dart';
import 'package:url_launcher/url_launcher.dart' as url;

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    new FlutterLocalNotificationsPlugin();

void showUpdetNotification() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var general = sharedPreferences.getBool('notifications');
  var update = sharedPreferences.getBool('updateNotifications');
  if (general == null) general = true;
  if (update == null) update = true;
  if (general && update) {
    http.Response response = await http.get(
        "https://callandbuy.000webhostapp.com/CallAndBuy/CheckForUpdate.php");
    // ignore: unrelated_type_equality_checks
    if (response.statusCode == 200 || response.body != false) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse.length > 0) {
        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        String version = packageInfo.version;
        if (version != '${jsonResponse['version']}')
          await _UpdateNotificationd('تحديث جديد', jsonResponse['Description'],
              jsonResponse['updatetlink']);
      }
    }
  }
}

Future<void> _UpdateNotificationd(var title, var subTitle, var link) async {
  var androidPlatformNotificationChannel = new AndroidNotificationDetails(
    'Channel ID',
    'Channel Name',
    'Channel describtion',
    importance: Importance.Max,
    priority: Priority.High,
    ticker: 'Test ticker',
  );
  var iosPlatformNotificationChannel = new IOSNotificationDetails();
  var de = new NotificationDetails(
      androidPlatformNotificationChannel, iosPlatformNotificationChannel);
  await flutterLocalNotificationsPlugin.show(0, '$title', '$subTitle', de,
      payload: '$link');
}

void showNotification() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var general = sharedPreferences.getBool('notifications');
  var ads = sharedPreferences.getBool('adsNotifications');
  if (general == null) general = true;
  if (ads == null) ads = true;
  if (general && ads) {
    http.Response response = await http.get(
        'https://callandbuy.000webhostapp.com/CallAndBuy/getNotification.php');
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse.length > 0) {
        for (int i = 0; i < jsonResponse.length; i++)
          await _demoNotificationd(jsonResponse[i]['Nid'],
              jsonResponse[i]['title'], jsonResponse[i]['subtitle']);
      }
    }
  }
}

Future<void> _demoNotificationd(var nid, var title, var subTitle) async {
  var androidPlatformNotificationChannel = new AndroidNotificationDetails(
      'Channel ID', 'Channel Name', 'Channel describtion',
      importance: Importance.Max,
      priority: Priority.High,
      ticker: 'Test ticker');
  var iosPlatformNotificationChannel = new IOSNotificationDetails();
  var de = new NotificationDetails(
      androidPlatformNotificationChannel, iosPlatformNotificationChannel);
  await flutterLocalNotificationsPlugin.show(
      int.parse(nid), '$title', '$subTitle', de);
}

class PageViews extends StatefulWidget {
  @override
  _PageViewsState createState() => _PageViewsState();
}

class _PageViewsState extends State<PageViews> {
  var initializationSettingsAndroid;
  var initializationSettingsIos;
  var initializationSettings;
  SharedPreferences sharedPreferences;
  var currentIndex = 4;
  var currentPage = 5;
  bool f = true;
  var log = true;
  var status = true;
  PageController _pageController = PageController();

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      setState(() {
        log = false;
        currentPage = 3;
      });
    } else {
      setState(() {
        log = true;
        currentPage = 5;
      });
    }
  }

  checkStatus() async {
    try{
      var st = await http
          .get('https://callandbuy.000webhostapp.com/CallAndBuy/CreatorMode.php');
      var js = await json.decode(st.body);
      if (js['Status'].toString() == 'true' && status == false) {
        if (this.mounted) {
          setState(() {
            status = true;
          });
        }
      } else if (js['Status'].toString() == 'false') {
        if (this.mounted) {
          setState(() {
            status = false;
          });
        }
      }
    }catch(error){

    }

  }

  @override
  void initState() {
    checkLoginStatus();
    super.initState();
   // initPlatformState();
    initializationSettingsAndroid =
        new AndroidInitializationSettings('newapplogo');
    initializationSettingsIos = new IOSInitializationSettings();
    initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIos);
    _pageController = PageController(initialPage: currentPage);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification([String payload]) async {
    if (payload != null) {
      print(payload);
      url.launch(payload);
      //Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
    onSelectNotification();
  }

  int _status = 0;
  List<DateTime> _events = [];

// Platform messages are asynchronous, so we initialize in an async method.
//   Future<void> initPlatformState() async {
//     // Configure BackgroundFetch.
//     BackgroundFetch.configure(
//         BackgroundFetchConfig(
//             minimumFetchInterval: 90,
//             stopOnTerminate: false,
//             enableHeadless: true,
//             requiresBatteryNotLow: false,
//             requiresCharging: false,
//             requiresStorageNotLow: false,
//             requiresDeviceIdle: false,
//             requiredNetworkType: NetworkType.NONE), (String taskId) async {
//       // This is the fetch-event callback.
//       print("[BackgroundFetch] Event received $taskId");
//       setState(() {
//         _events.insert(0, new DateTime.now());
//       });
//       showNotification();
//       showUpdetNotification();
//       // IMPORTANT:  You must signal completion of your task or the OS can punish your app
//       // for taking too long in the background.
//       BackgroundFetch.finish(taskId);
//     }).then((int status) {
//       print('[BackgroundFetch] configure success: $status');
//       setState(() {
//         _status = status;
//       });
//     }).catchError((e) {
//       print('[BackgroundFetch] configure ERROR: $e');
//       setState(() {
//         _status = e;
//       });
//     });
//     int status = await BackgroundFetch.status;
//     setState(() {
//       _status = status;
//     });
//
//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return;
//   }

  @override
  Widget build(BuildContext context) {
    checkStatus();
    List<Widget> Pages;
    List<BottomNavyBarItems> Item;
    if (log && log != null) {
      setState(() {
        Pages = [
          AccountPageOn(),
          CategoryPage(),
          PostItem(),
          MyPostPage(),
          HomeScreen(),
        ];
        Item = [
          BottomNavyBarItems(
            icon: Icon(
              Icons.person,
              color: themeNotifier.getIcon(),
            ),
            title: Text(
              'الحساب',
              style: TextStyle(
                fontFamily: ArabicFonts.Cairo,
                package: 'google_fonts_arabic',
                color: themeNotifier.getIcon(),
              ),
              textScaleFactor: 1,
            ),
            activeColor: themeNotifier.getIcon(),
          ),
          BottomNavyBarItems(
            icon: Icon(Icons.category, color: themeNotifier.getIcon()),
            title: Text(
              'الفئات',
              style: TextStyle(
                  fontFamily: ArabicFonts.Cairo,
                  package: 'google_fonts_arabic',
                  color: themeNotifier.getIcon()),
              textScaleFactor: 1,
            ),
            activeColor: Colors.white,
          ),
          BottomNavyBarItems(
              icon: Icon(Icons.add_box, color: themeNotifier.getIcon()),
              title: Text(
                'النشر',
                style: TextStyle(
                  fontFamily: ArabicFonts.Cairo,
                  package: 'google_fonts_arabic',
                  color: themeNotifier.getIcon(),
                ),
                textScaleFactor: 1,
              ),
              activeColor: themeNotifier.getIcon(),
              inactiveColor: log == true ? Colors.white : Colors.white30),
          BottomNavyBarItems(
              icon: Icon(Icons.library_books, color: themeNotifier.getIcon()),
              title: Text(
                'منشوراتي',
                style: TextStyle(
                    fontFamily: ArabicFonts.Cairo,
                    package: 'google_fonts_arabic',
                    color: themeNotifier.getIcon()),
                textScaleFactor: 1,
              ),
              activeColor: themeNotifier.getIcon(),
              inactiveColor: log == true ? Colors.white : Colors.white30),
          BottomNavyBarItems(
            icon: Icon(Icons.home, color: themeNotifier.getIcon()),
            title: Text(
              'الرئيسية',
              style: TextStyle(
                fontFamily: ArabicFonts.Cairo,
                package: 'google_fonts_arabic',
                color: themeNotifier.getIcon(),
              ),
              textScaleFactor: 1,
            ),
            activeColor: themeNotifier.getIcon(),
          )
        ];
      });
    } else {
      setState(() {
        Pages = [
          AccountPageOff(),
          CategoryPage(),
          HomeScreen(),
        ];
        Item = [
          BottomNavyBarItems(
            icon: Icon(Icons.person, color: themeNotifier.getIcon()),
            title: Text(
              'الحساب',
              style: TextStyle(
                  fontFamily: ArabicFonts.Cairo,
                  package: 'google_fonts_arabic',
                  color: themeNotifier.getIcon()),
              textScaleFactor: 1,
            ),
            activeColor: themeNotifier.getIcon(),
          ),
          BottomNavyBarItems(
            icon: Icon(Icons.category, color: themeNotifier.getIcon()),
            title: Text(
              'الفئات',
              style: TextStyle(
                  fontFamily: ArabicFonts.Cairo,
                  package: 'google_fonts_arabic',
                  color: themeNotifier.getIcon()),
              textScaleFactor: 1,
            ),
            activeColor: themeNotifier.getIcon(),
          ),
          BottomNavyBarItems(
              icon: Icon(Icons.home, color: themeNotifier.getIcon()),
              title: Text(
                'الرئيسية',
                style: TextStyle(
                    fontFamily: ArabicFonts.Cairo,
                    package: 'google_fonts_arabic',
                    color: themeNotifier.getIcon()),
                textScaleFactor: 1,
              ),
              activeColor: themeNotifier.getIcon()),
        ];
      });
    }
    if (status) {
      return Scaffold(
        body: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
                checkLoginStatus();
              });
            },
            children: Pages,
          ),
        ),
        bottomNavigationBar: BottomNavyBars(
          animationDuration: Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
          selectedIndex: currentIndex,
          showElevation: true,
          onItemSelected: (index) {
            setState(() => currentIndex = index);
            _pageController.animateToPage(index,
                duration: Duration(milliseconds: 700),
                curve: Curves.fastOutSlowIn);
//    _pageController.jumpToPage(index);
          },
          backgroundColor: themeNotifier.getTheme(),
          items: Item,
        ),
      );
    } else
      return Scaffold(
        backgroundColor: themeNotifier.getTheme(),
        body: Center(
          child: Text(
            'مسكريييين عمي',
            textScaleFactor: 1,
            style: TextStyle(
              color: fontColor(themeNotifier.getbackground())
                  ? Colors.white
                  : Colors.black,
              fontFamily: ArabicFonts.Cairo,
              package: 'google_fonts_arabic',
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
  }
}
