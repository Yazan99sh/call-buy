import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:callobuy/Model/Home/HomeScreen.dart';
import 'package:callobuy/View/AboutObject.dart';
import 'package:callobuy/View/MyPostImage.dart';
import 'package:callobuy/View/PostItem.dart';
import 'package:callobuy/View/Settings/Formates.dart';
import 'package:callobuy/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:intl/intl.dart'as intl;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:core';
class MyPostPage extends StatefulWidget {
  @override
  _MyPostPageState createState() => _MyPostPageState();
}
enum Crude { update, delete, View ,extend}
class _MyPostPageState extends State<MyPostPage> {
  Future refreshPost() async {
    // reload
    setState(() {
      _PostList = getMyPost();
    });
    Completer completer = new Completer();
    completer.complete(_PostList);
    return completer.future;
  }
  @override
  Widget build(BuildContext context) {
    var rat;
    var rattimeleftfont;
    var windowfont;
    var windowh;
    var windoww;
    var windowfonthead;
    if(MediaQuery.of(context).copyWith().size.height<500){
      rat =1.45;
      rattimeleftfont=12.0;
      windowfont=6.0;
      windowfonthead=14.0;
      windowh=13.0;
      windoww=7.0;
    }
    else if(MediaQuery.of(context).copyWith().size.height<580){
      rat =1.65;
      rattimeleftfont=12.0;
      windowfont=7.0;
      windowfonthead=14.0;
      windowh=14.0;
      windoww=8.0;
    }
    else if(MediaQuery.of(context).copyWith().size.height < 640) {
      rat=1.65;
      rattimeleftfont=13.0;
      windowfont=7.0;
      windowfonthead=17.0;
      windowh=15.0;
      windoww=8.0;
    }
    else if (MediaQuery.of(context).copyWith().size.height < 735){
      rattimeleftfont = 12.5 ;
      rat=1.70;
      windowfont=7.0;
      windowfonthead=17.0;
      windowh=15.0;
      windoww=8.0;
    }
    else if (MediaQuery.of(context).copyWith().size.height < 790) {
      rattimeleftfont = 12.5 ;
      rat=1.85;
      windowfont=7.0;
      windowfonthead=17.0;
      windowh=15.0;
      windoww=8.0;
    }
    else {
      rat=1.85;
      rattimeleftfont=18.5;
      windowfont=8.5;
      windowfonthead=20.0;
      windowh=15.0;
      windoww=8.0;
    }
    List<T> map<T>(List list, Function handler) {
      List<T> result = [];
      for (var i = 0; i < list.length; i++) {
        result.add(handler(i, list[i]));
      }

      return result;
    }

    return Scaffold(
      body: RefreshIndicator(
        backgroundColor: themeNotifier.getbackground(),
        onRefresh: refreshPost,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              pinned: false,
              title: Text('Call & Buy',textScaleFactor: 1,style: TextStyle(
                fontFamily: ArabicFonts.Cairo,
                package: 'google_fonts_arabic',
              ),),
              centerTitle: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(bottom:Radius.circular(18)),
              ),
            ),
            SliverList(delegate: SliverChildListDelegate([
              FutureBuilder(
                future:_PostList,
                builder: (_, snapshot) {
                  if (snapshot.connectionState ==ConnectionState.waiting){
                    return Container(
                        height:MediaQuery.of(context).copyWith().size.height/1.255,
                        child: Center(child: CircularProgressIndicator()));
                  }
                  else if (snapshot.hasError){
                    return Container(
                      height:MediaQuery.of(context).copyWith().size.height/1.255,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.perm_scan_wifi,color: Colors.red,size: MediaQuery.of(context).size.height/6,),
                            Container(
                              height: MediaQuery.of(context).copyWith().size.height/20,
                              width: MediaQuery.of(context).copyWith().size.width/3,

                              child: RaisedButton(onPressed: (){
                                refreshPost();
                              },color:themeNotifier.getTheme(),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),child: Text('إعادة التحميل',style: TextStyle(
                                fontFamily: ArabicFonts.Cairo,
                                package: 'google_fonts_arabic',
                                color:fontColor(themeNotifier.getTheme())?Colors.white:Colors.black,
                              ),textScaleFactor: 1,),),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                  else {
                    List  content = snapshot.data;
                    if (content.length>0){
                      return ListView.builder(padding: EdgeInsets.only(top: 0),shrinkWrap: true,physics:ScrollPhysics(),itemBuilder: (_, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          textDirection: TextDirection.rtl,
                          children: <Widget>[
                            Container(
                              width:MediaQuery.of(context).copyWith().size.width,
                              height:MediaQuery.of(context).copyWith().size.height/rat,
                              child: Card(
                                color:themeNotifier.getTheme(),
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14)),
                                child: Column(
                                  textDirection: TextDirection.rtl,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    FutureBuilder(
                                        future: getMyName(),
                                        builder:(_,snapshot){
                                          if (snapshot.connectionState==ConnectionState.waiting){
                                            return Container(
                                              child: Row(
                                                textDirection: TextDirection.rtl,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    height:MediaQuery.of(context).copyWith().size.height/15,
                                                    width:MediaQuery.of(context).copyWith().size.height/15,
                                                    margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                                                    child: CircleAvatar(
                                                      backgroundColor:themeNotifier.getplaceHolderColor(),
                                                    ),
                                                  ),
                                                  Container(margin: EdgeInsets.fromLTRB(8, 15, 8, 8),
                                                    height: MediaQuery.of(context).copyWith().size.height/20,
                                                    width: MediaQuery.of(context).copyWith().size.width/2,
                                                    decoration: BoxDecoration(
                                                        color:themeNotifier.getplaceHolderColor(),
                                                        borderRadius: BorderRadius.circular(18)
                                                    ),
                                                  ),
                                                  Spacer(flex:3,),
                                                  Expanded(
                                                    child: Container(
                                                      height:MediaQuery.of(context).copyWith().size.height/23,
                                                      width: MediaQuery.of(context).copyWith().size.width/150,
                                                      decoration: BoxDecoration(color:themeNotifier.getplaceHolderColor(),
                                                        borderRadius:BorderRadius.circular(18),
                                                      ),
                                                    ),

                                                  ),
                                                  Spacer(flex: 1),
                                                ],
                                              ),
                                            );
                                          }
                                          else if (snapshot.hasError){
                                            return Container(
                                              child: Row(
                                                textDirection: TextDirection.rtl,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    height:MediaQuery.of(context).copyWith().size.height/15,
                                                    width:MediaQuery.of(context).copyWith().size.height/15,
                                                    margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                                                    child: CircleAvatar(
                                                      backgroundColor: Colors.red,
                                                    ),
                                                  ),
                                                  Container(margin: EdgeInsets.fromLTRB(8, 15, 8, 8),
                                                    height: MediaQuery.of(context).copyWith().size.height/20,
                                                    width: MediaQuery.of(context).copyWith().size.width/2,
                                                    decoration: BoxDecoration(
                                                        color: Colors.red,
                                                        borderRadius: BorderRadius.circular(18)
                                                    ),
                                                  ),
                                                  Spacer(flex:3,),
                                                  Expanded(
                                                    child: Container(
                                                      height:MediaQuery.of(context).copyWith().size.height/23,
                                                      width: MediaQuery.of(context).copyWith().size.width/150,
                                                      decoration: BoxDecoration(color: Colors.red,
                                                        borderRadius:BorderRadius.circular(18),
                                                      ),
                                                    ),

                                                  ),
                                                  Spacer(flex: 1),
                                                ],
                                              ),
                                            );
                                          }
                                          else {
                                            Map name =snapshot.data;
                                            return Container(
                                              child: Row(
                                                textDirection: TextDirection.rtl,
                                                children: <Widget>[
                                                  Container(
                                                    height:MediaQuery.of(context).copyWith().size.height/15,
                                                    width:MediaQuery.of(context).copyWith().size.height/15,
                                                    margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                                                    child: CircleAvatar(
                                                      child: Text(
                                                        "${name['username'][0]}",
                                                        style: TextStyle(
                                                          color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black,
                                                          fontFamily: ArabicFonts.Cairo,
                                                          package: 'google_fonts_arabic',
                                                        ),
                                                        textScaleFactor: 1,
                                                      ),
                                                      backgroundColor: themeNotifier.getbackground(),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(bottom: 8),
                                                    child: Text(
                                                      "${name['username']}",
                                                      style: TextStyle(
                                                          fontFamily: ArabicFonts.Cairo,
                                                          package: 'google_fonts_arabic',
                                                          color:fontColor(themeNotifier.getTheme())?Colors.white:Colors.black,
                                                          fontSize: 15),
                                                      textScaleFactor: 1,
                                                      textDirection: TextDirection.rtl,
                                                    ),
                                                  ),
                                                  Spacer(flex: 3,),
                                                  Expanded(
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Container(
                                                        width: MediaQuery.of(context).copyWith().size.width/2.5,
                                                        margin: EdgeInsets.fromLTRB(
                                                            0, 0, 0, 0),
                                                        child: PopupMenuButton<Crude>(
                                                          icon: Icon(
                                                            Icons.more_vert,
                                                            color:fontColor(themeNotifier.getTheme())?Colors.white:Colors.black,
                                                          ),
                                                          color:themeNotifier.getTheme(),
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius
                                                                .circular(
                                                                10),
                                                          ),
                                                          onSelected: (Crude result) {
                                                            switch (result) {
                                                              case Crude.delete :
                                                              // TODO: Handle this case.
                                                                break;
                                                              case Crude.update:
                                                              // TODO: Handle this case.
                                                                break;
                                                              case Crude.extend:
                                                              // TODO: Handle this case.
                                                                break;
                                                              case Crude.View:
                                                              // TODO: Handle this case.
                                                                break;
                                                            }
                                                          },
                                                          itemBuilder: (
                                                              BuildContext context) =>
                                                          <PopupMenuEntry<Crude>>[
                                                            PopupMenuItem<Crude>(
                                                              value: Crude.extend,
                                                              child: Directionality(
                                                                textDirection: TextDirection
                                                                    .rtl,
                                                                child: InkWell(
                                                                  borderRadius:BorderRadius.circular(14),
                                                                  onTap:(){
                                                                    updateExpiredDate(content[index]['pid']);
                                                                    refreshPost();
                                                                    Navigator.pop(context);
                                                                  },
                                                                  child: ListTile(
                                                                    title: Text(
                                                                      "تمديد",
                                                                      style: TextStyle(
                                                                        color:fontColor(themeNotifier.getTheme())?Colors.white:Colors.black,
                                                                        fontFamily: ArabicFonts
                                                                            .Cairo,
                                                                        package: 'google_fonts_arabic',
                                                                      ),
                                                                      textScaleFactor: 1,
                                                                    ),
                                                                    leading: Icon(
                                                                      Icons.update,
                                                                      color:fontColor(themeNotifier.getTheme())?Colors.white:Colors.black,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            PopupMenuItem<Crude>(
                                                              value: Crude.View,
                                                              child: Directionality(
                                                                textDirection: TextDirection
                                                                    .rtl,
                                                                child: InkWell(
                                                                  borderRadius:BorderRadius.circular(14),
                                                                  onTap: (){
                                                                    Navigator.of(context).pop();
                                                                    Navigator.push(context,
                                                                        MaterialPageRoute(builder: (_) {
                                                                          return aboutObject(content[index]);
                                                                        }));
                                                                  },
                                                                  child: ListTile(
                                                                    title: Text(
                                                                      "التفاصيل",
                                                                      style: TextStyle(
                                                                        color:fontColor(themeNotifier.getTheme())?Colors.white:Colors.black,
                                                                        fontFamily: ArabicFonts
                                                                            .Cairo,
                                                                        package: 'google_fonts_arabic',
                                                                      ),
                                                                      textScaleFactor: 1,
                                                                    ),
                                                                    leading: Icon(
                                                                      Icons.remove_red_eye,
                                                                      color:fontColor(themeNotifier.getTheme())?Colors.white:Colors.black,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            PopupMenuItem<Crude>(
                                                              value: Crude.update,
                                                              child: Directionality(
                                                                textDirection: TextDirection
                                                                    .rtl,
                                                                child: InkWell(
                                                                  onTap:(){
                                                                    Navigator.of(context).pop();
                                                                    Navigator.push(context,
                                                                        MaterialPageRoute(builder: (_) {
                                                                          return PostItem(content[index]);
                                                                        }));
                                                                  },
                                                                  borderRadius:BorderRadius.circular(14),
                                                                  child: ListTile(
                                                                    title: Text(
                                                                      "تعديل",
                                                                      style: TextStyle(
                                                                        color:fontColor(themeNotifier.getTheme())?Colors.white:Colors.black,
                                                                        fontFamily: ArabicFonts
                                                                            .Cairo,
                                                                        package: 'google_fonts_arabic',
                                                                      ),
                                                                      textScaleFactor: 1,
                                                                    ),
                                                                    leading: Icon(
                                                                      Icons.edit,
                                                                      color:fontColor(themeNotifier.getTheme())?Colors.white:Colors.black,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            PopupMenuItem<Crude>(
                                                              value: Crude.delete,
                                                              child: Directionality(
                                                                textDirection: TextDirection
                                                                    .rtl,
                                                                child: InkWell(
                                                                  onTap: (){
                                                                    DeleteImage(content[index]['pid']);
                                                                    deletePost(content[index]['pid']);
                                                                    refreshPost();
                                                                    Navigator.pop(context);
                                                                  },
                                                                  borderRadius:BorderRadius.circular(14),
                                                                  child: ListTile(
                                                                    title: Text(
                                                                      "حذف",
                                                                      style: TextStyle(
                                                                        color:fontColor(themeNotifier.getTheme())?Colors.white:Colors.black,
                                                                        fontFamily: ArabicFonts
                                                                            .Cairo,
                                                                        package: 'google_fonts_arabic',
                                                                      ),
                                                                      textScaleFactor: 1,
                                                                    ),
                                                                    leading: Icon(
                                                                      Icons.delete,
                                                                      color:fontColor(themeNotifier.getTheme())?Colors.white:Colors.black,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                        }),
                                    Center(child: MyPostImage(content[index]['pid'])),
                                    Expanded(
                                      child: StreamBuilder(
                                        stream:Stream.periodic(
                                            Duration(seconds: 1), (i) => i).asBroadcastStream(),
                                        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                                          if (snapshot.hasError){
                                          }
                                          String btime=content[index]['expiredDate'];
                                          var byear =int.parse(btime.substring(0,4));
                                          var bmonth=int.parse(btime.substring(5,7));
                                          var bday=int.parse(btime.substring(8,10));
                                          var bhour=int.parse(btime.substring(11,13));
                                          var bminute=int.parse(btime.substring(14,16));
                                          var bsecond=int.parse(btime.substring(17,19));
                                          int estimateTs = DateTime(byear, bmonth, bday, bhour, bminute,bsecond).millisecondsSinceEpoch;
                                          //int estimateTs = DateTime(2020, 5, 2, 18, 0,0).millisecondsSinceEpoch;
                                          intl.DateFormat format = intl.DateFormat("mm:ss");
                                          int now = DateTime
                                              .now()
                                              .millisecondsSinceEpoch;
                                          Duration remaining = Duration(milliseconds: estimateTs - now);
                                          var dateString = '${format.format(
                                              DateTime.fromMillisecondsSinceEpoch(remaining.inMilliseconds))}';
                                          if (dateString.toString() == '0:00:00' ){
                                            DeleteImage(content[index]['pid']);
                                            deletePost(content[index]['pid']);
                                          }
                                          if ('${remaining.inHours.toString()[0]}'=='-'){
                                             DeleteImage(content[index]['pid']);
                                              deletePost(content[index]['pid']);
                                            return Center(
                                              child: Container(
                                                child: Row(
                                                  textDirection: TextDirection.rtl,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: EdgeInsets.only(right:MediaQuery.of(context).size.width/7),
                                                      child: Text('وقت الغرض انتهى',style: TextStyle(
                                                        color:fontColor(themeNotifier.getTheme())?Colors.white:Colors.black,
                                                        fontFamily: ArabicFonts
                                                            .Cairo,
                                                        package: 'google_fonts_arabic',
                                                        fontSize: rattimeleftfont,
                                                      ),textScaleFactor: 1,),
                                                    ),
                                                    Spacer(flex: 1,),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: <Widget>[
                                                        Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: <Widget>[
                                                            Padding(
                                                              padding: EdgeInsets.only(top:MediaQuery.of(context).size.height/40),
                                                              child: Container(
                                                                width:MediaQuery.of(context).copyWith().size.width/windoww,
                                                                height: MediaQuery.of(context).copyWith().size.height/windowh,
                                                                child: Card(
                                                                  color:Colors.red,
                                                                  shape:RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(14),
                                                                  ),
                                                                  child: Center(child: Text('00',textScaleFactor: 1,style: TextStyle(
                                                                  color: Colors.white,
                                                                    fontSize: windowfonthead,
                                                                    fontWeight: FontWeight.bold,
                                                                    fontFamily: ArabicFonts
                                                                        .Cairo,
                                                                    package: 'google_fonts_arabic',
                                                                  ),)),
                                                                ),
                                                              ),
                                                            ),
                                                            Text('ساعة',style: TextStyle(
                                                              color:fontColor(themeNotifier.getTheme())?Colors.white:Colors.black,
                                                              fontSize:windowfont,
                                                              fontWeight: FontWeight.bold,
                                                              fontFamily: ArabicFonts
                                                                  .Cairo,
                                                              package: 'google_fonts_arabic',
                                                            ),)
                                                          ],
                                                        ),
                                                        Text(':',style: TextStyle(
                                                          fontSize:windowfonthead,
                                                          color:fontColor(themeNotifier.getTheme())?Colors.white:Colors.black,
                                                        ),textScaleFactor: 1,),
                                                        Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: <Widget>[
                                                            Padding(
                                                              padding: EdgeInsets.only(top:MediaQuery.of(context).size.height/40),
                                                              child: Container(
                                                                width:MediaQuery.of(context).copyWith().size.width/windoww,
                                                                height: MediaQuery.of(context).copyWith().size.height/windowh,
                                                                child: Card(
                                                                  color:Colors.red,
                                                                  shape:RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(14),
                                                                  ),
                                                                  child: Center(child: Text('00',textScaleFactor: 1,style: TextStyle(
                                                                    color:Colors.white,
                                                                    fontSize: windowfonthead,
                                                                    fontWeight: FontWeight.bold,
                                                                    fontFamily: ArabicFonts
                                                                        .Cairo,
                                                                    package: 'google_fonts_arabic',
                                                                  ),)),
                                                                ),
                                                              ),
                                                            ),
                                                            Text('دقيقة',style: TextStyle(
                                                              color:fontColor(themeNotifier.getTheme())?Colors.white:Colors.black,
                                                              fontSize: windowfont,
                                                              fontWeight: FontWeight.bold,
                                                              fontFamily: ArabicFonts
                                                                  .Cairo,
                                                              package: 'google_fonts_arabic',
                                                            ),)
                                                          ],
                                                        ),
                                                        Text(':',style: TextStyle(
                                                          fontSize:windowfonthead,
                                                          color:fontColor(themeNotifier.getTheme())?Colors.white:Colors.black,
                                                        ),textScaleFactor: 1,),
                                                        Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: <Widget>[
                                                            Padding(
                                                              padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height/40),
                                                              child: Container(
                                                                width:MediaQuery.of(context).copyWith().size.width/windoww,
                                                                height: MediaQuery.of(context).copyWith().size.height/windowh,
                                                                child: Card(
                                                                  color:Colors.red,
                                                                  shape:RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(14),
                                                                  ),
                                                                  child: Center(child: Text('00',textScaleFactor: 1,style: TextStyle(
                                                                    color: Colors.white,
                                                                    fontSize: windowfonthead,
                                                                    fontWeight: FontWeight.bold,
                                                                    fontFamily: ArabicFonts
                                                                        .Cairo,
                                                                    package: 'google_fonts_arabic',
                                                                  ),)),
                                                                ),
                                                              ),
                                                            ),
                                                            Text('ثانية',style: TextStyle(
                                                              color:fontColor(themeNotifier.getTheme())?Colors.white:Colors.black,
                                                              fontSize: windowfont,
                                                              fontWeight: FontWeight.bold,
                                                              fontFamily: ArabicFonts
                                                                  .Cairo,
                                                              package: 'google_fonts_arabic',
                                                            ),)
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Spacer(flex: 2,),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }
                                          else
                                            return Container(
                                              child: Row(
                                                textDirection: TextDirection.rtl,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Padding(
                                                    padding: EdgeInsets.only(right:MediaQuery.of(context).size.width/7),
                                                    child: Text('الوقت المتبقي للعرض',style: TextStyle(
                                                      color:fontColor(themeNotifier.getTheme())?Colors.white:Colors.black,
                                                      fontFamily: ArabicFonts
                                                          .Cairo,
                                                      package: 'google_fonts_arabic',
                                                      fontSize: rattimeleftfont,
                                                    ),textScaleFactor: 1,),
                                                  ),
                                                  Spacer(flex: 1,),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: <Widget>[
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: <Widget>[
                                                          Padding(
                                                            padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height/40),
                                                            child: Container(
                                                              width:MediaQuery.of(context).copyWith().size.width/windoww,
                                                              height: MediaQuery.of(context).copyWith().size.height/windowh,
                                                              child: Card(
                                                                shape:RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(14),
                                                                ),
                                                                child: Center(
                                                                  child: Text('${remaining.inHours}',textScaleFactor: 1,style: TextStyle(
                                                                    color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black,
                                                                    fontSize:windowfonthead,
                                                                    fontWeight: FontWeight.bold,
                                                                    fontFamily: ArabicFonts
                                                                        .Cairo,
                                                                    package: 'google_fonts_arabic',
                                                                  ),),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Text('ساعة',style: TextStyle(
                                                            color:fontColor(themeNotifier.getTheme())?Colors.white:Colors.black,
                                                            fontSize: windowfont,
                                                            fontWeight: FontWeight.bold,
                                                            fontFamily: ArabicFonts
                                                                .Cairo,
                                                            package: 'google_fonts_arabic',
                                                          ),)
                                                        ],
                                                      ),
                                                      Text(':',style: TextStyle(
                                                        fontSize:windowfonthead,
                                                        color:fontColor(themeNotifier.getTheme())?Colors.white:Colors.black,
                                                      ),textScaleFactor: 1,),
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: <Widget>[
                                                          Padding(
                                                            padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height/40),
                                                            child: Container(
                                                              width:MediaQuery.of(context).copyWith().size.width/windoww,
                                                              height: MediaQuery.of(context).copyWith().size.height/windowh,
                                                              child: Card(
                                                                shape:RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(14),
                                                                ),
                                                                child: Center(child: Text('${dateString.toString().substring(0,2)}',textScaleFactor: 1,style: TextStyle(
                                                                  color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black,
                                                                  fontSize: windowfonthead,
                                                                  fontWeight: FontWeight.bold,
                                                                  fontFamily: ArabicFonts
                                                                      .Cairo,
                                                                  package: 'google_fonts_arabic',
                                                                ),)),
                                                              ),
                                                            ),
                                                          ),
                                                          Text('دقيقة',style: TextStyle(
                                                            color:fontColor(themeNotifier.getTheme())?Colors.white:Colors.black,
                                                            fontSize: windowfont,
                                                            fontWeight: FontWeight.bold,
                                                            fontFamily: ArabicFonts
                                                                .Cairo,
                                                            package: 'google_fonts_arabic',
                                                          ),)
                                                        ],
                                                      ),
                                                      Text(':',style: TextStyle(
                                                        fontSize:windowfonthead,
                                                        color:fontColor(themeNotifier.getTheme())?Colors.white:Colors.black,
                                                      ),textScaleFactor: 1,),
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: <Widget>[
                                                          Padding(
                                                            padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height/40),
                                                            child: Container(
                                                              width:MediaQuery.of(context).copyWith().size.width/windoww,
                                                              height: MediaQuery.of(context).copyWith().size.height/windowh,
                                                              child: Card(
                                                                shape:RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(14),
                                                                ),
                                                                child: Center(child: Text('${dateString.toString().substring(3,5)}',textScaleFactor: 1,style: TextStyle(
                                                                  color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black,
                                                                  fontSize: windowfonthead,
                                                                  fontWeight: FontWeight.bold,
                                                                  fontFamily: ArabicFonts
                                                                      .Cairo,
                                                                  package: 'google_fonts_arabic',
                                                                ),)),
                                                              ),
                                                            ),
                                                          ),
                                                          Text('ثانية',style: TextStyle(
                                                            color:fontColor(themeNotifier.getTheme())?Colors.white:Colors.black,
                                                            fontSize: windowfont,
                                                            fontWeight: FontWeight.bold,
                                                            fontFamily: ArabicFonts
                                                                .Cairo,
                                                            package: 'google_fonts_arabic',
                                                          ),)
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Spacer(flex: 2,),
                                                ],
                                              ),
                                            );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        );
                      }, itemCount:content.length,);}
                    else {
                      return Container(
                        height:MediaQuery.of(context).copyWith().size.height/1.255,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                'images/Empty.png',
                                color:themeNotifier.getTheme(),
                                height: MediaQuery.of(context).copyWith().size.height*0.18,
                                width: MediaQuery.of(context).copyWith().size.width*0.20,
                              ),
                              Text('لا يوجد معروضات ',style: TextStyle(
                                  color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black54,
                                  fontFamily: ArabicFonts.Cairo,
                                  package:
                                  'google_fonts_arabic',
                                  fontWeight: FontWeight.bold
                              ),textScaleFactor: 1,),
                            ],
                          ),
                        ),
                      );
                    }
                  }
                },
              ),
            ]))
          ],
        ),
      ),
    );
  }

  SharedPreferences sharedPreferences;

  Future <List> getMyPost() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var id = sharedPreferences.getString("token");
    var jsonResponse = null;
    final response2 = await http.post(
        "https://callandbuy.000webhostapp.com/CallAndBuy/GetMyPost.php", body: {
      "id":"$id",
    });
    jsonResponse = await json.decode(response2.body);
    return jsonResponse;
  }

  Future<Map>getMyName() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var id = sharedPreferences.getString("token");
    final response2 = await http.post(
        "https://callandbuy.000webhostapp.com/CallAndBuy/GetName.php", body: {
      "id":"$id",
    });
    var jsonResponse = json.decode(response2.body);
    return jsonResponse;
  }
  Future <Map> GetImage(var pid) async {
    final response = await http.post("https://callandbuy.000webhostapp.com/CallAndBuy/GetImageFrombase.php",body: {
      "pid":"$pid",
    });
    var jsonResponse = json.decode(response.body);
    if (jsonResponse == false ){
      jsonResponse={};
      refreshPost();
    }
    return jsonResponse;
  }
  Future <List> _PostList;
  @override
  void initState() {
    super.initState();
    _PostList = getMyPost();
  }


}

updateExpiredDate(var pid)async{
  var today = new DateTime.now();
  var extradate = today.add(new Duration(days: 3));
  final response1 = await http.post("https://callandbuy.000webhostapp.com/CallAndBuy/UpdateExpiredDate.php",body: {
    "pid":"$pid",
    "expiredDate":"$extradate",
  });
}
deletePost(var pid) async {
  DeleteImage(pid);
  final response = await http.post("https://callandbuy.000webhostapp.com/CallAndBuy/DeletePostFromBase.php",body: {
    "pid":"$pid",
  });
  await http.post("https://callandbuy.000webhostapp.com/CallAndBuy/DeleteFromFav.php",body: {
    "pid":"$pid",
  });

}
DeleteImage(var pid)async{
  var data =await GetImage(pid);
  for(int i=0;i<data.length;i++) {
    var path = data[i]['imagename'];
    final response2 = await http.post(
        "https://callandbuy.000webhostapp.com/CallAndBuy/DeleteImage.php",
        body: {
          "path": "$path",
        });
  }
}


