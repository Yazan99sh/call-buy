import 'dart:convert';
import 'package:callobuy/Model/Home/HomeScreen.dart';
import 'package:callobuy/View/AboutObject.dart';
import 'package:callobuy/View/Home/PostImage.dart';
import 'package:callobuy/View/Settings/Formates.dart';
import 'package:callobuy/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:http/http.dart' as http;
import '../Home/HomeScreen.dart';

class CatPost extends StatefulWidget {
  Map carinfo;
  String SubCat;

  CatPost(this.carinfo, [this.SubCat]);

  @override
  _CatPostState createState() => _CatPostState();
}

class _CatPostState extends State<CatPost> {
  Future<List> getPosts() async {
    final response = await http.post(
        "https://callandbuy.000webhostapp.com/CallAndBuy/CatPost.php",
        body: {
          'Thingtype': "${widget.carinfo['name']}",
          'Subtype': '${widget.SubCat}',
        });
    var jsonResponse = await json.decode(response.body);
    return jsonResponse;
  }

  @override
  Widget build(BuildContext context) {
    var ncell;
    if (MediaQuery.of(context).copyWith().size.width >= 600) {
      ncell = 4;
    } else
      ncell = 2;
    var rat;
    var ratim;
    if (MediaQuery.of(context).copyWith().size.height < 500) {
      rat = 2.3;
      ratim = 5;
    } else if (MediaQuery.of(context).copyWith().size.height < 580) {
      rat = 2.6;
      ratim = 5;
    } else if (MediaQuery.of(context).copyWith().size.height < 640) {
      rat = 2.7;
      ratim = 4.8;
    } else if (MediaQuery.of(context).copyWith().size.height <= 790) {
      rat = 2.8;
      ratim = 5;
    } else {
      rat = 3.2;
      ratim = 5.2;
    }
    return Scaffold(
        backgroundColor: themeNotifier.getTheme(),
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Center(
                  child: Image.asset(
                '${widget.carinfo['image']}',
                height: MediaQuery.of(context).copyWith().size.height / 2.6,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).copyWith().size.width,
              )),
              Container(
                child: FutureBuilder(
                    future: getPosts(),
                    builder: (_, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          decoration: BoxDecoration(
                            color: themeNotifier.getTheme(),
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(14)),
                          ),
                          height:
                              MediaQuery.of(context).copyWith().size.height /
                                  1.5,
                          margin: EdgeInsets.fromLTRB(
                              0,
                              MediaQuery.of(context).copyWith().size.height /
                                  2.7,
                              0,
                              0),
                          child: Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  fontColor(themeNotifier.getTheme())
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Container(
                          decoration: BoxDecoration(
                            color: themeNotifier.getTheme(),
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(14)),
                          ),
                          height:
                              MediaQuery.of(context).copyWith().size.height /
                                  1.5,
                          margin: EdgeInsets.fromLTRB(
                              0,
                              MediaQuery.of(context).copyWith().size.height /
                                  2.7,
                              0,
                              0),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.perm_scan_wifi,
                                  color: Colors.red,
                                  size: 45,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    width: MediaQuery.of(context)
                                            .copyWith()
                                            .size
                                            .width *
                                        0.25,
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(14)),
                                      onPressed: () {
                                        setState(() {});
                                      },
                                      color: themeNotifier.getbackground(),
                                      elevation: 10,
                                      child: Text(
                                        'تحديث',
                                        style: TextStyle(
                                          color: fontColor(
                                                  themeNotifier.getbackground())
                                              ? Colors.white
                                              : Colors.black,
                                          fontFamily: ArabicFonts.Cairo,
                                          package: 'google_fonts_arabic',
                                        ),
                                        textScaleFactor: 1,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        List content = snapshot.data;
                        if (content.length > 0) {
                          return Container(
                              margin: EdgeInsets.fromLTRB(
                                  0,
                                  MediaQuery.of(context)
                                          .copyWith()
                                          .size
                                          .height /
                                      2.7,
                                  0,
                                  0),
                              width:
                                  MediaQuery.of(context).copyWith().size.width,
                              decoration: BoxDecoration(
                                color: themeNotifier.getTheme(),
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(14)),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      textDirection: TextDirection.rtl,
                                      children: <Widget>[
                                        Center(
                                          child: Text(
                                            '${widget.SubCat}',
                                            style: TextStyle(
                                              color: fontColor(
                                                      themeNotifier.getTheme())
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: ArabicFonts.Cairo,
                                              package: 'google_fonts_arabic',
                                            ),
                                            textScaleFactor: 1,
                                          ),
                                        ),
                                        Expanded(
                                            child: Icon(Icons.category,
                                                color: fontColor(themeNotifier
                                                        .getTheme())
                                                    ? Colors.white
                                                    : Colors.black)),
                                        Center(
                                          child: Text(
                                            '${widget.carinfo['name'] != 'أخرى' ? widget.carinfo['name'] : ''}',
                                            style: TextStyle(
                                              color: fontColor(
                                                      themeNotifier.getTheme())
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: ArabicFonts.Cairo,
                                              package: 'google_fonts_arabic',
                                            ),
                                            textScaleFactor: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GridView.builder(
                                      padding: EdgeInsets.only(top: 0),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              childAspectRatio: MediaQuery.of(
                                                              context)
                                                          .copyWith()
                                                          .size
                                                          .width >=
                                                      600
                                                  ? (MediaQuery.of(context)
                                                              .copyWith()
                                                              .size
                                                              .width /
                                                          4) /
                                                      (MediaQuery.of(context)
                                                              .copyWith()
                                                              .size
                                                              .height /
                                                          3.3)
                                                  : (MediaQuery.of(context)
                                                              .copyWith()
                                                              .size
                                                              .width /
                                                          2) /
                                                      (MediaQuery.of(context)
                                                              .copyWith()
                                                              .size
                                                              .height /
                                                          rat),
                                              crossAxisCount: ncell),
                                      shrinkWrap: true,
                                      itemCount: content.length,
                                      physics: ScrollPhysics(),
                                      itemBuilder: (_, int index) {
                                        Map info = content[index];
                                        return InkWell(
                                          highlightColor: Colors.transparent,
                                          splashColor: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (_) {
                                              return aboutObject(info);
                                            }));
                                          },
                                          child: Stack(
                                            children: <Widget>[
                                              PostImage(
                                                  content[index]['pid'],
                                                  themeNotifier.getTheme(),
                                                  themeNotifier
                                                      .getplaceHolderColor()),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: 130,
                                                    left: 4,
                                                    right: 4),
                                                child: Container(
                                                  height: 100,
                                                  child: Card(
                                                    color: themeNotifier
                                                        .getplaceHolderColor(),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .copyWith()
                                                              .size
                                                              .width,
                                                          child: Directionality(
                                                            textDirection:
                                                                TextDirection
                                                                    .rtl,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          12.0),
                                                              child:
                                                                  SingleChildScrollView(
                                                                scrollDirection:
                                                                    Axis.horizontal,
                                                                child: Text(
                                                                  '${content[index]['title']}',
                                                                  style:
                                                                      TextStyle(
                                                                    color: fontColor(themeNotifier
                                                                            .getplaceHolderColor())
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .black,
                                                                    fontFamily:
                                                                        ArabicFonts
                                                                            .Cairo,
                                                                    package:
                                                                        'google_fonts_arabic',
                                                                    fontSize: MediaQuery.of(context).copyWith().size.height >
                                                                            950
                                                                        ? 20
                                                                        : MediaQuery.of(context).copyWith().size.height >
                                                                                850
                                                                            ? 18
                                                                            : 14,
                                                                  ),
                                                                  textScaleFactor:
                                                                      1,
                                                                  maxLines: 1,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                              right: 8.0,
                                                            ),
                                                            child: Row(
                                                              textDirection:
                                                                  TextDirection
                                                                      .rtl,
                                                              children: <
                                                                  Widget>[
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          5.0),
                                                                  child: Image
                                                                      .asset(
                                                                    'images/global.png',
                                                                    height: MediaQuery.of(context)
                                                                            .copyWith()
                                                                            .size
                                                                            .height /
                                                                        50,
                                                                    color: fontColor(themeNotifier
                                                                            .getplaceHolderColor())
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .black,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  '${content[index]['address']}',
                                                                  textScaleFactor:
                                                                      1,
                                                                  style:
                                                                      TextStyle(
                                                                    color: fontColor(themeNotifier
                                                                            .getplaceHolderColor())
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .black,
                                                                    fontFamily:
                                                                        ArabicFonts
                                                                            .Cairo,
                                                                    package:
                                                                        'google_fonts_arabic',
                                                                    fontSize: MediaQuery.of(context).copyWith().size.height >
                                                                            950
                                                                        ? 18
                                                                        : MediaQuery.of(context).copyWith().size.height >
                                                                                850
                                                                            ? 16
                                                                            : 12,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 8.0),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .bottomRight,
                                                            child: Text(
                                                              "  ${content[index]['price']} ل.س",
                                                              textDirection:
                                                                  TextDirection
                                                                      .rtl,
                                                              style: TextStyle(
                                                                color: fontColor(
                                                                        themeNotifier
                                                                            .getplaceHolderColor())
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black,
                                                                fontFamily:
                                                                    ArabicFonts
                                                                        .Cairo,
                                                                package:
                                                                    'google_fonts_arabic',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: MediaQuery.of(context)
                                                                            .copyWith()
                                                                            .size
                                                                            .height >
                                                                        950
                                                                    ? 18
                                                                    : MediaQuery.of(context).copyWith().size.height >
                                                                            850
                                                                        ? 16
                                                                        : 12,
                                                              ),
                                                              textScaleFactor:
                                                                  1,
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
                                      }),
                                ],
                              ));
                        } else {
                          return Container(
                              height: MediaQuery.of(context)
                                      .copyWith()
                                      .size
                                      .height /
                                  1.5,
                              margin: EdgeInsets.fromLTRB(
                                  0,
                                  MediaQuery.of(context)
                                          .copyWith()
                                          .size
                                          .height /
                                      2.7,
                                  0,
                                  0),
                              decoration: BoxDecoration(
                                color: themeNotifier.getTheme(),
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(14)),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset(
                                      'images/Empty.png',
                                      color: fontColor(themeNotifier.getTheme())
                                          ? Colors.white
                                          : Colors.black,
                                      height: MediaQuery.of(context)
                                              .copyWith()
                                              .size
                                              .height *
                                          0.18,
                                      width: MediaQuery.of(context)
                                              .copyWith()
                                              .size
                                              .width *
                                          0.20,
                                    ),
                                    Text(
                                      'لا يوجد معروضات ',
                                      style: TextStyle(
                                          color: fontColor(
                                                  themeNotifier.getTheme())
                                              ? Colors.white
                                              : Colors.black,
                                          fontFamily: ArabicFonts.Cairo,
                                          package: 'google_fonts_arabic',
                                          fontWeight: FontWeight.bold),
                                      textScaleFactor: 1,
                                    ),
                                  ],
                                ),
                              ));
                        }
                      }
                    }),
              ),
              SafeArea(
                  top: true,
                  child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: widget.carinfo['color'],
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      })),
            ],
          ),
        ));
  }
}
