import 'package:callobuy/Model/Home/HomeScreen.dart';
import 'package:callobuy/View/AboutObject.dart';
import 'package:callobuy/View/Home/SearchImage.dart';
import 'package:callobuy/View/Settings/Formates.dart';
import 'package:callobuy/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'dart:core';

class Searching extends StatefulWidget {
  @override
  _SearchingState createState() => _SearchingState();
}

class _SearchingState extends State<Searching> {
  var site = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var category = 'الكل';
  var subcategory='';
  var price = 'كل الأسعار';
  var FromePrice = TextEditingController();
  var ToPrice = TextEditingController();
  var Thingtype='';
  var categoryHead = [
    'الكل',
    'أجهزة إلكترونية',
    'أجهزة كهربائية',
    'مفروشات',
    'ملابس',
    'عقارات',
    'عربات نقل',
    'أخرى',
  ];
  var categorycontent = {
    'الكل': [],
    'أجهزة إلكترونية': [
      'هواتف محمولة',
      'لابتوبات',
      'إكسسوارات',
      'حواسيب',
      'شاشات',
      'أخرى'
    ],
    'أجهزة كهربائية': ['غسالات', 'برادات', 'مكيفات', 'سخانات', 'أفران', 'أخرى'],
    'مفروشات': ['أسّرة', 'صوفات', 'برادي', 'سجاد', 'أدوات مطبخ', 'أخرى'],
    'ملابس': [
      'ملابس ولادي',
      'ملابس نسواني',
      'ملابس رجالي',
      'أحذية ولادي',
      'أحذية نسواني',
      'أحذية رجالي',
      'أخرى'
    ],
    'عقارات': ['مزارع', 'منازل', 'محال تجارية', 'أخرى'],
    'عربات نقل': [
      'شاحنات',
      'دراجات هوائية',
      'دراجات نارية',
      'دراجات كهربائية',
      'أخرى'
    ],
    'أخرى': []
  };
  var sorttype="ترتيب بحسب التاريخ من الأقدم للأحدث";
  var search = new TextEditingController();
  List SortTypes=['ترتيب بحسب التاريخ من الأقدم للأحدث','ترتيب بحسب التاريخ من الأحدث للأقدم','ترتيب بحسب السعر من الأرخص للأغلى','ترتيب بحسب السعر من الأغلى للأرخص',];
  bool val = false;
bool filter=false;
  @override
  Widget build(BuildContext context) {
    //this variable for define font size for searching
    var sfont;

    if (MediaQuery.of(context).copyWith().textScaleFactor > 1.5) {
      sfont = 8.0;
    } else if (MediaQuery.of(context).copyWith().textScaleFactor > 1) {
      sfont = 12.0;
    } else {
      sfont = 16.0;
    }
    var sh;
    //this variable for define height size for searching block
    var cellheight;
    if (MediaQuery.of(context).copyWith().size.height > 1000) {
      sh = MediaQuery.of(context).copyWith().size.height / 33;
      cellheight = 8;
    } else if (MediaQuery.of(context).copyWith().size.height > 790) {
      sh = MediaQuery.of(context).copyWith().size.height / 20;
      cellheight = 8;
    } else if (MediaQuery.of(context).copyWith().size.height < 500) {
      sh = MediaQuery.of(context).copyWith().size.height / 10;
      cellheight = 4.5;
    } else if (MediaQuery.of(context).copyWith().size.height < 580) {
      sh = MediaQuery.of(context).copyWith().size.height / 14.5;
      cellheight = 5.5;
    } else if (MediaQuery.of(context).copyWith().size.height < 640) {
      sh = MediaQuery.of(context).copyWith().size.height / 15;
      cellheight = 5.5;
    } else {
      sh = MediaQuery.of(context).copyWith().size.height / 17;
      cellheight = 7.5;
    }
    return Scaffold(
      endDrawer: Directionality(
        textDirection: TextDirection.rtl,
        child: Drawer(
          child: Container(
            color: themeNotifier.getbackground(),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Text(
                            'تخصيص البحث',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: ArabicFonts.Cairo,
                              package: 'google_fonts_arabic',
                              color: fontColor(themeNotifier.getTheme())
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            textScaleFactor: 1,
                          ),
                        ),
                        Expanded(
                            child: Row(
                          children: <Widget>[
                            Expanded(
                                child: Align(
                              alignment: Alignment.bottomRight,
                              child: InkWell(
                                onTap: (){
                                  setState(() {
                                    price='كل الأسعار';
                                    search.clear();
                                    val=false;
                                    subcategory='';
                                    category='الكل';
                                    FromePrice.clear();
                                    ToPrice.clear();
                                    site.clear();
                                    filter=false;
                                    sorttype="ترتيب بحسب التاريخ من الأقدم للأحدث";
                                    Thingtype='';
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'تهيئة',
                                  style: TextStyle(
                                    fontFamily: ArabicFonts.Cairo,
                                    package: 'google_fonts_arabic',
                                    color: fontColor(themeNotifier.getTheme())
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  textScaleFactor: 1,
                                ),
                              ),
                            )),
                            Expanded(
                                child: Align(
                              alignment: Alignment.bottomLeft,
                              child: InkWell(
                                  onTap: (){
                                    setState(() {
                                      filter=true;
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  child: Icon(
                                    Icons.check,
                                    color: fontColor(themeNotifier.getTheme())
                                        ? Colors.white
                                        : Colors.black,
                                  )),
                            )),
                          ],
                        ))
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: themeNotifier.getTheme(),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'الكلمة المفتاحية',
                      style: TextStyle(
                        color: fontColor(themeNotifier.getbackground())
                            ? Colors.white
                            : Colors.black,
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                      ),
                      textScaleFactor: 1,
                    ),
                    subtitle: Column(
                      children: <Widget>[
                        TextField(
                          controller:search,
                          cursorColor: themeNotifier.getTheme(),
                          style: TextStyle(
                            color: fontColor(themeNotifier.getbackground())
                                ? Colors.white
                                : Colors.black,
                            fontFamily: ArabicFonts.Cairo,
                            package: 'google_fonts_arabic',
                            fontSize: sfont-4
                          ),
                          decoration: InputDecoration(
                            hintText: 'مثال : براد',
                            hintStyle: TextStyle(
                                color: fontColor(themeNotifier.getbackground())
                                    ? Colors.white54
                                    : Colors.black54,
                                fontFamily: ArabicFonts.Cairo,
                                package: 'google_fonts_arabic',
                                fontSize: sfont-4),
                            errorStyle: TextStyle(
                                fontFamily: ArabicFonts.Cairo,
                                package: 'google_fonts_arabic',
                                fontSize: sfont / 1.1),
                          ),
                        ),
                      Row(
                        children: <Widget>[
                          Checkbox(
                              value: val,
                              onChanged: (bool vale) {
                                setState(() {
                                  val = vale;
                                });
                              }),
                          Text('البحث عن طريق المقدمة و الوصف ',style:TextStyle(
                            color: fontColor(themeNotifier.getbackground())
                                ? Colors.white54
                                : Colors.black54,
                            fontFamily: ArabicFonts.Cairo,
                            package: 'google_fonts_arabic',
                            fontSize:12,
                          ),textScaleFactor: 1,),
                        ],
                      )
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'الموقع',
                      style: TextStyle(
                        color: fontColor(themeNotifier.getbackground())
                            ? Colors.white
                            : Colors.black,
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                      ),
                      textScaleFactor: 1,
                    ),
                    subtitle: TextField(
                      style: TextStyle(
                        fontSize: sfont-4,
                        color: fontColor(themeNotifier.getbackground())
                            ? Colors.white
                            : Colors.black,
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                      ),
                      controller: site,
                      cursorColor: themeNotifier.getTheme(),
                      decoration: InputDecoration(
                        hintText: 'مثال : حماه',
                        hintStyle: TextStyle(
                            color: fontColor(themeNotifier.getbackground())
                                ? Colors.white54
                                : Colors.black54,
                            fontFamily: ArabicFonts.Cairo,
                            package: 'google_fonts_arabic',
                            fontSize: sfont-4),
                        errorStyle: TextStyle(
                            color: fontColor(themeNotifier.getbackground())
                                ? Colors.white54
                                : Colors.black54,
                            fontFamily: ArabicFonts.Cairo,
                            package: 'google_fonts_arabic',
                            fontSize: sfont-4),
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'الفئة',
                      style: TextStyle(
                        color: fontColor(themeNotifier.getbackground())
                            ? Colors.white
                            : Colors.black,
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                      ),
                      textScaleFactor: 1,
                    ),
                    subtitle: Text(
                      '$category',
                      style: TextStyle(
                        color: fontColor(themeNotifier.getbackground())
                            ? Colors.white54
                            : Colors.black54,
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                        fontSize: 12,
                      ),
                      textScaleFactor: 1,
                    ),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return Directionality(
                              textDirection: TextDirection.rtl,
                              child: AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14)),
                                backgroundColor: themeNotifier.getbackground(),
                                content: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.55,
                                  width: MediaQuery.of(context).size.width * 0.75,
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: categoryHead.length,
                                    itemBuilder: (_, key) {
                                      return Column(
                                        children: <Widget>[
                                          ListTile(
                                            onTap: () {
                                                    setState(() {
                                                      category =
                                                          categoryHead[key];
                                                      Thingtype=categoryHead[key];
                                                      if (category=='الكل')Thingtype='';
                                                      Navigator.of(context).pop();
                                                    });
                                                  }
                                                ,
                                            title: Text(
                                              '${categoryHead[key]}',
                                              style: TextStyle(
                                                color: fontColor(themeNotifier
                                                        .getbackground())
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: ArabicFonts.Cairo,
                                                package: 'google_fonts_arabic',
                                                fontSize: 16,
                                              ),
                                              textScaleFactor: 1,
                                            ),
                                          ),
                                          ListView.builder(
                                              padding: EdgeInsets.zero,
                                              shrinkWrap: true,
                                              physics: ScrollPhysics(),
                                              itemCount: categorycontent[
                                                      categoryHead[key]]
                                                  .length,
                                              itemBuilder: (_, index) {
                                                return ListTile(
                                                  onTap: () {
                                                    setState(() {
                                                      subcategory=categorycontent[categoryHead[key]][index];
                                                      category =
                                                          '${categoryHead[key]} | ${categorycontent[categoryHead[key]][index]}';
                                                    });
                                                    Navigator.of(context).pop();
                                                  },
                                                  title: Text(
                                                    '${categorycontent[categoryHead[key]][index]}',
                                                    style: TextStyle(
                                                      color: fontColor(
                                                              themeNotifier
                                                                  .getbackground())
                                                          ? Colors.white54
                                                          : Colors.black54,
                                                      fontFamily:
                                                          ArabicFonts.Cairo,
                                                      package:
                                                          'google_fonts_arabic',
                                                    ),
                                                    textScaleFactor: 1,
                                                  ),
                                                );
                                              })
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                  ),
                  ListTile(
                    title: Text(
                      'السعر',
                      style: TextStyle(
                        color: fontColor(themeNotifier.getbackground())
                            ? Colors.white
                            : Colors.black,
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                      ),
                      textScaleFactor: 1,
                    ),
                    subtitle: Text(
                      '$price',
                      style: TextStyle(
                        color: fontColor(themeNotifier.getbackground())
                            ? Colors.white54
                            : Colors.black54,
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                      ),
                      textScaleFactor: 1,
                    ),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        if (FromePrice.text.isNotEmpty &&
                                            ToPrice.text.isEmpty) {
                                          setState(() {
                                            price =
                                                'من ${FromePrice.text} إلى أكبر سعر ';
                                          });
                                        } else if (ToPrice.text.isNotEmpty &&
                                            FromePrice.text.isEmpty) {
                                          setState(() {
                                            price =
                                                'من أقل سعر إلى ${ToPrice.text}';
                                          });
                                        } else if (ToPrice.text.isEmpty &&
                                            FromePrice.text.isEmpty) {
                                          setState(() {
                                            price = 'كل الأسعار';
                                          });
                                        } else {
                                          setState(() {
                                            price =
                                                'من ${FromePrice.text} إلى ${ToPrice.text}';
                                          });
                                        }
                                        Navigator.of(context).pop();
                                      }
                                    },
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
                                    )),
                                FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'إلغاء',
                                      style: TextStyle(
                                        color: fontColor(
                                                themeNotifier.getbackground())
                                            ? Colors.white
                                            : Colors.black,
                                        fontFamily: ArabicFonts.Cairo,
                                        package: 'google_fonts_arabic',
                                      ),
                                      textScaleFactor: 1,
                                    )),
                              ],
                              content: Container(
                                  width: MediaQuery.of(context).size.width * 0.70,
                                  height:
                                      MediaQuery.of(context).size.height * 0.20,
                                  child: Center(
                                    child: Form(
                                      key: _formKey,
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            'السعر',
                                            style: TextStyle(
                                              color: fontColor(themeNotifier
                                                      .getbackground())
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontFamily: ArabicFonts.Cairo,
                                              package: 'google_fonts_arabic',
                                            ),
                                            textScaleFactor: 1,
                                          ),
                                          Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  width: (MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.70) /
                                                      2.2,
                                                  child: ListTile(
                                                    title: Text(
                                                      'من',
                                                      style: TextStyle(
                                                        color: fontColor(
                                                                themeNotifier
                                                                    .getbackground())
                                                            ? Colors.white
                                                            : Colors.black,
                                                        fontFamily:
                                                            ArabicFonts.Cairo,
                                                        package:
                                                            'google_fonts_arabic',
                                                      ),
                                                      textScaleFactor: 1,
                                                    ),
                                                    subtitle: Container(
                                                      width:
                                                          (MediaQuery.of(context)
                                                                      .size
                                                                      .width *
                                                                  0.70) /
                                                              2,
                                                      child: TextFormField(
                                                        style: TextStyle(
                                                          fontSize: sfont,
                                                          color: fontColor(themeNotifier.getbackground())
                                                              ? Colors.white
                                                              : Colors.black,
                                                          fontFamily: ArabicFonts.Cairo,
                                                          package: 'google_fonts_arabic',
                                                        ),
                                                        cursorColor: themeNotifier
                                                            .getTheme(),
                                                        controller: FromePrice,
                                                        validator: (value) {
                                                          if (value.isNotEmpty &&
                                                              ToPrice.text
                                                                  .isNotEmpty) {
                                                            if (int.parse(
                                                                    value) >=
                                                                int.parse(ToPrice
                                                                    .text
                                                                    .toString()))
                                                              return 'قيمة غير صالحة';
                                                            else
                                                              return null;
                                                          } else
                                                            return null;
                                                        },
                                                        keyboardType:
                                                            TextInputType.number,
                                                        decoration: InputDecoration(
                                                            hintText:
                                                                'الحد الأدنى',
                                                            hintStyle: TextStyle(
                                                                color: fontColor(
                                                                        themeNotifier
                                                                            .getbackground())
                                                                    ? Colors
                                                                        .white54
                                                                    : Colors
                                                                        .black54,
                                                                fontFamily:
                                                                    ArabicFonts
                                                                        .Cairo,
                                                                package:
                                                                    'google_fonts_arabic',
                                                                fontSize: sfont),
                                                            errorStyle: TextStyle(
                                                                fontFamily:
                                                                    ArabicFonts
                                                                        .Cairo,
                                                                package:
                                                                    'google_fonts_arabic',
                                                                fontSize:
                                                                    sfont / 1.1)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: (MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.70) /
                                                      2.2,
                                                  child: ListTile(
                                                    title: Text(
                                                      'إلى',
                                                      style: TextStyle(
                                                        color: fontColor(
                                                                themeNotifier
                                                                    .getbackground())
                                                            ? Colors.white
                                                            : Colors.black,
                                                        fontFamily:
                                                            ArabicFonts.Cairo,
                                                        package:
                                                            'google_fonts_arabic',
                                                      ),
                                                      textScaleFactor: 1,
                                                    ),
                                                    subtitle: Container(
                                                      width:
                                                          (MediaQuery.of(context)
                                                                      .size
                                                                      .width *
                                                                  0.70) /
                                                              2.2,
                                                      child: TextFormField(
                                                        style: TextStyle(
                                                          fontSize: sfont,
                                                          color: fontColor(themeNotifier.getbackground())
                                                              ? Colors.white
                                                              : Colors.black,
                                                          fontFamily: ArabicFonts.Cairo,
                                                          package: 'google_fonts_arabic',
                                                        ),
                                                        cursorColor: themeNotifier
                                                            .getTheme(),
                                                        controller: ToPrice,
                                                        validator: (value) {
                                                          if (value.isNotEmpty &&
                                                              FromePrice.text
                                                                  .isNotEmpty) {
                                                            if (int.parse(
                                                                    value) <=
                                                                int.parse(
                                                                    FromePrice
                                                                        .text))
                                                              return 'قيمة غير صالحة';
                                                            else
                                                              return null;
                                                          } else
                                                            return null;
                                                        },
                                                        keyboardType:
                                                            TextInputType.number,
                                                        decoration: InputDecoration(
                                                            hintText:
                                                                'الحد الأعلى',
                                                            errorStyle: TextStyle(
                                                                fontFamily:
                                                                    ArabicFonts
                                                                        .Cairo,
                                                                package:
                                                                    'google_fonts_arabic',
                                                                fontSize:
                                                                    sfont / 1.1),
                                                            hintStyle: TextStyle(
                                                                color: fontColor(
                                                                        themeNotifier
                                                                            .getbackground())
                                                                    ? Colors
                                                                        .white54
                                                                    : Colors
                                                                        .black54,
                                                                fontFamily:
                                                                    ArabicFonts
                                                                        .Cairo,
                                                                package:
                                                                    'google_fonts_arabic',
                                                                fontSize: sfont)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                            );
                          });
                    },
                  ),
                  ListTile(
                    title: Text(
                      'الترتيب',
                      style: TextStyle(
                        color: fontColor(themeNotifier.getbackground())
                            ? Colors.white
                            : Colors.black,
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                      ),
                      textScaleFactor: 1,
                    ),
                    subtitle: Text(
                      '$sorttype',
                      style: TextStyle(
                        color: fontColor(themeNotifier.getbackground())
                            ? Colors.white54
                            : Colors.black54,
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                        fontSize: 12,
                      ),
                      textScaleFactor: 1,
                    ),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return Directionality(
                              textDirection: TextDirection.rtl,
                              child: AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14)),
                                backgroundColor: themeNotifier.getbackground(),
                                title: Center(
                                  child: Text(
                                    'اختر نوع الترتيب',
                                    style: TextStyle(
                                      color: fontColor(themeNotifier.getbackground())
                                          ? Colors.white
                                          : Colors.black,
                                      fontFamily: ArabicFonts.Cairo,
                                      package: 'google_fonts_arabic',
                                    ),
                                    textScaleFactor: 1,
                                  ),
                                ),
                                content: Container(
                                  height:
                                  MediaQuery.of(context).size.height * 0.30,
                                  width: MediaQuery.of(context).size.width * 0.75,
                                  child: ListView.builder(
                                    itemCount: SortTypes.length,
                                    padding: EdgeInsets.zero,
                                  itemBuilder: (_,index){
                                   return ListTile(
                                      onTap:(){
                                        setState(() {
                                          sorttype=SortTypes[index];
                                        });
                                        Navigator.of(context).pop();
                                      },
                                      title: Text(
                                        '${SortTypes[index]}',
                                        style: TextStyle(
                                          color: fontColor(themeNotifier.getbackground())
                                              ? Colors.white
                                              : Colors.black,
                                          fontFamily: ArabicFonts.Cairo,
                                          package: 'google_fonts_arabic',
                                        ),
                                        textScaleFactor: 1,
                                      ),
                                    );

                                  },
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
//            leading: Builder(builder: (cont) {
//              return IconButton(
//                icon: Image.asset(
//                  'images/interface.png',
//                  width: MediaQuery.of(context).size.width * 0.05,
//                  color: fontColor(themeNotifier.getTheme())
//                      ? Colors.white
//                      : Colors.black,
//                ),
//                onPressed: () => Scaffold.of(cont).openDrawer(),
//              );
//            }),
          actions: <Widget>[
            Builder(builder: (cont) {
              return IconButton(
                tooltip: 'تخصيصات',
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                icon: Image.asset(
                  'images/interface.png',
                  width: MediaQuery.of(context).size.width * 0.045,
                  color: fontColor(themeNotifier.getTheme())
                      ? Colors.white
                      : Colors.black,
                ),
                onPressed: () => Scaffold.of(cont).openEndDrawer(),
              );
            }),
          ],
            pinned: false,
            floating: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.elliptical(MediaQuery.of(context).size.width,
                      MediaQuery.of(context).size.height / 30)),
            ),
            title: Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                height: sh,
                width: MediaQuery.of(context).copyWith().size.width,
                child: TextField(
                  cursorColor: themeNotifier.getTheme(),
                  textInputAction: TextInputAction.go,
                  controller: search,
                  autofocus: true,
                  style: TextStyle(
                    fontFamily: ArabicFonts.Cairo,
                    package: 'google_fonts_arabic',
                    fontSize: sfont,
                    color: fontColor(themeNotifier.getbackground())
                        ? Colors.white
                        : Colors.black,
                  ),
                  //textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                    hasFloatingPlaceholder: false,
                    hintText: 'مثال : براد',
                    hintStyle: TextStyle(
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                        color: fontColor(themeNotifier.getbackground())
                            ? Colors.white
                            : Colors.black54,
                        fontSize: sfont),
                    filled: true,
                    fillColor: themeNotifier.getbackground(),
                    suffixIcon: Icon(
                      Icons.search,
                    ),
                    contentPadding: EdgeInsets.all(5),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: themeNotifier.getTheme()),
                        borderRadius: BorderRadius.circular(14)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: themeNotifier.getTheme()),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide:
                            BorderSide(color: themeNotifier.getTheme())),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            FutureBuilder(
                future: Search(search.text,filter,val,subcategory,FromePrice.text,ToPrice.text,site.text,sorttype,Thingtype),
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      height: MediaQuery.of(context).copyWith().size.height,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else if (snapshot.hasError) {
                    return Container(
                      height: MediaQuery.of(context).copyWith().size.height,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.perm_scan_wifi,
                              color: Colors.red,
                              size: MediaQuery.of(context).size.height / 6,
                            ),
                            Container(
                              height: MediaQuery.of(context)
                                      .copyWith()
                                      .size
                                      .height /
                                  20,
                              width:
                                  MediaQuery.of(context).copyWith().size.width /
                                      3,
                              child: RaisedButton(
                                onPressed: () {
                                  setState(() {});
                                },
                                color: themeNotifier.getTheme(),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14)),
                                child: Text(
                                  'إعادة التحميل',
                                  style: TextStyle(
                                    color: fontColor(themeNotifier.getTheme())
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  textScaleFactor: 1,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  } else {
                    List content = snapshot.data;
                    if (content != null) {
                      return ListView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.only(top: 0),
                          itemCount: content.length,
                          itemBuilder: (_, index) {
                            return Container(
                              width:
                                  MediaQuery.of(context).copyWith().size.width,
                              height: MediaQuery.of(context)
                                      .copyWith()
                                      .size
                                      .height /
                                  cellheight,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) {
                                    Map info = content[index];
                                    return aboutObject(info);
                                  }));
                                },
                                borderRadius: BorderRadius.circular(14),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  color: themeNotifier.getTheme(),
                                  child: Row(
                                    textDirection: TextDirection.rtl,
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          textDirection: TextDirection.rtl,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 5.0),
                                                  child: Text(
                                                    '${content[index]['title']}',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          ArabicFonts.Cairo,
                                                      package:
                                                          'google_fonts_arabic',
                                                      fontSize: MediaQuery.of(
                                                                      context)
                                                                  .copyWith()
                                                                  .size
                                                                  .height >
                                                              950
                                                          ? 20
                                                          : MediaQuery.of(context)
                                                                      .copyWith()
                                                                      .size
                                                                      .height >
                                                                  850
                                                              ? 18
                                                              : 14,
                                                      color: fontColor(
                                                              themeNotifier
                                                                  .getTheme())
                                                          ? Colors.white
                                                          : Colors.black,
                                                    ),
                                                    textScaleFactor: 1,
                                                    textDirection:
                                                        TextDirection.rtl,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Center(
                                                child: Row(
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5.0,
                                                              right: 5),
                                                      child: Image.asset(
                                                        'images/global.png',
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .copyWith()
                                                                .size
                                                                .height /
                                                            45,
                                                        color: fontColor(
                                                                themeNotifier
                                                                    .getTheme())
                                                            ? Colors.white
                                                            : Colors.black,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${content[index]['address']}',
                                                      textScaleFactor: 1,
                                                      style: TextStyle(
                                                        color: fontColor(
                                                                themeNotifier
                                                                    .getTheme())
                                                            ? Colors.white
                                                            : Colors.black,
                                                        fontFamily:
                                                            ArabicFonts.Cairo,
                                                        package:
                                                            'google_fonts_arabic',
                                                        fontSize: MediaQuery.of(
                                                                        context)
                                                                    .copyWith()
                                                                    .size
                                                                    .height >
                                                                950
                                                            ? 18
                                                            : MediaQuery.of(context)
                                                                        .copyWith()
                                                                        .size
                                                                        .height >
                                                                    850
                                                                ? 16
                                                                : 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: Text(
                                                "  ${content[index]['price']} ل.س",
                                                style: TextStyle(
                                                  fontFamily: ArabicFonts.Cairo,
                                                  package:
                                                      'google_fonts_arabic',
                                                  color: fontColor(themeNotifier
                                                          .getTheme())
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontSize: MediaQuery.of(
                                                                  context)
                                                              .copyWith()
                                                              .size
                                                              .height >
                                                          950
                                                      ? 18
                                                      : MediaQuery.of(context)
                                                                  .copyWith()
                                                                  .size
                                                                  .height >
                                                              850
                                                          ? 16
                                                          : 12,
                                                ),
                                                textDirection:
                                                    TextDirection.rtl,
                                                textScaleFactor: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_upward,
                                        color:
                                            fontColor(themeNotifier.getTheme())
                                                ? Colors.white
                                                : Colors.black,
                                      ),
                                      Container(
                                        height: MediaQuery.of(context)
                                            .copyWith()
                                            .size
                                            .height,
                                        width: MediaQuery.of(context)
                                                .copyWith()
                                                .size
                                                .width /
                                            3.3,
                                        child: Card(
                                          color: themeNotifier
                                              .getplaceHolderColor(),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            child: SearchImage(
                                                content[index]['pid']),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    } else
                      return Center(
                        child: Image.asset(
                          'images/notfound.png',
                          height: MediaQuery.of(context).size.height / 5.5,
                        ),
                      );
                  }
                }),
          ]))
        ],
      ),
    );
  }
}
