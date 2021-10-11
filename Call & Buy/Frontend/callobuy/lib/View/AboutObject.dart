import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:callobuy/Model/AboutObject.dart';
import 'package:callobuy/View/AboutSeller.dart';
import 'package:callobuy/View/PhotoReview.dart';
import 'package:callobuy/main.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:flushbar/flushbar.dart';
import 'package:url_launcher/url_launcher.dart' as url;
import 'dart:core';
import 'package:photo_view/photo_view.dart';
import 'Settings/Formates.dart';
// ignore: camel_case_types
class aboutObject extends StatefulWidget {
  Map info;

  aboutObject([this.info]);

  @override
  _aboutObjectState createState() => _aboutObjectState();
}

// ignore: camel_case_types
class _aboutObjectState extends State<aboutObject> {
  Future<Map> Check;
  addToFav(var pid) async {
    sharedPreferences = await SharedPreferences.getInstance();
    var id = sharedPreferences.getString("token");
    if (id == null || id==''){
      Directionality(
        textDirection: TextDirection.rtl,
        child: Flushbar(
          messageText: Text(
            "يجب عليك تسجيل الدخول أولا",
            textDirection: TextDirection.rtl,
            style: TextStyle(
              color:fontColor(themeNotifier.getTheme())?Colors.white:Colors.black,
              fontFamily: ArabicFonts.Cairo,
              package: 'google_fonts_arabic',
            ),
            textScaleFactor: 1,
          ),
          backgroundColor:themeNotifier.getTheme(),
          margin: EdgeInsets.all(8),
          duration: Duration(seconds: 3),
          flushbarStyle: FlushbarStyle.FLOATING,
          borderRadius: 14,
        )
          ..show(context),
      );
    }
    else {
      final response1 = await http.post(
          "https://callandbuy.000webhostapp.com/CallAndBuy/CheckFav.php",
          body: {
            "pid": "$pid",
            "id": "$id",
          });
      var jsonres = json.decode(response1.body);
      if (jsonres == null || jsonres == false) {
        final response2 = await http.post(
            "https://callandbuy.000webhostapp.com/CallAndBuy/InsertIntoFavorite.php",
            body: {
              "pid": "$pid",
              "id": "$id",
            });
        refresh();
        Directionality(
          textDirection: TextDirection.rtl,
          child: Flushbar(
            messageText: Text(
              "تمت إضافة الغرض للمفضلة",
              textDirection: TextDirection.rtl,
              textScaleFactor: 1,
              style: TextStyle(
                color:Colors.white,
                fontFamily: ArabicFonts.Cairo,
                package: 'google_fonts_arabic',
              ),
            ),
            backgroundColor: Colors.red[900],
            margin: EdgeInsets.all(8),
            duration: Duration(seconds: 3),
            flushbarStyle: FlushbarStyle.FLOATING,
            borderRadius: 14,
          )
            ..show(context),
        );
      } else {
        Directionality(
          textDirection: TextDirection.rtl,
          child: Flushbar(
            messageText: Text(
              "موجود مسبقا في المفضلة",
              textDirection: TextDirection.rtl,
              textScaleFactor: 1,
              style: TextStyle(
                color:Colors.white,
                fontFamily: ArabicFonts.Cairo,
                package: 'google_fonts_arabic',
              ),
            ),
            backgroundColor: Colors.red[900],
            icon: IconButton(
              onPressed: () {
                removefav(widget.info['id'], widget.info['pid']);
                refresh();
                Navigator.pop(context);
              },
              icon: Text(
                "إزالة",
                textDirection: TextDirection.rtl,
                textScaleFactor: 1,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: ArabicFonts.Cairo,
                  package: 'google_fonts_arabic',
                ),
              ),
            ),
            margin: EdgeInsets.all(8),
            duration: Duration(seconds: 3),
            flushbarStyle: FlushbarStyle.FLOATING,
            borderRadius: 14,
          )
            ..show(context),
        );
      }
    }
  }
  refresh() {
    setState(() {
      Check = Checkfav(widget.info['pid']);
    });
  }
  @override
  void initState() {

    super.initState();
    getName();
    Check = Checkfav(widget.info['pid']);
  }
  var blockh;
  @override
  Widget build(BuildContext context) {

if (MediaQuery.of(context).copyWith().size.height <450){
  blockh=8;
}
  else {
    blockh=12;
}
    return Scaffold(
      body:Stack(
        children: <Widget>[
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor:themeNotifier.getplaceHolderColor(),
                iconTheme: IconThemeData(
                color:themeNotifier.getTheme(),
              ),
                bottom:PreferredSize(child: Container(), preferredSize:Size(0,20)),
                  actions: <Widget>[
                    IconButton(
                        icon: FutureBuilder(
                          future: Check,
                          builder: (_, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Icon(
                                Icons.star_border,
                                color: Colors.yellow,
                              );
                            } else if (snapshot.hasError) {
                              return Icon(
                                Icons.star_border,
                                color: Colors.yellow,
                              );
                            } else {
                              var love = snapshot.data;
                              if (love['log'] =='0'){
                                return Icon(Icons.star_border,color: Colors.grey,);
                              }
                              else if (love.length > 0) {
                                return Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                );
                              } else {
                                return Icon(
                                  Icons.star_border,
                                  color: Colors.yellow,
                                );
                              }
                            }
                          },
                        ),
                        onPressed: () {
                          addToFav(widget.info['pid']);
                        })
                  ],
                  pinned: false,
                  expandedHeight: MediaQuery.of(context).copyWith().size.height / 2.5,
                  brightness: Brightness.dark,
              flexibleSpace: Stack(
                children: <Widget>[
Positioned(
    child:FutureBuilder(
                        future: GetImage(widget.info['pid']),
                        builder: (_, snapshot) {
                          List initdata=snapshot.data;
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator(
                              valueColor:
                              AlwaysStoppedAnimation<
                                  Color>(
                                fontColor(themeNotifier.getplaceHolderColor())?Colors.white:Colors.black,),
                            ));
                          } else if (snapshot.hasError) {

                            return Center(child: IconButton(icon:Icon(Icons.refresh,color:fontColor(themeNotifier.getplaceHolderColor())?Colors.white:Colors.black,), onPressed:(){
                              setState(() {
                              });
                            }));

                          } else {
                            List image = snapshot.data;
                            return Carousel(
                              onImageTap:image.isNotEmpty? (i){
                              Navigator.of(context).push(MaterialPageRoute(builder: (_){
                                  return PhotoReview(image,i);
                                }));
                              }:null,
                              dotColor:themeNotifier.getplaceHolderColor(),
                              boxFit: BoxFit.cover,
                              autoplay: false,
                              animationCurve: Curves.fastOutSlowIn,
                              animationDuration: Duration(milliseconds: 1000),
                              dotSize: 6.0,
                              dotIncreasedColor:themeNotifier.getTheme(),
                              dotBgColor: Colors.transparent,
                              dotPosition: DotPosition.bottomCenter,
                              dotVerticalPadding: 15.0,
                              showIndicator: true,
                              indicatorBgPadding: 7.0,
                              borderRadius: false,
                              images: image.map((i) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return ClipRRect(
                                      child:Hero(
                                        tag: 'tag-${i['imagename']}',
                                        child: CachedNetworkImage(
                                          useOldImageOnUrlChange: false,
                                          fit: BoxFit.cover,
                                          fadeInDuration: Duration(milliseconds: 10),
                                          fadeOutDuration: Duration(milliseconds: 10),
                                          imageUrl:'${i['imagename']}',
                                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                                              Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                                          errorWidget: (context, url, error) => IconButton(icon:Icon(Icons.refresh,color:fontColor(themeNotifier.getplaceHolderColor())?Colors.white:Colors.black,),onPressed:(){
                                            setState(() {
                                            });
                                          },),
                                        ),
                                      )
                                    );
                                  },
                                );
                              }).toList(),
                            );
                          }
                        }),
  top: 0,
  left: 0,
  right: 0,
  bottom: 0,
),
                  Positioned(
                    child: Container(
                      height: MediaQuery.of(context).copyWith().size.height/47,
                      decoration: BoxDecoration(
                        color:themeNotifier.getbackground(),
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(50),
                        ),
                      ),
                    ),
                    bottom: -1,
                    left: 0,
                    right: 0,
                  ),
                ],
              ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  SellerBlock(),
                  TitleBlock(),
                  TypeBlock(),
                  SubtypeBlock(),
                  LocationBlock(),
                  DescribtionBlock(),
                  DescribtionText(),
                  PriceBlock(),
                  PriceText(),
                  ChatBlock(),
                  ChatIcon(),
                  ConnectBlock(),
                ]),
              ),
            ],
          ),
        ],
      )
    );
  }

  Widget SellerBlock() {
    return Container(
      height: MediaQuery.of(context).copyWith().size.height /blockh ,
      width:  MediaQuery.of(context).copyWith().size.width,
      child: Card(
        color:themeNotifier.getTheme(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        elevation: 5,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return aboutSeller(widget.info['id']);
            }));
          },
          child: Row(
            textDirection: TextDirection.rtl,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).copyWith().size.height,
                width: MediaQuery.of(context).copyWith().size.width / 4,
                child: Card(
                  elevation: 7,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: Text(
                      "البائع",
                      style: TextStyle(
                        color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                      ),
                      textScaleFactor: 1,
                    ),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).copyWith().size.height,
                width:MediaQuery.of(context).copyWith().size.width/1.55,
                child: Card(
              elevation: 7,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Center(
                  child: Text(
                    '$AccountName',
                    style: TextStyle(
                        color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black,
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                        fontWeight: FontWeight.bold),
                  textScaleFactor: 1,
                  ),

                ),
              ),
                ),
              ),
              Icon(
                Icons.arrow_upward,
                color:fontColor(themeNotifier.getTheme())?Colors.white:Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget TitleBlock() {
    return Container(
      height: MediaQuery.of(context).copyWith().size.height / blockh,
      width: MediaQuery.of(context).copyWith().size.width,
      child: Card(
        color:themeNotifier.getTheme(),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          textDirection: TextDirection.rtl,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).copyWith().size.height,
              width: MediaQuery.of(context).copyWith().size.width / 4,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 7,
                child: Center(
                  child: Text(
                    'مقدمة',
                    style: TextStyle(
                      color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: ArabicFonts.Cairo,
                      package: 'google_fonts_arabic',
                    ),
                    textScaleFactor: 1,
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).copyWith().size.height,
              width:MediaQuery.of(context).copyWith().size.width-MediaQuery.of(context).copyWith().size.width / 4-8,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 7,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          '${widget.info['title']}',
                          style: TextStyle(
                            color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: ArabicFonts.Cairo,
                            package: 'google_fonts_arabic',
                          ),
                  textScaleFactor: 1,maxLines: 1,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget TypeBlock() {
    return Container(
      height: MediaQuery.of(context).copyWith().size.height / blockh,
      width:  MediaQuery.of(context).copyWith().size.width,
      child: Card(
        color:themeNotifier.getTheme(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        elevation: 5,
        child: Row(
          textDirection: TextDirection.rtl,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).copyWith().size.height,
              width: MediaQuery.of(context).copyWith().size.width / 4,
              child: Card(
                elevation: 7,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Text(
                    "النوع",
                    style: TextStyle(
                      color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: ArabicFonts.Cairo,
                      package: 'google_fonts_arabic',
                    ),
                    textScaleFactor: 1,
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).copyWith().size.height,
              width:MediaQuery.of(context).copyWith().size.width-MediaQuery.of(context).copyWith().size.width / 4-8,
              child: Card(
                elevation: 7,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Center(
                    child: Text(
                      '${widget.info["Thingtype"]}',
                      style: TextStyle(
                          color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black,
                          fontFamily: ArabicFonts.Cairo,
                          package: 'google_fonts_arabic',
                          fontWeight: FontWeight.bold),
                      textScaleFactor: 1,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget SubtypeBlock() {
    return Container(
      height: MediaQuery.of(context).copyWith().size.height / blockh,
      width:  MediaQuery.of(context).copyWith().size.width,
      child: Card(
        color:themeNotifier.getTheme(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        elevation: 5,
        child: Row(
          textDirection: TextDirection.rtl,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).copyWith().size.height,
              width: MediaQuery.of(context).copyWith().size.width / 4,
              child: Card(
                elevation: 7,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Text(
                    "الفئة",
                    style: TextStyle(
                      color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: ArabicFonts.Cairo,
                      package: 'google_fonts_arabic',
                    ),
                    textScaleFactor: 1,
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).copyWith().size.height,
              width:MediaQuery.of(context).copyWith().size.width-MediaQuery.of(context).copyWith().size.width / 4-8,
              child: Card(
                elevation: 7,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Center(
                    child: Text(
                      '${widget.info["Subtype"]}',
                      style: TextStyle(
                          color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black,
                          fontFamily: ArabicFonts.Cairo,
                          package: 'google_fonts_arabic',
                          fontWeight: FontWeight.bold),
                      textScaleFactor: 1,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget LocationBlock() {
    return Container(
      height: MediaQuery.of(context).copyWith().size.height / blockh,
      width:  MediaQuery.of(context).copyWith().size.width,
      child: Card(
        color:themeNotifier.getTheme(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        elevation: 5,
        child: Row(
          textDirection: TextDirection.rtl,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).copyWith().size.height,
              width: MediaQuery.of(context).copyWith().size.width / 4,
              child: Card(
                elevation: 7,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Text(
                    "الموقع",
                    style: TextStyle(
                      color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: ArabicFonts.Cairo,
                      package: 'google_fonts_arabic',
                    ),
                    textScaleFactor: 1,
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).copyWith().size.height,
              width:MediaQuery.of(context).copyWith().size.width-MediaQuery.of(context).copyWith().size.width / 4-8,
              child: Card(
                elevation: 7,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Center(
                    child: Text(
                      '${widget.info['address']}',
                      style: TextStyle(
                          color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black,
                          fontFamily: ArabicFonts.Cairo,
                          package: 'google_fonts_arabic',
                          fontWeight: FontWeight.bold),
                      textScaleFactor: 1,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget DescribtionBlock() {
    return Container(
      height: MediaQuery.of(context).copyWith().size.height / blockh,
      width:  MediaQuery.of(context).copyWith().size.width,
      child: Card(
        color:themeNotifier.getTheme(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        elevation: 5,
        child: Container(
          height: MediaQuery.of(context).copyWith().size.height,
          width:  MediaQuery.of(context).copyWith().size.width,
          child: Card(
            elevation: 7,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Text(
                'التفاصيل',
                style: TextStyle(
                  color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: ArabicFonts.Cairo,
                  package: 'google_fonts_arabic',
                ),
                textScaleFactor: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget DescribtionText() {
    return Container(
      //height:MediaQuery.of(context).copyWith().size.height/10,
      width: MediaQuery.of(context).size.width,
      child: Card(
        color:themeNotifier.getTheme(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        elevation: 5,
        child: Container(
          // height:MediaQuery.of(context).copyWith().size.height/10,
          width: MediaQuery.of(context).size.width,
          child: Card(
            elevation: 7,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${widget.info['description']}',
                  style: TextStyle(
                    color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: ArabicFonts.Cairo,
                    package: 'google_fonts_arabic',
                  ),
                  textScaleFactor: 1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget PriceBlock() {
    return Container(
      height: MediaQuery.of(context).copyWith().size.height / blockh,
      width:  MediaQuery.of(context).copyWith().size.width,
      child: Card(
        color:themeNotifier.getTheme(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        elevation: 5,
        child: Container(
          height: MediaQuery.of(context).copyWith().size.height,
          width:  MediaQuery.of(context).copyWith().size.width,
          child: Card(
            elevation: 7,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Text(
                'السعر',
                style: TextStyle(
                  color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: ArabicFonts.Cairo,
                  package: 'google_fonts_arabic',
                ),
                textScaleFactor: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget PriceText() {
    return Container(
      height: MediaQuery.of(context).copyWith().size.height / blockh,
      child: Card(
        color:themeNotifier.getTheme(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        elevation: 5,
        child: Container(
          height: MediaQuery.of(context).copyWith().size.height,
          child: Row(
            textDirection: TextDirection.rtl,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).copyWith().size.height,
                width: MediaQuery.of(context).copyWith().size.width-MediaQuery.of(context).copyWith().size.width/2.7-4,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: Text(
                      '${widget.info["price"]}',
                      style: TextStyle(
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black,
                      ),
                    textScaleFactor: 1,
                    ),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).copyWith().size.height,
                width: MediaQuery.of(context).copyWith().size.width/2.8,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: Text(
                      'ليرة سورية',
                      style: TextStyle(
                          color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black,
                          fontFamily: ArabicFonts.Cairo,
                          package: 'google_fonts_arabic',
                          fontWeight: FontWeight.bold),
                      textScaleFactor: 1,
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

  Widget ChatBlock() {
    return Container(
      height: MediaQuery.of(context).copyWith().size.height / blockh,
      child: Card(
        color:themeNotifier.getTheme(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        elevation: 5,
        child: Container(
          height: MediaQuery.of(context).copyWith().size.height,
          child: Card(
            elevation: 7,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Text(
                'مراسلة',
                style: TextStyle(
                  color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: ArabicFonts.Cairo,
                  package: 'google_fonts_arabic',
                ),
                textScaleFactor: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget ChatIcon() {
    return Container(
      height: MediaQuery.of(context).copyWith().size.height / blockh,
      child: Card(
        color: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        elevation: 5,
        child: IconButton(
            icon: Image.asset(
              'images/wh.png',
              width: MediaQuery.of(context).copyWith().size.height / 25,
              height: MediaQuery.of(context).copyWith().size.height / 25,
            ),
            onPressed:() {
              phonenumber=phonenumber.substring(1);
              if (phonenumber=='')setState(() {
              });
              else
              ChatingW('+963$phonenumber');
            }),
      ),
    );
  }

  Widget ConnectBlock() {
    return Container(
      height: MediaQuery.of(context).copyWith().size.height / blockh,
      child: Card(
        color:themeNotifier.getTheme(),
        elevation: 7,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        child: InkWell(
          onTap: () {
            url.launch("tel:$phonenumber");
          },
          child: Center(
              child: Icon(
            Icons.call,
                color:fontColor(themeNotifier.getTheme())?Colors.white:Colors.black,
          )),
        ),
      ),
    );
  }

  ChatingW(String s) async {
    var whatsappUrl = "whatsapp://send?phone=$s";
    await canLaunch(whatsappUrl)
        ? launch(whatsappUrl)
        : print(
            "open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
  }

  var AccountName = "جاري التحميل";
  String phonenumber = '';

  Future getName() async {
    var jsonResponse = null;
    final response2 = await http.post(
        "https://callandbuy.000webhostapp.com/CallAndBuy/GetName.php",
        body: {
          "id": widget.info['id'],
        });
    jsonResponse = json.decode(response2.body);
    if (jsonResponse==false || jsonResponse == null || jsonResponse == {} ){
      setState(() {

      });
    }
    if (jsonResponse!=false){
    Map _data = await jsonResponse;
    if (this.mounted) {
      setState(() {
        AccountName = _data['username'];
        phonenumber = _data['phonenumber'];
      });
    }
    }
  }
}
