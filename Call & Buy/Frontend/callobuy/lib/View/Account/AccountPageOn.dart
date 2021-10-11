import 'dart:convert';
import 'dart:ui';
import 'package:callobuy/View/Account/FavPage.dart';
import 'package:callobuy/View/PageViews.dart';
import 'package:callobuy/View/Settings/Formates.dart';
import 'package:callobuy/View/Settings/Settings.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import '../../main.dart';
class AccountPageOn extends StatefulWidget {
  @override
  _AccountPageOnState createState() => _AccountPageOnState();
}
class _AccountPageOnState extends State<AccountPageOn> {
  SharedPreferences sharedPreferences;
  var AccountName ="جاري التحميل";
var shareNumber='0';
var mypostnumber='0';
var numberoffav='0';
var liker='0';
  Future  getName() async {
    var jsonResponse = null;
    sharedPreferences = await SharedPreferences.getInstance();
    var id =sharedPreferences.getString("token");
    final response2 =await http.post("https://callandbuy.000webhostapp.com/CallAndBuy/GetName.php",body:{
    "id":id,
    });
      jsonResponse =json.decode(response2.body);
      Map _data = await jsonResponse;
      if (this.mounted) {
        setState(() {
          AccountName = _data['username'];
        });
      }
  }
  Future getmyShare()async{
    var jsonResponse = null;
    sharedPreferences = await SharedPreferences.getInstance();
    var id =sharedPreferences.getString("token");
    final response2 =await http.post("https://callandbuy.000webhostapp.com/CallAndBuy/GetNumberOfShare.php",body:{
      "id":id,
    });
    jsonResponse =json.decode(response2.body);
    Map _data = await jsonResponse;
    if (this.mounted) {
      setState(() {
        shareNumber = _data['COUNT(id)'];
      });
    }
  }
  Future getmyPost()async{
    var jsonResponse = null;
    sharedPreferences = await SharedPreferences.getInstance();
    var id =sharedPreferences.getString("token");
    final response2 =await http.post("https://callandbuy.000webhostapp.com/CallAndBuy/manshoraty.php",body:{
      "id":id,
    });
    jsonResponse =json.decode(response2.body);
    Map _data = await jsonResponse;
    if (this.mounted) {
      setState(() {
        mypostnumber = _data['COUNT(id)'];
      });
    }
  }
  Future getmyFav()async{
    var jsonResponse = null;
    sharedPreferences = await SharedPreferences.getInstance();
    var id =sharedPreferences.getString("token");
    final response2 =await http.post("https://callandbuy.000webhostapp.com/CallAndBuy/myFav.php",body:{
      "id":id,
    });
    jsonResponse =json.decode(response2.body);
    Map _data = await jsonResponse;
    if (this.mounted) {
      setState(() {
        numberoffav = _data['COUNT(pid)'];
      });
    }
  }
  Future getmyLiker()async{
    var jsonResponse = null;
    sharedPreferences = await SharedPreferences.getInstance();
    var id =sharedPreferences.getString("token");
    final response2 =await http.post("https://callandbuy.000webhostapp.com/CallAndBuy/GetNumberOfLike.php",body:{
      "Toid":id,
    });
    jsonResponse =json.decode(response2.body);
    Map _data = await jsonResponse;
    if (this.mounted) {
      setState(() {
         liker = _data['COUNT(toid)'];
      });
    }
  }
  @override
  void initState(){
    super.initState();
    getName();
    getmyShare();
    getmyPost();
    getmyFav();
    getmyLiker();
  }

  List<Item> _data = generateItems(1);
  @override
  Widget build(BuildContext context) {
    var blockh;
    var study=MediaQuery.of(context).copyWith().size.height;
    var resulth;
    if (study<450){
      resulth = MediaQuery.of(context).copyWith().size.height/1.45;
      blockh=6;
    }
    else if (study < 600 ){
       resulth = MediaQuery.of(context).copyWith().size.height/1.65;
       blockh=8;
    }
    else if (study<=700){
      resulth = MediaQuery.of(context).copyWith().size.height/2.30;
      blockh=10;
    }
    else if (study<=730){
       resulth = MediaQuery.of(context).copyWith().size.height/2.35;
       blockh=10;
    }

    else if (study <= 790){
      resulth = MediaQuery.of(context).copyWith().size.height/2.45;
      blockh=10;
    }
    else {
       resulth = MediaQuery.of(context).copyWith().size.height/2.85;
       blockh=10;
    }

    return GestureDetector(
      child: Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.elliptical(MediaQuery.of(context).size.width,MediaQuery.of(context).size.height/30))
          ),
          title: Text("مرحبا بك",style: TextStyle(
            fontFamily: ArabicFonts.Cairo,
            package: 'google_fonts_arabic',
          ),textScaleFactor: 1,),
          elevation: 0,
          centerTitle:true,
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView(
            children: <Widget>[
              Container(
                height:MediaQuery.of(context).copyWith().size.height/blockh,
                width:MediaQuery.of(context).copyWith().size.width,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: ListTile(
                      title: Text('$AccountName',textScaleFactor: 1,style: TextStyle(
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                          color: fontColor(themeNotifier.getbackground())
                              ? Colors.white
                              : Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),),
                      leading: Icon(Icons.person_outline,color: fontColor(themeNotifier.getbackground())
                          ? Colors.white
                          : Colors.black54,),
                    ),
                  ),
                ),
              ),
              Container(
                //height:resulth,
                width:MediaQuery.of(context).copyWith().size.width,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child:Column(
                    children: <Widget>[
                    ListTile(
                      title: Text('الإحصائيات',textScaleFactor: 1,style: TextStyle(
                          fontFamily: ArabicFonts.Cairo,
                          package: 'google_fonts_arabic',
                          color: fontColor(themeNotifier.getbackground())
                              ? Colors.white
                              : Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),),
                      leading: Icon(Icons.data_usage, color: fontColor(themeNotifier.getbackground())
                          ? Colors.white
                          : Colors.black,),
                    ),
                      Container(
                        width:MediaQuery.of(context).copyWith().size.width*0.85,
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              trailing: Text('${shareNumber}',textScaleFactor: 1,style: TextStyle(
                            fontFamily: ArabicFonts.Cairo,
                            package: 'google_fonts_arabic',
                                  color: fontColor(themeNotifier.getbackground())
                                      ? Colors.white
                                      : Colors.black54,
                            fontSize: 15,
                            fontWeight: FontWeight.bold

                        ),),
                              title:  Text('منشور',textScaleFactor: 1,style: TextStyle(
                                  fontFamily: ArabicFonts.Cairo,
                                  package: 'google_fonts_arabic',
                                  color: fontColor(themeNotifier.getbackground())
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                              ),),
                              leading: Icon(Icons.share, color: fontColor(themeNotifier.getbackground())
                                  ? Colors.white
                                  : Colors.black54,),
                            ),
                            ListTile(
                              trailing: Text('$mypostnumber',textScaleFactor: 1,style: TextStyle(
                                  fontFamily: ArabicFonts.Cairo,
                                  package: 'google_fonts_arabic',
                                  color: fontColor(themeNotifier.getbackground())
                                      ? Colors.white
                                      : Colors.black54,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                              ),),
                              title:  Text('منشوراتي',textScaleFactor: 1,style: TextStyle(
                                  fontFamily: ArabicFonts.Cairo,
                                  package: 'google_fonts_arabic',
                                  color: fontColor(themeNotifier.getbackground())
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                              ),),
                              leading: Icon(Icons.library_books, color: fontColor(themeNotifier.getbackground())
                                  ? Colors.white
                                  : Colors.black54,),
                            ),
                            ListTile(
                              trailing: Text('$numberoffav',textScaleFactor: 1,style: TextStyle(
                                  fontFamily: ArabicFonts.Cairo,
                                  package: 'google_fonts_arabic',
                                  color: fontColor(themeNotifier.getbackground())
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                              ),),
                              title:  Text('المفضلة',textScaleFactor: 1,style: TextStyle(
                                  fontFamily: ArabicFonts.Cairo,
                                  package: 'google_fonts_arabic',
                                  color: fontColor(themeNotifier.getbackground())
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                              ),),
                              leading: Icon(Icons.star, color: fontColor(themeNotifier.getbackground())
                                  ? Colors.white
                                  : Colors.black54,),
                            ),
                            ListTile(
                              trailing: Text('$liker',textScaleFactor: 1,style: TextStyle(
                                  fontFamily: ArabicFonts.Cairo,
                                  package: 'google_fonts_arabic',
                                  color: fontColor(themeNotifier.getbackground())
                                      ? Colors.white
                                      : Colors.black54,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                              ),),
                              title:  Text('إعجابات',textScaleFactor: 1,style: TextStyle(
                                  fontFamily: ArabicFonts.Cairo,
                                  package: 'google_fonts_arabic',
                                  color: fontColor(themeNotifier.getbackground())
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                              ),),
                              leading: Icon(Icons.favorite_border, color: fontColor(themeNotifier.getbackground())
                                  ? Colors.white
                                  : Colors.black54,),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height:MediaQuery.of(context).copyWith().size.height/blockh,
                width:MediaQuery.of(context).copyWith().size.width,
                child: Card(
                  color: Colors.red[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (_){
                        return Favorite();
                      }));
                    },
                    child: Center(
                      child: ListTile(
                        title: Text('المفضلة',textScaleFactor: 1,style: TextStyle(
                            fontFamily: ArabicFonts.Cairo,
                            package: 'google_fonts_arabic',
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                        ),),
                        leading: Icon(Icons.star,color: Colors.yellow,),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height:MediaQuery.of(context).copyWith().size.height/blockh,
                width:MediaQuery.of(context).copyWith().size.width,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder:(_){
                        return Settings();
                      }));
                    },
                    child: Center(
                      child: ListTile(
                        title: Text('الإعدادات',textScaleFactor: 1,style: TextStyle(
                            fontFamily: ArabicFonts.Cairo,
                            package: 'google_fonts_arabic',
                            color: fontColor(themeNotifier.getbackground())
                                ? Colors.white
                                : Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),),
                        leading: Icon(Icons.settings, color: fontColor(themeNotifier.getbackground())
                            ? Colors.white
                            : Colors.black54,),
                      ),
                    ),
                  ),
                ),
              ),

              Container(
                height:MediaQuery.of(context).copyWith().size.height/blockh,
                width:MediaQuery.of(context).copyWith().size.width,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: (){
                      Flushbar(
                        borderRadius:14,
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 5),
                        messageText:Text('لم يتم تفعيل هذا الخيار بعد',textScaleFactor: 1,style: TextStyle(
                          fontFamily: ArabicFonts.Cairo,
                          package: 'google_fonts_arabic',
                          color: Colors.white,
                        ),textDirection: TextDirection.rtl,),
                      )..show(context);
                    },
                    child: Center(
                      child: ListTile(
                        title: Text('تغيير كلمة السر',textScaleFactor: 1,style: TextStyle(
                            fontFamily: ArabicFonts.Cairo,
                            package: 'google_fonts_arabic',
                            color: fontColor(themeNotifier.getbackground())
                                ? Colors.white
                                : Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),),
                        leading: Icon(Icons.lock_outline, color: fontColor(themeNotifier.getbackground())
                            ? Colors.white
                            : Colors.black54,),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height:MediaQuery.of(context).copyWith().size.height/blockh,
                width:MediaQuery.of(context).copyWith().size.width,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: ListTile(
                      title: Text('حذف الحساب',textScaleFactor: 1,style: TextStyle(
                          fontFamily: ArabicFonts.Cairo,
                          package: 'google_fonts_arabic',
                          color: fontColor(themeNotifier.getbackground())
                              ? Colors.white
                              : Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),),
                      leading: Icon(Icons.delete_outline, color: fontColor(themeNotifier.getbackground())
                          ? Colors.white
                          : Colors.black54,),
                    ),
                  ),
                ),
              ),
              Container(
                height:MediaQuery.of(context).copyWith().size.height/blockh,
                width:MediaQuery.of(context).copyWith().size.width,
                child: Card(
                  color:themeNotifier.getTheme(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: (){
                      SignCheck();
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => PageViews()), (Route<dynamic> route) => false);
                    },
                    child: Center(
                      child: ListTile(
                        title: Text('تسجيل الخروج',textScaleFactor: 1,style: TextStyle(
                            fontFamily: ArabicFonts.Cairo,
                            package: 'google_fonts_arabic',
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),),
                        leading: Icon(Icons.rotate_left,color: Colors.white,),
                      ),
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




  SignCheck() async {
      sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString('token',null);
      sharedPreferences.commit();
  }
}

class Item {
  Item({
    this.expandedValue,
    this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List.generate(numberOfItems, (int index) {
    return Item(
      headerValue:'إعدادات الحساب',
      //expandedValue: '',
    );
  });

}