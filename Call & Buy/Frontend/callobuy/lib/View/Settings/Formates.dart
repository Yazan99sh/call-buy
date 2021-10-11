import 'dart:math';
import 'package:callobuy/View/ThemeNotifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';
import 'dart:core';

import '../PageViews.dart';

class Format extends StatefulWidget {
  @override
  _FormatState createState() => _FormatState();
}

class _FormatState extends State<Format> {
  // create some values that give the current state of color
  Color pickerColor = Colors.indigo;
  Color currentColorPrimary = themeNotifier.getTheme();
  Color currentColorBackground = themeNotifier.getbackground();
  Color currentColorIcons = themeNotifier.getIcon();
  Color currentColorShadow = themeNotifier.getplaceHolderColor();

// ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

//for save users choices
  SharedPreferences sharedPreferences;

//refresh color function
  void onThemeChanged(ThemeNotifier themeNotifier) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt(
        "Primary",
        int.parse(currentColorPrimary.toString().substring(
            currentColorPrimary.toString().length > 34 ? 35 : 6,
            currentColorPrimary.toString().length > 34 ? 45 : 16)));
    sharedPreferences.setInt(
        "Background",
        int.parse(currentColorBackground.toString().substring(
            currentColorBackground.toString().length > 34 ? 35 : 6,
            currentColorBackground.toString().length > 34 ? 45 : 16)));
    sharedPreferences.setInt(
        "Icons",
        int.parse(currentColorIcons.toString().substring(
            currentColorIcons.toString().length > 34 ? 35 : 6,
            currentColorIcons.toString().length > 34 ? 45 : 16)));
    sharedPreferences.setInt(
        "Shadow",
        int.parse(currentColorShadow.toString().substring(
            currentColorShadow.toString().length > 34 ? 35 : 6,
            currentColorShadow.toString().length > 34 ? 45 : 16)));
    setState(() {
      themeNotifier.setTheme(currentColorPrimary);
      themeNotifier.setbackground(currentColorBackground);
      themeNotifier.setPlaceHolderColor(currentColorShadow);
      themeNotifier.setIcon(currentColorIcons);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black,
        ),
        elevation: 0,
        backgroundColor: themeNotifier.getbackground(),
        centerTitle: true,
        title: Text(
          'التنسيقات',
          textScaleFactor: 1,
          style: TextStyle(
            fontFamily: ArabicFonts.Cairo,
            package: 'google_fonts_arabic',
            color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black,
          ),
        ),
        actions: <Widget>[
          Center(
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: () {
                onThemeChanged(themeNotifier);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) => PageViews()),
                    (Route<dynamic> route) => false);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'تطبيق',
                  textScaleFactor: 1,
                  style: TextStyle(
                    fontFamily: ArabicFonts.Cairo,
                    package: 'google_fonts_arabic',
                    fontWeight: FontWeight.w600,
                    color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Directionality(
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
                  onTap: () {
                    PickColors(currentColorPrimary, 'Primary', _defaultPrimary);
                  },
                  child: ListTile(
                    trailing: Container(
                        height:
                            MediaQuery.of(context).copyWith().size.width / 15,
                        width:
                            MediaQuery.of(context).copyWith().size.width / 15,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            color: currentColorPrimary,
                            boxShadow: [
                              BoxShadow(
                                color: currentColorPrimary.withOpacity(0.8),
                                offset: Offset(1.0, 2.0),
                                blurRadius: 3.0,
                              ),
                            ])),
                    leading: Icon(
                      Icons.dashboard,
                      color: fontColor(themeNotifier.getbackground())
                          ? Colors.white
                          : Colors.black54,
                    ),
                    title: Text(
                      "اللون الأساسي",
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
                  )),
            ),
            Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () {
                    PickColors(currentColorBackground, 'Background',
                        _defaultBackground);
                  },
                  child: ListTile(
                    trailing: Container(
                        height:
                            MediaQuery.of(context).copyWith().size.width / 15,
                        width:
                            MediaQuery.of(context).copyWith().size.width / 15,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            color: currentColorBackground,
                            boxShadow: [
                              BoxShadow(
                                color: currentColorBackground.withOpacity(0.8),
                                offset: Offset(1.0, 2.0),
                                blurRadius: 3.0,
                              ),
                            ])),
                    leading: Icon(
                      Icons.view_array,
                      color: fontColor(themeNotifier.getbackground())
                          ? Colors.white
                          : Colors.black54,
                    ),
                    title: Text(
                      "الخلفية",
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
                )),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: () {
                  PickColors(currentColorShadow, 'Shadow', _defaultShadow);
                },
                child: ListTile(
                  trailing: Container(
                      height: MediaQuery.of(context).copyWith().size.width / 15,
                      width: MediaQuery.of(context).copyWith().size.width / 15,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          color: currentColorShadow,
                          boxShadow: [
                            BoxShadow(
                              color: currentColorShadow.withOpacity(0.8),
                              offset: Offset(1.0, 2.0),
                              blurRadius: 3.0,
                            ),
                          ])),
                  leading: Icon(
                    Icons.grain,
                    color: fontColor(themeNotifier.getbackground())
                        ? Colors.white
                        : Colors.black54,
                  ),
                  title: Text(
                    "الظل",
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
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: InkWell(
                onTap: () {
                  PickColors(currentColorIcons, 'Icons', _defaultIcons);
                },
                borderRadius: BorderRadius.circular(14),
                child: ListTile(
                  trailing: Container(
                      height: MediaQuery.of(context).copyWith().size.width / 15,
                      width: MediaQuery.of(context).copyWith().size.width / 15,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          boxShadow: [
                            BoxShadow(
                              color: currentColorIcons.withOpacity(0.8),
                              offset: Offset(1.0, 2.0),
                              blurRadius: 3.0,
                            ),
                          ])),
                  leading: Icon(
                    Icons.invert_colors,
                    color: fontColor(themeNotifier.getbackground())
                        ? Colors.white
                        : Colors.black54,
                  ),
                  title: Text(
                    "الإيقونات",
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
          ],
        ),
      ),
    );
  }

  PickColors(Color currentColor, String str, List<Color> defaultColor) {
    Color bgc;
    var f;
    if (str == 'Primary') {
      bgc = Colors.white;
    } else if (str == 'background') {
      f = fontColor(bgc);
      bgc = themeNotifier.getplaceHolderColor();
      f = fontColor(bgc);
    } else if (str == 'Shadow') {
      bgc = Colors.white;
      f = fontColor(bgc);
    } else {
      bgc = themeNotifier.getplaceHolderColor();
      f = fontColor(bgc);
    }
    showDialog(
      context: context,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          backgroundColor: bgc,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          title: Text(
            'اختار لون',
            textScaleFactor: 1,
            style: TextStyle(
              fontFamily: ArabicFonts.Cairo,
              package: 'google_fonts_arabic',
              fontWeight: FontWeight.bold,
              color: f == true ? Colors.white : Colors.black,
            ),
          ),
          content: SingleChildScrollView(
            child: BlockPicker(
              availableColors: defaultColor,
              pickerColor: currentColor,
              onColorChanged: changeColor,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text('تأكيد'),
              onPressed: () {
                setState(() {
                  if (str == 'Icons') {
                    currentColorIcons = pickerColor;
                  } else if (str == 'Background') {
                    currentColorBackground = pickerColor;
                  } else if (str == 'Shadow') {
                    currentColorShadow = pickerColor;
                  } else {
                    currentColorPrimary = pickerColor;
                  }
                });

                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
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
    Colors.cyan,
    Colors.black,
  ];
  List<Color> _defaultBackground = [
    Colors.white,
    Colors.black,
    Colors.black12,
    Colors.black26,
    Colors.black38,
    Colors.black45,
    Colors.black54,
    Colors.black87,
    Colors.grey[200],
    Colors.grey,
    Colors.grey[800],
    Colors.grey[900],
    Colors.red[200],
    Colors.pink[200],
    Colors.purple[200],
    Colors.deepPurple[200],
    Colors.indigo[200],
    Colors.blue[200],
    Colors.lightBlue[200],
    Colors.green[200],
    Colors.yellow[200],
    Colors.amber[200],
    Colors.orange[200],
  ];
  List<Color> _defaultShadow = [
    Colors.red[200],
    Colors.pink[200],
    Colors.purple[200],
    Colors.deepPurple[200],
    Colors.indigo[200],
    Colors.blue[200],
    Colors.lightBlue[200],
    Colors.green[200],
    Colors.yellow[200],
    Colors.amber[200],
    Colors.orange[200],
    Colors.grey,
    Colors.grey[800],
    Colors.grey[900],
  ];
  List<Color> _defaultIcons = [
    Colors.red,
    Colors.red[900],
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
    Colors.black,
    Colors.white,
  ];
}

bool fontColor(Color color, {double bias: 1.0}) {
  // Old:
  // return 1.05 / (color.computeLuminance() + 0.05) > 4.5;

  // New:
  bias ??= 1.0;
  int v = sqrt(pow(color.red, 2) * 0.299 +
          pow(color.green, 2) * 0.587 +
          pow(color.blue, 2) * 0.114)
      .round();
  return v < 130 * bias ? true : false;
}
