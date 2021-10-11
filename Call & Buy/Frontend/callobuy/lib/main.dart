import 'package:callobuy/Model/Home/HomeScreen.dart';
import 'package:callobuy/View/MyIntroPage.dart';
import 'package:callobuy/View/ThemeNotifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Model/PushNotification.dart';
import 'View/PageViews.dart';
import 'dart:core';
var themeNotifier;
int primary=5;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences;
  sharedPreferences = await SharedPreferences.getInstance();
  Color pr=Color(sharedPreferences.get("Primary")!=null ? sharedPreferences.get("Primary") : 0xff3f51b5);
  Color bg=Color(sharedPreferences.get("Background")!=null ? sharedPreferences.get("Background") : 0xff9fa8da);
  Color ic=Color(sharedPreferences.get("Icons")!=null ? sharedPreferences.get("Icons") : 0xffffffff);
  Color sd=Color(sharedPreferences.get("Shadow")!=null ? sharedPreferences.get("Shadow") : 0xff9fa8da);
  for (int i=0;i<_defaultPrimary.length;i++){
    if (_defaultPrimary[i].toString().length<34){
      if (_defaultPrimary[i].toString().substring(6,16)==pr.toString().substring(6,16)){
        primary=i;
        break;
      }
    }
    else
    if (_defaultPrimary[i].toString().substring(35,45)==pr.toString().substring(6,16)){
      primary=i;
      break;
    }
  }
  pr=_defaultPrimary[primary];
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(ChangeNotifierProvider<ThemeNotifier>(
        create: (BuildContext context) => ThemeNotifier(pr,bg,ic,sd),child: new MyApp()));
  });
  //BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PushNotificationsManager push = PushNotificationsManager();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // // Start the Pushy service
    push.init();
  }
  @override
  Widget build(BuildContext context) {
    themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        splashColor: themeNotifier.getplaceHolderColor(),
        primarySwatch:themeNotifier.getTheme()==Colors.black ? Colors.grey : themeNotifier.getTheme(),
        primaryColor:themeNotifier.getTheme(),
        cardColor: themeNotifier.getTheme(),
        scaffoldBackgroundColor: themeNotifier.getbackground(),
        cardTheme:CardTheme(color:themeNotifier.getbackground(),),
        fontFamily:ArabicFonts.Cairo,
      ),
      home:Scaffold(body:MyIntroPage()),
//      home:Scaffold(body:background()),
    );
  }
}

  List<Color> _defaultPrimary = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.green,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.black
  ];
This "Headless Task" is run when app is terminated.
void backgroundFetchHeadlessTask(String taskId) async {
  print('[BackgroundFetch] Headless event received.');
  showNotification();
  showUpdetNotification();
  BackgroundFetch.finish(taskId);
}


