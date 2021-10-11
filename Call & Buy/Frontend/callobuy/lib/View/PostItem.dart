import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:callobuy/View/PageViews.dart';
import 'package:callobuy/View/Settings/Formates.dart';
import 'package:callobuy/main.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:core';
import 'package:multi_media_picker/multi_media_picker.dart';

class PostItem extends StatefulWidget {
  Map inti;

  @override
  _PostItemState createState() => _PostItemState();

  PostItem([this.inti]);
}

class _PostItemState extends State<PostItem> {
  bool isLoading=false;
  String dropdownValue = 'أخرى';
  bool f = false;
  String dropdownSubValue = 'أخرى';
  bool f2 = false;
  var descriptionText = TextEditingController();
  var PriceText = TextEditingController();
  var titleText = TextEditingController();
  var addressText = TextEditingController();
  var rat;
  @override
  Widget build(BuildContext context) {

    if (MediaQuery.of(context).size.height<450)rat=8;
      else rat=12;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Call & Buy',
          textScaleFactor: 1,
          style: TextStyle(
            fontFamily: ArabicFonts.Cairo,
            package: 'google_fonts_arabic',
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
              bottom: Radius.elliptical(MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height / 30)),
        ),
        centerTitle: true,
      ),
      body:isLoading==false?Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          children: <Widget>[
            widget.inti == null ? PickImage() : Container(),
            ThingType(),
            f == false || dropdownValue=='أخرى' ? Container() : SubThingType(),
            AddressField(),
            TitleField(),
            DescribtionField(),
            PriceField(),
            ResetOrPostB(),
          ],
        ),
      ):Container(
        color: themeNotifier.getbackground(),
        width:MediaQuery.of(context).size.width,
        height:MediaQuery.of(context).size.height,
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('images/logo.png',color: themeNotifier.getTheme(),width: MediaQuery.of(context).copyWith().size.width/2.5,
              height:MediaQuery.of(context).copyWith().size.width/2.5,),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }

  handle() {
    if (widget.inti != null) {
      titleText.text = '${widget.inti['title']}';
      descriptionText.text = '${widget.inti['description']}';
      PriceText.text = '${widget.inti['price']}';
    }
  }

  Map subtype = {
    'مفروشات': ['أسّرة', 'صوفات', 'برادي', 'سجاد', 'أدوات مطبخ', 'أخرى'],
    'أجهزة كهربائية': ['غسالات', 'برادات', 'مكيفات', 'سخانات', 'أفران', 'أخرى'],
    'أجهزة إلكترونية': [
      'هواتف محمولة',
      'لابتوبات',
      'إكسسوارات',
      'حواسيب',
      'شاشات',
      'أخرى'
    ],
    'ملابس': [
      'ملابس ولادي',
      'ملابس نسواني',
      'ملابس رجالي',
      'أحذية ولادي',
      'أحذية نسواني',
      'أحذية رجالي',
      'أخرى'
    ],
    'عربات نقل': [
      'شاحنات',
      'دراجات هوائية',
      'دراجات نارية',
      'دراجات كهربائية',
      'أخرى'
    ],
    'عقارات': ['مزارع', 'منازل', 'محال تجارية', 'أخرى'],
    'أخرى': ['أخرى'],
  };

  Widget PickImage() {
    return Container(
      height: MediaQuery.of(context).copyWith().size.height / rat,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        color: themeNotifier.getTheme(),
        child: Row(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).copyWith().size.height,
              width: MediaQuery.of(context).copyWith().size.width / 3.5,
              child: Card(
                elevation: 7,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Text(
                    "اختر صورة",
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
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: _images == null ||_images.length==0
                    ? () {
                        getImage();
                      }
                    : null,
                child: Container(
                  height: MediaQuery.of(context).copyWith().size.height,
                  child: _images == null
                      ? Center(
                          child: Icon(
                            Icons.add,
                            color: fontColor(themeNotifier.getTheme())
                                ? Colors.white
                                : Colors.black,
                          ),
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'تم اختيار  ${_images.length} صور',
                              style: TextStyle(
                                fontFamily: ArabicFonts.Cairo,
                                package: 'google_fonts_arabic',
                                fontWeight: FontWeight.bold,
                              ),
                              textScaleFactor: 1,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: Icon(
                                Icons.check_circle,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget ThingType() {
    return Container(
      height: MediaQuery.of(context).copyWith().size.height / rat,
      child: Card(
        elevation: 5,
        color: themeNotifier.getTheme(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).copyWith().size.height,
              width: MediaQuery.of(context).copyWith().size.width / 3.5,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                elevation: 7,
                child: Center(
                    child: Text(
                  'النوع',
                  style: TextStyle(
                    fontFamily: ArabicFonts.Cairo,
                    package: 'google_fonts_arabic',
                    color: fontColor(themeNotifier.getbackground())
                        ? Colors.white
                        : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textScaleFactor: 1,
                )),
              ),
            ),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).copyWith().size.height,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 7,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 32, right: 32),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          canvasColor: themeNotifier.getbackground(),
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          hint: Text(
                            widget.inti == null
                                ? "اضغط للإختيار"
                                : "${widget.inti['Thingtype']}",
                            style: TextStyle(
                              fontFamily: ArabicFonts.Cairo,
                              package: 'google_fonts_arabic',
                              color: fontColor(themeNotifier.getbackground())
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            textScaleFactor: 1,
                          ),
                          value: f == false ? null : dropdownValue,
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: themeNotifier.getTheme(),
                          ),
                          iconSize: 20,
                          elevation: 16,
                          style: TextStyle(
                            color: fontColor(themeNotifier.getTheme())
                                ? Colors.white
                                : Colors.black,
                            fontFamily: ArabicFonts.Cairo,
                            fontWeight: FontWeight.bold,
                            package: 'google_fonts_arabic',
                          ),
                          underline: Container(
                            height: 0,
                            width: 0,
                            color: themeNotifier.getTheme(),
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              f = true;
                              dropdownValue = newValue;
                            });
                          },
                          items: <String>[
                            'مفروشات',
                            'أجهزة كهربائية',
                            'أجهزة إلكترونية',
                            'ملابس',
                            'عربات نقل',
                            'عقارات',
                            'أخرى'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                textDirection: TextDirection.rtl,
                                textScaleFactor: 1,
                                style: TextStyle(
                                  color:
                                      fontColor(themeNotifier.getbackground())
                                          ? Colors.white
                                          : Colors.black,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
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

  Widget SubThingType() {
    return Container(
      height: MediaQuery.of(context).copyWith().size.height / rat,
      child: Card(
        elevation: 5,
        color: themeNotifier.getTheme(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).copyWith().size.height,
              width: MediaQuery.of(context).copyWith().size.width / 3.5,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                elevation: 7,
                child: Center(
                    child: Text(
                  'الفئة',
                  style: TextStyle(
                    fontFamily: ArabicFonts.Cairo,
                    package: 'google_fonts_arabic',
                    color: fontColor(themeNotifier.getbackground())
                        ? Colors.white
                        : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textScaleFactor: 1,
                )),
              ),
            ),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).copyWith().size.height,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 7,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 32, right: 32),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          canvasColor: themeNotifier.getbackground(),
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          hint: Text(
                            widget.inti == null
                                ? "اضغط للإختيار"
                                : "${widget.inti['Thingtype']}",
                            style: TextStyle(
                              fontFamily: ArabicFonts.Cairo,
                              package: 'google_fonts_arabic',
                              color: fontColor(themeNotifier.getbackground())
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            textScaleFactor: 1,
                          ),
                          value: f2 == false ? null : dropdownSubValue,
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: themeNotifier.getTheme(),
                          ),
                          iconSize: 20,
                          elevation: 16,
                          style: TextStyle(
                            color: fontColor(themeNotifier.getbackground())
                                ? Colors.white
                                : Colors.black,
                            fontFamily: ArabicFonts.Cairo,
                            fontWeight: FontWeight.bold,
                            package: 'google_fonts_arabic',
                          ),
                          underline: Container(
                            height: 0,
                            width: 0,
                            color: themeNotifier.getTheme(),
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              f2 = true;
                              dropdownSubValue = newValue;
                            });
                          },
                          items: subtype[dropdownValue]
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                textDirection: TextDirection.rtl,
                                textScaleFactor: 1,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
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

  final focus = FocusNode();
  final focus2 = FocusNode();
  final focus1 = FocusNode();

  Widget AddressField() {
    var fnt;
    if (MediaQuery.of(context).textScaleFactor < 2.0 &&
        MediaQuery.of(context).textScaleFactor > 1.0) {
      fnt = 13.5;
    } else if (MediaQuery.of(context).textScaleFactor > 1.5) {
      fnt = 10.0;
    } else {
      fnt = 16.0;
    }
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextFormField(
        key: _addressKey,
        validator: (value) {
          if (value.isEmpty) {
            return 'الرجاء ملئ الحقل بالمطلوب';
          } else
            return null;
        },
        style: TextStyle(
            color: fontColor(themeNotifier.getbackground())
                ? Colors.white
                : Colors.black,
            fontFamily: ArabicFonts.Cairo,
            package: 'google_fonts_arabic',
            fontWeight: FontWeight.bold,
            fontSize: fnt),
        maxLength: 10,
        maxLines: 1,
        onFieldSubmitted: (v) {
          FocusScope.of(context).requestFocus(focus1);
        },
        controller: addressText,
        cursorColor: themeNotifier.getTheme(),
        textDirection: TextDirection.rtl,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(
                  color: fontColor(themeNotifier.getbackground())
                      ? Colors.white54
                      : Colors.black54,
                )),
            hintText: 'الموقع',
            helperText: 'الموقع',
            helperStyle: TextStyle(
              fontFamily: ArabicFonts.Cairo,
              package: 'google_fonts_arabic',
              color: fontColor(themeNotifier.getbackground())
                  ? Colors.white54
                  : Colors.black54,
              fontSize: 8,
            ),
            hintStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: ArabicFonts.Cairo,
              package: 'google_fonts_arabic',
              color: fontColor(themeNotifier.getbackground())
                  ? Colors.white54
                  : Colors.black54,
            )),
      ),
    );
  }

  Widget TitleField() {
    var fnt;
    if (MediaQuery.of(context).textScaleFactor < 2.0 &&
        MediaQuery.of(context).textScaleFactor > 1.0) {
      fnt = 13.5;
    } else if (MediaQuery.of(context).textScaleFactor > 1.5) {
      fnt = 10.0;
    } else {
      fnt = 16.0;
    }
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextFormField(
        key: _titleKey,
        validator: (value) {
          if (value.isEmpty) {
            return 'الرجاء ملئ الحقل بالمطلوب';
          } else
            return null;
        },
        focusNode: focus1,
        style: TextStyle(
            color: fontColor(themeNotifier.getbackground())
                ? Colors.white
                : Colors.black,
            fontFamily: ArabicFonts.Cairo,
            package: 'google_fonts_arabic',
            fontWeight: FontWeight.bold,
            fontSize: fnt),
        maxLength: 20,
        maxLines: null,
        onFieldSubmitted: (v) {
          FocusScope.of(context).requestFocus(focus);
        },
        controller: titleText,
        cursorColor: themeNotifier.getTheme(),
        textDirection: TextDirection.rtl,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: fontColor(themeNotifier.getbackground())
                      ? Colors.white54
                      : Colors.black54,
                ),
                borderRadius: BorderRadius.circular(14)),
            hintText: 'مقدمة',
            helperText: 'مقدمة',
            helperStyle: TextStyle(
              fontFamily: ArabicFonts.Cairo,
              package: 'google_fonts_arabic',
              fontSize: 8,
              color: fontColor(themeNotifier.getbackground())
                  ? Colors.white54
                  : Colors.black54,
            ),
            hintStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: ArabicFonts.Cairo,
              package: 'google_fonts_arabic',
              color: fontColor(themeNotifier.getbackground())
                  ? Colors.white54
                  : Colors.black54,
            )),
      ),
    );
  }

  Widget DescribtionField() {
    var fnt;
    if (MediaQuery.of(context).textScaleFactor < 2.0 &&
        MediaQuery.of(context).textScaleFactor > 1.0) {
      fnt = 13.5;
    } else if (MediaQuery.of(context).textScaleFactor > 1.5) {
      fnt = 10.0;
    } else {
      fnt = 16.0;
    }
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextFormField(
        key: _desKey,
        validator: (value) {
          if (value.isEmpty) {
            return 'الرجاء ملئ الحقل بالمطلوب';
          } else
            return null;
        },
        style: TextStyle(
            color: fontColor(themeNotifier.getbackground())
                ? Colors.white
                : Colors.black,
            fontFamily: ArabicFonts.Cairo,
            package: 'google_fonts_arabic',
            fontWeight: FontWeight.bold,
            fontSize: fnt),
        onFieldSubmitted: (v) {
          FocusScope.of(context).requestFocus(focus2);
        },
        focusNode: focus,
        maxLength: 250,
        maxLines: null,
        controller: descriptionText,
        cursorColor: Colors.indigo,
        textDirection: TextDirection.rtl,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            helperText: 'التفاصيل',
            helperStyle: TextStyle(
              color: fontColor(themeNotifier.getbackground())
                  ? Colors.white54
                  : Colors.black54,
              fontFamily: ArabicFonts.Cairo,
              package: 'google_fonts_arabic',
              fontSize: 8,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(
                  color: fontColor(themeNotifier.getbackground())
                      ? Colors.white54
                      : Colors.black54,
                )),
            hintText: 'التفاصيل',
            hintStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: ArabicFonts.Cairo,
              package: 'google_fonts_arabic',
              color: fontColor(themeNotifier.getbackground())
                  ? Colors.white54
                  : Colors.black54,
            )),
      ),
    );
  }

  final _addressKey = GlobalKey<FormState>();
  final _titleKey = GlobalKey<FormState>();
  final _desKey = GlobalKey<FormState>();
  final _priceKey = GlobalKey<FormState>();

  Widget PriceField() {
    MediaQuery.of(context).copyWith(textScaleFactor: 1.0);
    var fnt;
    if (MediaQuery.of(context).textScaleFactor < 2.0 &&
        MediaQuery.of(context).textScaleFactor > 1.0) {
      fnt = 15.0;
    } else if (MediaQuery.of(context).textScaleFactor > 1.5) {
      fnt = 10.0;
    } else {
      fnt = 20.0;
    }
    if (MediaQuery.of(context).size.width>=600 && MediaQuery.of(context).size.height>=950){
      if (MediaQuery.of(context).textScaleFactor < 2.0 &&
          MediaQuery.of(context).textScaleFactor > 1.0) {
        fnt = 37.0;
      } else if (MediaQuery.of(context).textScaleFactor > 1.5) {
        fnt = 32.0;
      } else {
        fnt = 42.0;
      }
    }
    return Container(
      height: MediaQuery.of(context).copyWith().size.height / rat,
      child: Card(
        color: themeNotifier.getTheme(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).copyWith().size.height,
              width: MediaQuery.of(context).copyWith().size.width / 3.5,
              child: Padding(
                padding: const EdgeInsets.all(1),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: Text(
                      'السعر',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                        color: fontColor(themeNotifier.getbackground())
                            ? Colors.white
                            : Colors.black,
                      ),
                      textScaleFactor: 1,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).copyWith().size.width / 2.5,
             // height:MediaQuery.of(context).copyWith().size.height / rat,
              child: Card(
                elevation: 7,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: TextFormField(
                    key: _priceKey,
                    validator: (value) {
                      if (value.isEmpty) {
                        return '';
                      } else
                        return null;
                    },
                    textInputAction: TextInputAction.done,
                    focusNode: focus2,
                    controller: PriceText,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      color: fontColor(themeNotifier.getbackground())
                          ? Colors.white
                          : Colors.black,
                      fontFamily: ArabicFonts.Cairo,
                      package: 'google_fonts_arabic',
                      fontWeight: FontWeight.bold,
                      fontSize: fnt,
                    ),
                    decoration: InputDecoration(
                        hintStyle: TextStyle(
                          color: fontColor(themeNotifier.getbackground())
                              ? Colors.white54
                              : Colors.black54,
                          fontFamily: ArabicFonts.Cairo,
                          package: 'google_fonts_arabic',
                          fontWeight: FontWeight.bold,
                          fontSize: fnt,
                        ),
                        hasFloatingPlaceholder: false,
                        fillColor: themeNotifier.getbackground(),
                        filled: true,
                        hintText: '1000',
                        contentPadding: EdgeInsets.only(left: 8, bottom: 6),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(
                              color: themeNotifier.getTheme(),
                            ))),
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).copyWith().size.height,
              width: MediaQuery.of(context).copyWith().size.width / 3.5,
              child: Padding(
                padding: const EdgeInsets.all(1),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: Text(
                      'ليرة سورية',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',  color: fontColor(themeNotifier.getbackground())
                          ? Colors.white
                          : Colors.black,
                      ),
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

  Widget ResetOrPostB() {
    return Container(
      height: MediaQuery.of(context).copyWith().size.height / rat,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        color: themeNotifier.getTheme(),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                height: MediaQuery.of(context).copyWith().size.height / rat,
                child: Card(
                  elevation: 7,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  color: themeNotifier.getTheme(),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () {
                      if (widget.inti == null) {
                        if (PriceText.text != '' &&
                            descriptionText.text != '' &&
                            titleText.text != '') {
                          if (_images != null && _images.length > 0) {

                          CreatPost(addressText.text,PriceText.text, descriptionText.text,
                              dropdownValue,dropdownSubValue, titleText.text);
                          } else {
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: Flushbar(
                                duration: Duration(seconds: 3),
                                borderRadius: 14,
                                backgroundColor: Colors.red,
                                messageText: Text(
                                  'الرجاء اختيار صور الغرض',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: ArabicFonts.Cairo,
                                    package: 'google_fonts_arabic',
                                  ),
                                  textScaleFactor: 1,
                                  textDirection: TextDirection.rtl,
                                ),
                              )..show(context),
                            );
                          }
                        } else {
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: Flushbar(
                              duration: Duration(seconds: 2),
                              borderRadius: 14,
                              backgroundColor: Colors.red,
                              messageText: Text(
                                'الرجاء ملئ الحقول الفارغة',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: ArabicFonts.Cairo,
                                  package: 'google_fonts_arabic',
                                ),
                                textScaleFactor: 1,
                                textDirection: TextDirection.rtl,
                              ),
                            )..show(context),
                          );
                        }
                      } else {
                        if (PriceText.text != '' &&
                            descriptionText.text != '' &&
                            titleText.text != '')
                        updatePost(
                            widget.inti['pid'],
                            addressText.text,
                            "${PriceText.text}",
                            descriptionText.text,
                            dropdownValue,
                            titleText.text,dropdownSubValue);
                        else {
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: Flushbar(
                              duration: Duration(seconds: 2),
                              borderRadius: 14,
                              backgroundColor: Colors.red,
                              messageText: Text(
                                'الرجاء ملئ الحقول الفارغة',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: ArabicFonts.Cairo,
                                  package: 'google_fonts_arabic',
                                ),
                                textScaleFactor: 1,
                                textDirection: TextDirection.rtl,
                              ),
                            )..show(context),
                          );
                        }
                      }
                    },
                    child: Center(
                      child: Text(
                        widget.inti == null ? 'نشر' : 'تحديث',
                        style: TextStyle(
                          color: Colors.white,
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
            Expanded(
              child: Container(
                height: MediaQuery.of(context).copyWith().size.height / rat,
                child: Card(
                  elevation: 7,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  color: Colors.red[900],
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () {
                      setState(() {
                        addressText.clear();
                        titleText.clear();
                        PriceText.clear();
                        descriptionText.clear();
                        f = false;
                        f2 = false;
                        _images = null;
                        base64Image = null;
                      });
                    },
                    child: Center(
                      child: Text(
                        'تهيئة',
                        style: TextStyle(
                          color: Colors.white,
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
          ],
        ),
      ),
    );
  }

  updatePost(var pidd, String address,String price, String Describtion, String Thingtype,
      String title,String Subtype) async {
    if (this.mounted)
    setState(() {
      isLoading=true;
    });
    final response2 = await http.post(
        "https://callandbuy.000webhostapp.com/CallAndBuy/UpdatePost.php",
        body: {
          "pid": "$pidd",
          'title': "$title",
          'address':"$address",
          "price": "$price",
          "description": "$Describtion",
          "Thingtype": "$Thingtype",
          "Subtype": "$Subtype",
        });
    var J = response2.body;
    if (J != false || J.toString() != 'false') {
      isLoading=false;
      Navigator.of(context).pop();
    }
    else {
      Directionality(
        textDirection: TextDirection.rtl,
        child: Flushbar(
          duration: Duration(seconds: 2),
          borderRadius: 14,
          backgroundColor: Colors.red,
          messageText: Text(
            'هناك مشكلة ما يرجى إعادة المحاولة',
            style: TextStyle(
              color: Colors.white,
              fontFamily: ArabicFonts.Cairo,
              package: 'google_fonts_arabic',
            ),
            textScaleFactor: 1,
            textDirection: TextDirection.rtl,
          ),
        )..show(context),
      );
    }
  }

  Future CreatPost(String address,
      String price, String Describtion, String Thingtype,String Subtype, String title) async {
    setState(() {
      isLoading=true;
    });
    var today = new DateTime.now();
    var threeDaysFromNow = today.add(new Duration(days: 3));
    sharedPreferences = await SharedPreferences.getInstance();
    var id = sharedPreferences.getString("token");
    var jsonResponse = null;
    final response1 = await http.get(
        "https://callandbuy.000webhostapp.com/CallAndBuy/GetNumberOfPost.php");
    var jsonResponse2 = json.decode(response1.body);
    var pid = int.parse(jsonResponse2['postsnumber']) + 1;
    final response2 = await http.post(
        "https://callandbuy.000webhostapp.com/CallAndBuy/InsertIntoPost.php",
        body: {
          "id": "$id",
          "pid": "$pid",
          'title': "$title",
          'address':"$address",
          "price": "$price",
          "expiredDate": "${threeDaysFromNow}",
          "Date":'$today',
          "description": "$Describtion",
          "Thingtype": "$Thingtype",
          'SubType':"$Subtype"
        });
    if (response2.statusCode == 200 && response2.body != false ) {
      await http.post(
          "https://callandbuy.000webhostapp.com/CallAndBuy/UpdatePostNumber.php",
          body: {
            "postsnumber": "$pid",
          });
      await http.post(
          "https://callandbuy.000webhostapp.com/CallAndBuy/addToShare.php",
          body: {
            "id": "$id",
          });
      startUpload(pid);
      isLoading=false;
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => PageViews()),
          (Route<dynamic> route) => false);
    } else {
      Directionality(
        textDirection: TextDirection.rtl,
        child: Flushbar(
          duration: Duration(seconds: 2),
          borderRadius: 14,
          backgroundColor: Colors.red,
          messageText: Text(
            'حدثت مشكلة ما يرجى إعادة المحاولة ',
            style: TextStyle(
              color: Colors.white,
              fontFamily: ArabicFonts.Cairo,
              package: 'google_fonts_arabic',
            ),
            textScaleFactor: 1,
            textDirection: TextDirection.rtl,
          ),
        )..show(context),
      );
    }
  }

  SharedPreferences sharedPreferences;
  List<File> files = new List();
  List<String> base64Image = new List();
  List<File> tempfile = new List();
  List<File> _images;

  Future getImage() async {
    var images = await MultiMediaPicker.pickImages(source: ImageSource.gallery);
    setState(() {
      _images = images;
    });
  }

  startUpload(var pid) {
    if (_images != null) {
      print(_images.length);
      for (int i = 0; i < _images.length; i++) {
        base64Image.add(base64Encode(_images[i].readAsBytesSync()));
      }
    }
    if (null == tempfile) {
      return;
    } else {
      for (int i = 0; i < _images.length; i++) {
        String fileName = _images[i].path.split('/').last;
        upload(fileName, pid, i);
      }
    }
  }

  upload(String fileName, int number, int index) async {
    var url =
        "https://callandbuy.000webhostapp.com/CallAndBuy/images/UploadImages.php";
    http
        .post(url, body: {
          "image": base64Image[index],
          "name": fileName,
        })
        .then((result) {})
        .catchError((error) {});
    http
        .post(
            "https://callandbuy.000webhostapp.com/CallAndBuy/InsertIntoImages.php",
            body: {
              "pid": "$number",
              "nameimage":
                  "https://callandbuy.000webhostapp.com/CallAndBuy/images/${fileName}",
            })
        .then((result) {})
        .catchError((error) {});
  }

  Widget ShowImage() {
    File f;

//    return FutureBuilder<File>(
//      future:,
//      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
//        if (snapshot.connectionState == ConnectionState.done &&
//            null != snapshot.data) {
//          tempfile.add(snapshot.data);
//          base64Image.add(base64Encode(snapshot.data.readAsBytesSync()));
//          return Icon(
//            Icons.check_circle,
//            color: Colors.green,
//          );
//        } else if (null != snapshot.error) {
//          return Icon(
//            Icons.warning,
//            color: Colors.red,
//          );
//        } else {
//          return Icon(
//            Icons.add_circle,
//            color:themeNotifier.getTheme(),
//          );
//        }
//      },
//    );
  }

  @override
  void initState() {
    super.initState();
    handle();
  }
}
