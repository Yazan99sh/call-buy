import 'dart:convert';
import 'package:callobuy/Model/Home/HomeScreen.dart';
import 'package:callobuy/View/Settings/AboutDev.dart';
import 'package:callobuy/View/Settings/Formates.dart';
import 'package:callobuy/View/Settings/Notifications.dart';
import 'package:callobuy/main.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart' as url;
import 'package:package_info/package_info.dart';
class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  var address= "تحديد منطقتك المفضلة";
  SharedPreferences _sharedPreferences;
  Future shared()async{
    _sharedPreferences=await SharedPreferences.getInstance();
    if (this.mounted)
      setState(() {
        address=_sharedPreferences.get('address');
        if (address=='' || address==null)address="تحديد منطقتك المفضلة";
      });
  }

  @override
  void initState() {
    super.initState();
    shared();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black,
        ),
        backgroundColor: themeNotifier.getbackground(),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "الإعدادات",
          style: TextStyle(
            fontFamily: ArabicFonts.Cairo,
            package: 'google_fonts_arabic',
            color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black,
          ),
          textScaleFactor: 1,
        ),
      ),
      body: Theme(
        data: Theme.of(context)
            .copyWith(splashColor: themeNotifier.getplaceHolderColor()),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView(
            children: <Widget>[
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: (){
                    checkForUpdate();
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.update,
                      color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black54,
                    ),
                    title: Text(
                      "التحقق من التحديثات",
                      style: TextStyle(
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                        fontWeight: FontWeight.bold,
                        color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black,
                      ),
                      textScaleFactor: 1,
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onLongPress: (){
                  showDialog(context: context,builder: (_){
                    return Directionality(
                      textDirection: TextDirection.rtl,
                      child: AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        backgroundColor: Colors.red,
                        content:Text(
                         "هل أنت متأكد من إعادة تهيئة ضبط هذا الخيار",
                          style: TextStyle(
                            fontFamily: ArabicFonts.Cairo,
                            package: 'google_fonts_arabic',
                            fontWeight: FontWeight.bold,
                            color:Colors.white,
                          ),
                          textScaleFactor: 1,
                        ),
                        actions: <Widget>[
                          FlatButton(onPressed: (){
                            setState(() {
                              address="تحديد منطقتك المفضلة";
                              _sharedPreferences.setString('address','');
                            });
                            Navigator.of(context).pop();
                          }, child:Text(
                            "متأكد",
                            style: TextStyle(
                              fontFamily: ArabicFonts.Cairo,
                              package: 'google_fonts_arabic',
                              fontWeight: FontWeight.bold,
                              color:Colors.white,
                            ),
                            textScaleFactor: 1,
                          ),)
                        ],
                      ),
                    );
                  });
                  },
                  onTap: (){
                    showDialog(context: context,builder: (_){
                      return Directionality(
                        textDirection: TextDirection.rtl,
                        child: AlertDialog(
                          title: Center(
                            child: Text(
                              "اختر منطقتك المفضلة",
                              style: TextStyle(
                                fontFamily: ArabicFonts.Cairo,
                                package: 'google_fonts_arabic',
                                fontWeight: FontWeight.bold,
                                color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black,
                              ),
                              textScaleFactor: 1,
                            ),
                          ),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          backgroundColor: themeNotifier.getbackground(),
                          content:Container(
                            width:MediaQuery.of(context).size.width*0.65,
                            height:MediaQuery.of(context).size.height*0.35,
                            child:FutureBuilder(
                                future: getPosts(),
                                builder: (_,snapshot){
                                  if (snapshot.connectionState==ConnectionState.waiting){
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  else if (snapshot.hasError){
                                    return Center(
                                      child:Text(
                                        "عاود المحاولة لاحقا",
                                        style: TextStyle(
                                          fontFamily: ArabicFonts.Cairo,
                                          package: 'google_fonts_arabic',
                                          fontWeight: FontWeight.bold,
                                          color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black,
                                        ),
                                        textScaleFactor: 1,
                                      ),
                                    );
                                  }
                                  else {
                                    List data = snapshot.data;
                                    if (data.isNotEmpty){
                                      return ListView.builder(padding: EdgeInsets.zero,itemCount: data.length,itemBuilder:(_,index){
                                       return Center(
                                         child: ListTile(
                                           onTap: (){
                                             setState(() {
                                               address =' مدينتك المفضلة ${data[index]['address']}';
                                               _sharedPreferences.setString('address',address);
                                             });
                                             Navigator.of(context).pop();
                                           },
                                           title: Text(
                                             "${data[index]['address']}",
                                             style: TextStyle(
                                               fontFamily: ArabicFonts.Cairo,
                                               package: 'google_fonts_arabic',
                                               fontWeight: FontWeight.bold,
                                               color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black,
                                             ),
                                             textScaleFactor: 1,
                                           ),
                                         ),
                                       );
                                      });
                                    }
                                    else return Center(child: Text(
                                      "لايوجد مناطق متوافرة حاليا",
                                      style: TextStyle(
                                        fontFamily: ArabicFonts.Cairo,
                                        package: 'google_fonts_arabic',
                                        fontWeight: FontWeight.bold,
                                        color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black,
                                      ),
                                      textScaleFactor: 1,
                                    ),);
                                  }
                                })
                          ),
                        ),
                      );
                    });
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.gps_fixed,
                      color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black54,
                    ),
                    title: Text(
                      "$address",
                      style: TextStyle(
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                        fontWeight: FontWeight.bold,
                        color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black,
                      ),
                      textScaleFactor: 1,
                    ),
                    trailing:Container(
                      height: MediaQuery.of(context).size.height/25,
                      child: CircleAvatar(
                        child:ClipRRect(
                          child: Image.asset('images/syria.png',fit: BoxFit.cover,),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: InkWell(
                  onLongPress: (){
                    showDialog(context: context,builder: (_){
                      return Directionality(
                        textDirection: TextDirection.rtl,
                        child: AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          backgroundColor: Colors.red,
                          content:Text(
                            "هل أنت متأكد من إعادة تهيئة ضبط هذا الخيار",
                            style: TextStyle(
                              fontFamily: ArabicFonts.Cairo,
                              package: 'google_fonts_arabic',
                              fontWeight: FontWeight.bold,
                              color:Colors.white,
                            ),
                            textScaleFactor: 1,
                          ),
                          actions: <Widget>[
                            FlatButton(onPressed: (){
                              setState(() {
                                sharedPreferences.setInt(
                                    "Primary",null);
                                sharedPreferences.setInt(
                                    "Background",
                                    null);
                                sharedPreferences.setInt(
                                    "Icons",
                                    null);
                                sharedPreferences.setInt(
                                    "Shadow",
                                    null);
                                themeNotifier.setTheme(Colors.indigo);
                                themeNotifier.setbackground(Color(0xffffffff));
                                themeNotifier.setPlaceHolderColor(Color(0xff9fa8da));
                                themeNotifier.setIcon(Color(0xffffffff));
                              });
                              Navigator.of(context).pop();
                            }, child:Text(
                              "متأكد",
                              style: TextStyle(
                                fontFamily: ArabicFonts.Cairo,
                                package: 'google_fonts_arabic',
                                fontWeight: FontWeight.bold,
                                color:Colors.white,
                              ),
                              textScaleFactor: 1,
                            ),)
                          ],
                        ),
                      );
                    });
                  },
                  onTap: () {
                    Navigator.push(context,MaterialPageRoute(builder: (_){
                      return Format();
                    }));
                  },
                  borderRadius: BorderRadius.circular(14),
                  child: ListTile(
                    leading: Icon(
                      Icons.color_lens,
                      color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black54,
                    ),
                    title: Text(
                      "التنسيقات",
                      style: TextStyle(
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                        fontWeight: FontWeight.bold,
                        color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black,
                      ),
                      textScaleFactor: 1,
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () {
                    Navigator.push(context,MaterialPageRoute(builder: (_){
                      return Notifications();
                    }));
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.notifications,
                      color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black54,
                    ),
                    title: Text(
                      "الإشعارات",
                      style: TextStyle(
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                        fontWeight: FontWeight.bold,
                        color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black,
                      ),textScaleFactor: 1,
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: InkWell(
                  onTap: () {
                    about();
                  },
                  borderRadius: BorderRadius.circular(14),
                  child: ListTile(
                    leading: Icon(
                      Icons.block,
                      color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black54,
                    ),
                    title: Text(
                      "شروط",
                      style: TextStyle(
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                        fontWeight: FontWeight.bold,
                        color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black,
                      ),
                      textScaleFactor: 1,
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,MaterialPageRoute(builder: (_){
                      return AboutDev();
                    }));
                  },
                  borderRadius: BorderRadius.circular(14),

                  child: ListTile(
                    leading: Icon(
                      Icons.info,
                      color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black54,
                    ),
                    title: Text(
                      "حول المطور",
                      style: TextStyle(
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                        fontWeight: FontWeight.bold,
                        color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black,
                      ),
                      textScaleFactor: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  checkForUpdate() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    var response = await http.post("https://callandbuy.000webhostapp.com/CallAndBuy/CheckForUpdate.php");
    var jsonResponse=await json.decode(response.body);
    if (jsonResponse!=false){
      showDialog(context:context,builder: (context){
        if (version!=jsonResponse['version'])
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            backgroundColor:themeNotifier.getbackground(),
            title: Text('هناك تحديث متوافر',textScaleFactor: 1,style: TextStyle(
              fontFamily: ArabicFonts.Cairo,
              package: 'google_fonts_arabic',
              color: fontColor(themeNotifier.getbackground())==true?Colors.white:Colors.black,
            ),),
            content: Text('${jsonResponse['Description']}',textScaleFactor:1,style: TextStyle(
              fontFamily: ArabicFonts.Cairo,
              package: 'google_fonts_arabic',
              color: fontColor(themeNotifier.getbackground())==true?Colors.white:Colors.black,
            ),),
            actions: <Widget>[
              Padding(
                padding:  EdgeInsets.only(left:16),
                child: InkWell(
                  onTap: (){
                    url.launch(jsonResponse['updatetlink']);
                    Navigator.of(context).pop();
                  },
                  borderRadius: BorderRadius.circular(14),
                  splashColor: themeNotifier.getplaceHolderColor(),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text('تحديث',textScaleFactor: 1,style: TextStyle(
                      fontFamily: ArabicFonts.Cairo,
                      package: 'google_fonts_arabic',
                      color: fontColor(themeNotifier.getbackground())==true?Colors.white:Colors.black,
                    ),),
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.of(context).pop();
                },
                borderRadius: BorderRadius.circular(14),
                splashColor: themeNotifier.getplaceHolderColor(),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('إغلاق',textScaleFactor: 1,style: TextStyle(
                    fontFamily: ArabicFonts.Cairo,
                    package: 'google_fonts_arabic',
                    color: fontColor(themeNotifier.getbackground())==true?Colors.white:Colors.black,
                  ),),
                ),
              ),
            ],
          ),
        );
        else return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            backgroundColor:themeNotifier.getbackground(),
            content: Text('لقد حصلت على الإصدار الأخير مسبقا',textScaleFactor:1,style: TextStyle(
              fontFamily: ArabicFonts.Cairo,
              package: 'google_fonts_arabic',
              color: fontColor(themeNotifier.getbackground())==true?Colors.white:Colors.black,
            ),),
            actions: <Widget>[
              InkWell(
                onTap: (){
                  Navigator.of(context).pop();
                },
                borderRadius: BorderRadius.circular(14),
                splashColor: themeNotifier.getplaceHolderColor(),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('إغلاق',textScaleFactor: 1,style: TextStyle(
                    fontFamily: ArabicFonts.Cairo,
                    package: 'google_fonts_arabic',
                    color: fontColor(themeNotifier.getbackground())==true?Colors.white:Colors.black,
                  ),),
                ),
              ),

            ],
          ),
        );
      });
    }
    else {
      Directionality(
        textDirection: TextDirection.rtl,
        child: Flushbar(
          borderRadius:14,
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
          messageText:Text('لايوجد تحديثات متوفرة',textScaleFactor: 1,style: TextStyle(
            fontFamily: ArabicFonts.Cairo,
            package: 'google_fonts_arabic',
            color: Colors.white,
          ),textDirection: TextDirection.rtl,),
        )..show(context),
      );
    }

  }

  void about() {
    showAboutDialog(context: context,
      applicationName: 'Shekh Express',
        applicationVersion:'1.0.1+2' ,
        applicationIcon: Image.asset('images/logo.png',width: 40,height: 40,),
      applicationLegalese:'تطبيق لعرض أغراض مستعملة',
    );
  }
 
}

