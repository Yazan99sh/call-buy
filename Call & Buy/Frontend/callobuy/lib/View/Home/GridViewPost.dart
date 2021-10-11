import 'package:callobuy/View/AboutObject.dart';
import 'package:callobuy/View/Home/PostImage.dart';
import 'package:callobuy/View/Settings/Formates.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import '../../main.dart';

class PostGrid extends StatefulWidget {
  String str;

  // ignore: non_constant_identifier_names
  Future<List> _PostsLsit;

  // ignore: non_constant_identifier_names
  Color Primary;

  // ignore: non_constant_identifier_names
  Color Shadow;

  @override
  _PostGridState createState() => _PostGridState();

  PostGrid(this._PostsLsit, this.Primary, this.Shadow, this.str);
}

class _PostGridState extends State<PostGrid> {
  @override
  Widget build(BuildContext context) {
    var ncell;
    if (MediaQuery.of(context).copyWith().size.width >= 600) {
      ncell = 4;
    } else
      ncell = 2;
    var rat;
    if (MediaQuery.of(context).copyWith().size.height < 500) {
      rat = 2.3;
    } else if (MediaQuery.of(context).copyWith().size.height < 580) {
      rat = 2.6;
    } else if (MediaQuery.of(context).copyWith().size.height < 640) {
      rat = 2.7;
    } else if (MediaQuery.of(context).copyWith().size.height <= 790) {
      rat = 3.3;
    } else {
      rat =3.5;
    }
    return FutureBuilder(
        future: widget._PostsLsit,
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).copyWith().size.height / 7),
              child: Container(
                height: MediaQuery.of(context).copyWith().size.height * 0.18,
                width: MediaQuery.of(context).copyWith().size.width * 0.20,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            if (widget.str == 'Home')
              return Container(
                width: MediaQuery.of(context).copyWith().size.width,
                height: MediaQuery.of(context).copyWith().size.height * 0.60,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Text(
                      "هناك مشكلة في الإتصال اسحب من الأعلى للتحديث",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: fontColor(themeNotifier.getbackground())
                            ? Colors.white
                            : Colors.black,
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                      ),
                      textScaleFactor: 1,
                    ),
                  ),
                ),
              );
            else
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.perm_scan_wifi,
                      color: Colors.red,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                          child: Text(
                            'إهادة المحاولة',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: fontColor(widget.Primary)
                                  ? Colors.white
                                  : Colors.black,
                              fontFamily: ArabicFonts.Cairo,
                              package: 'google_fonts_arabic',
                            ),
                          ),
                          color: widget.Primary,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                          onPressed: () {
                            setState(() {});
                          }),
                    )
                  ],
                ),
              );
          } else {
            List content = snapshot.data;
            if (content.length > 0) {
              return GridView.builder(
                  padding: EdgeInsets.only(top: 0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: MediaQuery.of(context)
                                  .copyWith()
                                  .size
                                  .width >=
                              600
                          ? (MediaQuery.of(context).copyWith().size.width / 4) /
                              (MediaQuery.of(context).copyWith().size.height /
                                  3.3)
                          : (MediaQuery.of(context).copyWith().size.width / 2) /
                              (MediaQuery.of(context).copyWith().size.height /
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
                      borderRadius: BorderRadius.circular(14),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return aboutObject(info);
                        }));
                      },
                      child: Stack(
                        children: <Widget>[
                          PostImage(content[index]['pid'], widget.Primary,
                              widget.Shadow),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 130, left: 4, right: 4),
                            child: Container(
                              height: 100,
                              child: Card(
                                color:widget.Primary,
                             shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context)
                                          .copyWith()
                                          .size
                                          .width,
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 12.0),
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Text(
                                              '${content[index]['title']}',
                                              style: TextStyle(
                                                color: fontColor(widget.Primary)
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontFamily: ArabicFonts.Cairo,
                                                package: 'google_fonts_arabic',
                                                fontSize: MediaQuery.of(context)
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
                                              ),
                                              textScaleFactor: 1,
                                              maxLines: 1,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          right: 8.0,
                                        ),
                                        child: Row(
                                          textDirection: TextDirection.rtl,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5.0),
                                              child: Image.asset(
                                                'images/global.png',
                                                height: MediaQuery.of(context)
                                                        .copyWith()
                                                        .size
                                                        .height /
                                                    50,
                                                color: fontColor(widget.Primary)
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                            ),
                                            Text(
                                              '${content[index]['address']}',
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                color: fontColor(widget.Primary)
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontFamily: ArabicFonts.Cairo,
                                                package: 'google_fonts_arabic',
                                                fontSize: MediaQuery.of(context)
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
                                    Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: Text(
                                          "  ${content[index]['price']} ل.س",
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(
                                            color: fontColor(
                                                    widget.Primary)
                                                ? Colors.white
                                                : Colors.black,
                                            fontFamily: ArabicFonts.Cairo,
                                            package: 'google_fonts_arabic',
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context)
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
                                          textScaleFactor: 1,
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
                  });
            } else {
              return Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).copyWith().size.height / 7),
                child: Container(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'images/Empty.png',
                      color: widget.Primary,
                      height:
                          MediaQuery.of(context).copyWith().size.height * 0.18,
                      width:
                          MediaQuery.of(context).copyWith().size.width * 0.20,
                    ),
                    Text(
                      'لا يوجد معروضات ',
                      style: TextStyle(
                          color: fontColor(themeNotifier.getbackground())
                              ? Colors.white
                              : Colors.black54,
                          fontFamily: ArabicFonts.Cairo,
                          package: 'google_fonts_arabic',
                          fontWeight: FontWeight.bold),
                      textScaleFactor: 1,
                    ),
                  ],
                )),
              );
            }
          }
        });
  }
}
