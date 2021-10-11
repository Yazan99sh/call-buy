import 'dart:async';
import 'package:callobuy/Model/Home/HomeScreen.dart';
import 'package:callobuy/View/Home/AdsImage.dart';
import 'package:callobuy/View/Home/GridViewPost.dart';
import 'package:callobuy/View/Home/SearchingPage.dart';
import 'package:callobuy/View/Settings/Formates.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:carousel_pro/carousel_pro.dart';
import '../../main.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //this function for convert indexes list for map and use them easly
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }
  //this variable useful to get access to whole post in my database
  Future <List> _PostsLsit;

  @override
  void initState() {
    super.initState();
    //this variable gathering data form function getPost()
    _PostsLsit = getPosts();
  }
  var RefreshKey = GlobalKey<RefreshIndicatorState>();
  //this function useful for refresh data from database handling by refresh indicator
  Future Refresh()async{
    RefreshKey.currentState?.show(atTop: false);
    setState(() {
      _PostsLsit=getPosts();
    });
    Completer completer = new Completer();
    completer.complete(_PostsLsit);
    return completer.future;
  }
  var addrat;
  @override
  Widget build(BuildContext context) {
    //sh variable for define size of searching field
    var sh ;
if (MediaQuery.of(context).copyWith().size.height > 1000 ){
  sh = MediaQuery.of(context).copyWith().size.height/33;
  addrat=3.2;
}
  else  if (MediaQuery.of(context).copyWith().size.height > 790 ){
      sh = MediaQuery.of(context).copyWith().size.height/20;
      addrat=3.7;
    }
    else if (MediaQuery.of(context).copyWith().size.height<500){
      sh=MediaQuery.of(context).copyWith().size.height/10;
      addrat=2.7;
    }
    else if (MediaQuery.of(context).copyWith().size.height<580){
      sh=MediaQuery.of(context).copyWith().size.height/14.5;
      addrat=3.2;
    }
    else if (MediaQuery.of(context).copyWith().size.height<640) {
      sh = MediaQuery.of(context).copyWith().size.height/15;
      addrat=3.2;
    }
    else {
      sh = MediaQuery.of(context).copyWith().size.height/17;
      addrat=3.35;
    }
    //sfont variable for define font size of searching field
    var sfont;
    if (MediaQuery.of(context).copyWith().textScaleFactor > 1.5 ){
      sfont =8.0;
    }
    else if (MediaQuery.of(context).copyWith().textScaleFactor > 1){
      sfont = 12.0;
    }
    else {
      sfont =16.0;
    }
    //this variable get logic px for width of the screen
    var sWidth = MediaQuery.of(context).copyWith().size.width;
    //this variable get logic px for height of the screen
    //var sheight = MediaQuery.of(context).copyWith().size.height;
    //this variable get the state of screen orientation
    //final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      //refresh indicator to refresh data by pulling screen down
      body: CustomScrollView(
        //to you always can scroll even there is no data in screen
        physics:AlwaysScrollableScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
           expandedHeight:MediaQuery.of(context).copyWith().size.height > 900?65:null,
            title: Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                width: sWidth,
                height: sh,
                child: TextField(
                  autofocus: false,
                  readOnly: true,
                  style: TextStyle(
                    fontFamily: ArabicFonts.Cairo,
                    package: 'google_fonts_arabic',
                     color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black,
                    fontSize: sfont,
                  ),
                  onTap: (){
                    //navigate to searching screen
                    Navigator.push(context,MaterialPageRoute(builder:(_){
                      return Searching();
                    }));
                  },
                  decoration: InputDecoration(

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(color:themeNotifier.getTheme()),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color:themeNotifier.getTheme(),),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      alignLabelWithHint: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      hintText: 'اضغط للبحث',
                      hintStyle: TextStyle(
                        fontSize: sfont,
                        color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black54,
                      ),
                      contentPadding: EdgeInsets.all(5),
                      filled: true,
                      fillColor:themeNotifier.getbackground(),
                      suffixIcon: Icon(Icons.search
                      ),
                  ),
                ),
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom:Radius.circular(18)),
            ),
actions: <Widget>[
  IconButton(
    splashColor:Colors.transparent,
      highlightColor: Colors.transparent,
      tooltip:"إعدادات",
      icon: Icon(
        Icons.settings,
        color: themeNotifier.getIcon(),
      ),
      onPressed: () {
        gotoSettengs(context);
      })
],
            pinned: false,
            floating: true,
          ),
          SliverList(
              delegate:SliverChildListDelegate(
            [
              //ads Block for showing ads from Database
              AddBlock(),
              //Post Grid with Passing it PostList
              PostGrid(_PostsLsit,themeNotifier.getTheme(),themeNotifier.getplaceHolderColor(),'Home'),
            ]
          )),
        ],
      ),
    );
  }

  Widget AddBlock(){
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: RefreshIndicator(
        key: RefreshKey,
        backgroundColor:themeNotifier.getplaceHolderColor(),
        onRefresh: Refresh,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: SizedBox(
              height:MediaQuery.of(context).copyWith().size.height/addrat,
              width:MediaQuery.of(context).copyWith().size.width,
              child:FutureBuilder(future:getAds(),builder: (_,snapshot){
                if (snapshot.connectionState==ConnectionState.waiting){
                  return Container(
                      decoration:BoxDecoration(
                        color: themeNotifier.getplaceHolderColor(),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Center(child: CircularProgressIndicator()));
                }
                else if (snapshot.hasError){
                  return Center(child: IconButton(icon:Icon(Icons.refresh,color:fontColor(themeNotifier.getplaceHolderColor())?Colors.white:Colors.black,), onPressed:(){
                    setState(() {
                    });
                  }));
                }
                else if (snapshot.hasData) {
                  List Ads =snapshot.data;
                  if (Ads.length>0){
                    return Carousel(
                      dotColor:themeNotifier.getplaceHolderColor(),
                      boxFit: BoxFit.cover,
                      autoplay: true,
                      animationCurve: Curves.fastOutSlowIn,
                      autoplayDuration: Duration(seconds:5),
                      animationDuration: Duration(seconds: 1),
                      dotSize: 6.0,
                      dotIncreasedColor:themeNotifier.getTheme(),
                      dotBgColor: Colors.transparent,
                      dotPosition: DotPosition.bottomCenter,
                      dotVerticalPadding: 10.0,
                      showIndicator: true,
                      indicatorBgPadding: 7.0,
                      borderRadius: true,
                      radius: Radius.circular(14),
                      images: Ads.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child:AdsImage(i),
                            );
                          },
                        );
                      }).toList(),
                    );
                  }
                  else {
                    return ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.asset('images/Signup.jpg',fit: BoxFit.cover,));
                  }
                }
                else {
                  return ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.asset('images/Signup.jpg',fit: BoxFit.cover,));
                }
              },)
          ),
        ),
      ),
    );
  }

}

