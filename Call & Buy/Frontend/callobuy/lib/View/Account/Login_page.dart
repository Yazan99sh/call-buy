import 'dart:convert';
import 'dart:ui';
import 'package:callobuy/View/PageViews.dart';
import 'package:callobuy/View/Account/SignUpPage.dart';
import 'package:callobuy/View/Settings/Formates.dart';
import 'package:callobuy/main.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  final focus = FocusNode();
  var username = new TextEditingController();
  var password = new TextEditingController();
  SharedPreferences sharedPreferences;

  Future login() async {
    if (this.mounted)
      setState(() {
        isLoading = true;
      });
    sharedPreferences = await SharedPreferences.getInstance();
    var jsonResponse = null;
    final response2 = await http.post(
        "https://callandbuy.000webhostapp.com/CallAndBuy/Login.php",
        body: {
          "phonenumber": username.text,
          "password": password.text,
        });

    if (response2.statusCode == 200 &&
        response2.body.toString() != "not found") {
      jsonResponse = json.decode(response2.body);
      if (jsonResponse != null && jsonResponse != false) {
        sharedPreferences.setString("token", jsonResponse['id']);
        isLoading = false;
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => PageViews()),
            (Route<dynamic> route) => false);
      } else {
        setState(() {
          isLoading = false;
          forget = true;
        });
        Flushbar(
          borderRadius: 14,
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
          messageText: Text(
            'الحساب غير موجود تأكد من معلوماتك',
            textScaleFactor: 1,
            style: TextStyle(
              fontFamily: ArabicFonts.Cairo,
              package: 'google_fonts_arabic',
              color: Colors.white,
            ),
            textDirection: TextDirection.rtl,
          ),
        )..show(context);
      }
    } else if (response2.statusCode != 200) {
      setState(() {
        isLoading = false;
      });
      Directionality(
        textDirection: TextDirection.rtl,
        child: Flushbar(
          borderRadius: 14,
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
          messageText: Text(
            'هناك مشكلة في الاتصال الرجاء إعادة المحاولة',
            textScaleFactor: 1,
            style: TextStyle(
              fontFamily: ArabicFonts.Cairo,
              package: 'google_fonts_arabic',
              color: Colors.white,
            ),
            textDirection: TextDirection.rtl,
          ),
        )..show(context),
      );
    } else {
      setState(() {
        isLoading = false;
        forget = true;
      });
      Directionality(
        textDirection: TextDirection.rtl,
        child: Flushbar(
          borderRadius: 14,
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
          messageText: Text(
            'تأكد من صحة معلوماتك',
            textScaleFactor: 1,
            style: TextStyle(
              fontFamily: ArabicFonts.Cairo,
              package: 'google_fonts_arabic',
              color: Colors.white,
            ),
            textDirection: TextDirection.rtl,
          ),
        )..show(context),
      );
    }
  }

  bool forget = false;
  bool eye = true;
  bool val = false;
  bool flage = false;
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var add = 0;
    var PadCircle = MediaQuery.of(context).copyWith().size.height / 2.65;
    var Pad1 = MediaQuery.of(context).copyWith().size.height / 2.25;
    if (MediaQuery.of(context).copyWith().size.height < 580) {
      add = 85;
      PadCircle = MediaQuery.of(context).copyWith().size.height / 2.90;
    } else if (MediaQuery.of(context).copyWith().size.height < 615) {
      add = 10;
    } else if (MediaQuery.of(context).copyWith().size.height > 800) {
      PadCircle = MediaQuery.of(context).copyWith().size.height / 2.60;
    }
    MediaQuery.of(context).copyWith(
      textScaleFactor: 1,
    );
    return GestureDetector(
      onTap: () {
        FocusNode focus = FocusScope.of(context);
        if (!focus.hasPrimaryFocus) {
          focus.unfocus();
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Stack(
              children: <Widget>[
                Image.asset(
                  "images/t2.jpg",
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).copyWith().size.height / 2,
                ),
                Padding(
                  padding: EdgeInsets.only(top: Pad1),
                  child: Container(
                    //height: MediaQuery.of(context).copyWith().size.height/2.0,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(14)),
                      color: themeNotifier.getbackground(),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.transparent,
                          offset: Offset(0.0, -2.0), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).copyWith().size.height /
                              7),
                      child: Form(
                          key: _formkey,
                          child: Column(
                            children: <Widget>[
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 8.0,
                                  ),
                                  child: Container(
                                    width: MediaQuery.of(context)
                                            .copyWith()
                                            .size
                                            .width *
                                        0.85,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      elevation: 5,
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'الرجاء ملئ الحقل بالمطلوب';
                                            } else if (value.length != 10) {
                                              return 'الرقم غير صالح';
                                            } else if ((value[0].toString() !=
                                                        '0' &&
                                                    value[1].toString() !=
                                                        '9') ||
                                                (value[0].toString() == '0' &&
                                                    value[1].toString() !=
                                                        '9') ||
                                                (value[0].toString() != '0' &&
                                                    value[1].toString() ==
                                                        '9')) {
                                              return 'الرقم غير صالح';
                                            } else
                                              return null;
                                          },
                                          onChanged: flage == true
                                              ? (value) {
                                                  _formkey.currentState
                                                      .validate();
                                                }
                                              : null,
                                          style: TextStyle(
                                            color: fontColor(themeNotifier
                                                    .getbackground())
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                          controller: username,
                                          cursorColor: themeNotifier.getTheme(),
                                          textInputAction: TextInputAction.next,
                                          onFieldSubmitted: (v) {
                                            FocusScope.of(context)
                                                .requestFocus(focus);
                                          },
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            hasFloatingPlaceholder: false,
                                            labelText: 'رقم الهاتف',
                                            prefixIcon: Icon(Icons.phone),
                                            contentPadding: EdgeInsets.all(8),
                                            hintStyle: TextStyle(
                                              fontFamily: ArabicFonts.Cairo,
                                              package: 'google_fonts_arabic',
                                              color: fontColor(themeNotifier
                                                      .getbackground())
                                                  ? Colors.white54
                                                  : Colors.black54,
                                            ),
                                            labelStyle: TextStyle(
                                              fontFamily: ArabicFonts.Cairo,
                                              package: 'google_fonts_arabic',
                                              color: fontColor(themeNotifier
                                                      .getbackground())
                                                  ? Colors.white54
                                                  : Colors.black54,
                                            ),
                                            hintText: 'مثال : 0912345678',
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              borderSide: BorderSide(
                                                  color: fontColor(themeNotifier
                                                          .getbackground())
                                                      ? Colors.white54
                                                      : Colors.black54),
                                            ),
                                            errorStyle: TextStyle(
                                              fontFamily: ArabicFonts.Cairo,
                                              package: 'google_fonts_arabic',
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 8),
                                  child: Container(
                                    width: MediaQuery.of(context)
                                            .copyWith()
                                            .size
                                            .width *
                                        0.85,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      elevation: 5,
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: TextFormField(
                                          style: TextStyle(
                                            color: fontColor(themeNotifier
                                                    .getbackground())
                                                ? Colors.white
                                                : Colors.black,
                                            fontFamily: ArabicFonts.Cairo,
                                            package: 'google_fonts_arabic',
                                          ),
                                          onChanged: flage == true
                                              ? (value) {
                                                  _formkey.currentState
                                                      .validate();
                                                }
                                              : null,
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'الرجاء ملئ الحقل بالمطلوب';
                                            } else if (value.length < 6) {
                                              return 'كلمة السر قصيرة';
                                            } else
                                              return null;
                                          },
                                          textDirection: TextDirection.ltr,
                                          focusNode: focus,
                                          controller: password,
                                          obscureText: eye,
                                          cursorColor: themeNotifier.getTheme(),
                                          decoration: InputDecoration(
                                            labelText: 'كلمة المرور',
                                            hasFloatingPlaceholder: false,
                                            hintStyle: TextStyle(
                                              fontFamily: ArabicFonts.Cairo,
                                              package: 'google_fonts_arabic',
                                              color: fontColor(themeNotifier
                                                      .getbackground())
                                                  ? Colors.white54
                                                  : Colors.black54,
                                            ),
                                            labelStyle: TextStyle(
                                              fontFamily: ArabicFonts.Cairo,
                                              package: 'google_fonts_arabic',
                                              color: fontColor(themeNotifier
                                                      .getbackground())
                                                  ? Colors.white54
                                                  : Colors.black54,
                                            ),
                                            errorStyle: TextStyle(
                                              fontFamily: ArabicFonts.Cairo,
                                              package: 'google_fonts_arabic',
                                            ),
                                            prefixIcon: Icon(
                                              Icons.lock_outline,
                                            ),
                                            suffixIcon: IconButton(
                                                highlightColor:
                                                    Colors.transparent,
                                                splashColor: Colors.transparent,
                                                icon: Icon(
                                                  eye == true
                                                      ? Icons.visibility_off
                                                      : Icons.visibility,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    if (eye)
                                                      eye = false;
                                                    else
                                                      eye = true;
                                                  });
                                                }),
                                            contentPadding: EdgeInsets.all(8),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                                borderSide: BorderSide(
                                                    color: fontColor(
                                                            themeNotifier
                                                                .getbackground())
                                                        ? Colors.white54
                                                        : Colors.black54)),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom:
                                        MediaQuery.of(context).size.height / 8),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
                                  child: RaisedButton(
                                    elevation: 5,
                                    onPressed: () {
                                      flage = true;

                                      if (_formkey.currentState.validate()) {
                                        login();
                                      }
                                    },
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    color: themeNotifier.getTheme(),
                                    child: Text(
                                      "تسجيل",
                                      style: TextStyle(
                                        color:
                                            fontColor(themeNotifier.getTheme())
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
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: isLoading == false ? PadCircle : 0),
                  child: Center(
                    child: AnimatedContainer(
                      decoration: BoxDecoration(
                          color: themeNotifier.getTheme(),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                color: themeNotifier.getplaceHolderColor(),
                                blurRadius: 5,
                                offset: Offset(3, 3))
                          ]),
                      duration: Duration(milliseconds: 500),
                      width: isLoading == false
                          ? MediaQuery.of(context).copyWith().size.width * 0.25
                          : MediaQuery.of(context).copyWith().size.width,
                      height: isLoading == false
                          ? MediaQuery.of(context).copyWith().size.width * 0.25
                          : MediaQuery.of(context).copyWith().size.height,
                      child: isLoading == false
                          ? Center(
                              child: Text(
                              "Call&Buy",
                              style: TextStyle(
                                  color: fontColor(themeNotifier.getTheme())
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 15),
                              textScaleFactor: 1,
                            ))
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  'images/logo.png',
                                  color: fontColor(themeNotifier.getTheme())
                                      ? Colors.white
                                      : Colors.black,
                                  width: MediaQuery.of(context)
                                          .copyWith()
                                          .size
                                          .width /
                                      2.5,
                                  height: MediaQuery.of(context)
                                          .copyWith()
                                          .size
                                          .width /
                                      2.5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          fontColor(themeNotifier.getTheme())
                                              ? Colors.white
                                              : Colors.black)),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
                forget
                    ? Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).copyWith().size.height /
                                    1.32 +
                                add),
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(14),
                              onTap: () {
                                Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Flushbar(
                                    borderRadius: 14,
                                    backgroundColor: Colors.red,
                                    duration: Duration(seconds: 5),
                                    messageText: Text(
                                      'الميزة غير متوفرة في الوقت الحالي',
                                      textScaleFactor: 1,
                                      style: TextStyle(
                                        fontFamily: ArabicFonts.Cairo,
                                        package: 'google_fonts_arabic',
                                        color: Colors.white,
                                      ),
                                      textDirection: TextDirection.rtl,
                                    ),
                                  )..show(context),
                                );
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 16, left: 16),
                                child: Text(
                                  'هل نسيت كلمة السر ؟',
                                  style: TextStyle(
                                      color: themeNotifier.getTheme() ==
                                              themeNotifier.getbackground()
                                          ? (fontColor(
                                                  themeNotifier.getbackground())
                                              ? Colors.white
                                              : Colors.black)
                                          : themeNotifier.getTheme(),
                                      fontFamily: ArabicFonts.Cairo,
                                      package: 'google_fonts_arabic',
                                      fontWeight: FontWeight.bold),
                                  textScaleFactor: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(),
                SafeArea(
                  top: true,
                  child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: SafeArea(
                    top: true,
                    child: Center(
                      child: Text(
                        'تسجيل الدخول',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: ArabicFonts.Cairo,
                          package: 'google_fonts_arabic',
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
