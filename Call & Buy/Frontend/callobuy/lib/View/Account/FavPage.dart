import 'dart:convert';
import 'package:callobuy/Model/Home/HomeScreen.dart';
import 'package:callobuy/View/AboutObject.dart';
import 'package:callobuy/View/Home/HomeScreen.dart';
import 'package:callobuy/View/Home/PostImage.dart';
import 'package:callobuy/View/Settings/Formates.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;

import '../../main.dart';
class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  var _current = 0;
  @override
  Widget build(BuildContext context) {
    var rat;
    var ratim;
    if (MediaQuery.of(context).copyWith().size.height < 580) {
      rat = 2.4;
      ratim = 5;
    } else if (MediaQuery.of(context).copyWith().size.height <= 790) {
      rat = 2.8;
      ratim = 5;
    } else {
      rat = 3.2;
      ratim = 5.2;
    }
    return Scaffold(
      backgroundColor: Colors.red[900],
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Center(child: Image.asset('images/fav.jpg',height:MediaQuery.of(context).copyWith().size.height/2.3,fit: BoxFit.cover,width:MediaQuery.of(context).copyWith().size.width,)),
              Container(
                child: FutureBuilder(
                    future:getPosts(),
                    builder: (_, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.red[900],
                            borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
                          ),
                          height: MediaQuery.of(context).copyWith().size.height/1.5,
                          margin: EdgeInsets.fromLTRB(0,MediaQuery.of(context).copyWith().size.height/2.7, 0, 0),
                          child: Center(
                            child: CircularProgressIndicator( valueColor:
                            AlwaysStoppedAnimation<
                                Color>(
                                Colors.yellow),),
                          ),
                        );
                      }
                      else if (snapshot.hasError) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.red[900],
                            borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
                          ),
                          height: MediaQuery.of(context).copyWith().size.height/1.5,
                          margin: EdgeInsets.fromLTRB(0,MediaQuery.of(context).copyWith().size.height/2.7, 0, 0),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.perm_scan_wifi,color: Colors.white,size: 45,),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: RaisedButton(shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),onPressed: (){setState(() {

                                  });},color: Colors.yellow,elevation: 10,child: Text('تحديث',style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: ArabicFonts.Cairo,
                                    package:
                                    'google_fonts_arabic',
                                  ),textScaleFactor: 1,),),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        List content = snapshot.data;
                        if (content.length > 0) {
                          return Container(
                              margin: EdgeInsets.fromLTRB(0,MediaQuery.of(context).copyWith().size.height/2.7, 0, 0),
                              width:MediaQuery.of(context).copyWith().size.width,
                              decoration: BoxDecoration(
                                color: Colors.red[900],
                                borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
                              ),
                              child:Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child:Row(
                                      textDirection: TextDirection.rtl,
                                      children: <Widget>[
                                        Center(
                                          child: Text('المفضلة',style: TextStyle(
                                            color: Colors.yellow,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: ArabicFonts.Cairo,
                                            package:
                                            'google_fonts_arabic',
                                          ),textScaleFactor: 1,),
                                        ),
                                        Expanded(child: Icon(Icons.star,color: Colors.yellow,)),
                                      ],
                                    ),
                                  ),
                                  GridView.builder(
                                      padding: EdgeInsets.only(top:0),
                                      gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio:(MediaQuery.of(context).copyWith().size.width/2)/(MediaQuery.of(context).copyWith().size.height/rat),
                                        crossAxisCount: 2,),
                                      shrinkWrap: true,
                                      itemCount: content.length,
                                      physics: ScrollPhysics(),
                                      itemBuilder: (_, int index) {
                                        Map info = content[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color:Colors.yellow,
                                              borderRadius:BorderRadius.circular(14),
                                            ),
                                            height:  MediaQuery.of(context).copyWith().size.height/4,
                                            child: InkWell(
                                              borderRadius: BorderRadius.circular(14),
                                              onTap: () {
                                                Navigator.push(context,
                                                    MaterialPageRoute(builder: (_) {
                                                      return aboutObject(info);
                                                    }));
                                              },
                                              child: Column(
                                                children: <Widget>[
                                                  PostImage(content[index]['pid'],themeNotifier.getTheme(),themeNotifier.getplaceHolderColor()),
                                                  Container(
                                                    width: MediaQuery.of(context).copyWith().size.width,
                                                    child: Directionality(
                                                      textDirection: TextDirection.rtl,
                                                      child: Padding(
                                                        padding:  EdgeInsets.only(right:4.0),
                                                        child: Text('${content[index]['title']}',style: TextStyle(
                                                          color: fontColor(Colors.yellow)
                                                              ? Colors.white
                                                              : Colors.black,
                                                          fontFamily: ArabicFonts.Cairo,
                                                          package:
                                                          'google_fonts_arabic',
                                                          fontSize:MediaQuery.of(context).copyWith().size.height > 950 ? 20: MediaQuery.of(context).copyWith().size.height > 850 ? 18:14,
                                                        ),textScaleFactor: 1,maxLines: 1,),
                                                      ),),
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(
                                                          right: 4.0,),
                                                      child: Row(
                                                        textDirection: TextDirection.rtl,
                                                        children: <Widget>[
                                                          Padding(
                                                            padding: const EdgeInsets.only(left: 5.0),
                                                            child: Image.asset(
                                                              'images/global.png',
                                                              height: MediaQuery.of(context)
                                                                  .copyWith()
                                                                  .size
                                                                  .height /
                                                                  50,
                                                              color: fontColor(Colors.yellow)
                                                                  ? Colors.white
                                                                  : Colors.black,
                                                            ),
                                                          ),
                                                          Text(
                                                            'حماه',
                                                            textScaleFactor: 1,
                                                            style: TextStyle(
                                                                color: fontColor(Colors.yellow)
                                                                    ? Colors.white
                                                                    : Colors.black,
                                                                fontFamily: ArabicFonts.Cairo,
                                                                package: 'google_fonts_arabic',
                                                              fontSize:MediaQuery.of(context).copyWith().size.height > 950 ? 18: MediaQuery.of(context).copyWith().size.height > 850 ? 16:12,

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
                                                      textDirection: TextDirection.rtl,
                                                      style: TextStyle(
                                                        color: fontColor(Colors.yellow)
                                                            ? Colors.white
                                                            : Colors.black,
                                                        fontFamily: ArabicFonts.Cairo,
                                                        package:
                                                        'google_fonts_arabic',
                                                        fontWeight: FontWeight.bold,
                                                        fontSize:MediaQuery.of(context).copyWith().size.height > 950 ? 18: MediaQuery.of(context).copyWith().size.height > 850 ? 16:12,

                                                      ),
                                                      textScaleFactor: 1,
                                                    ),
                                                  ),

                                                ],
                                              ),
                                            ),
                                          ),
                                        );

                                      }),
                                ],
                              )
                          );
                        } else {
                          return Container(
                              height: MediaQuery.of(context).copyWith().size.height/1.5,
                              margin: EdgeInsets.fromLTRB(0,MediaQuery.of(context).copyWith().size.height/2.7, 0, 0),
                              decoration: BoxDecoration(
                                color: Colors.red[900],
                                borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
                              ),
                              child:Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset(
                                      'images/Empty.png',
                                      color: Colors.yellow,
                                      height: MediaQuery.of(context).copyWith().size.height*0.18,
                                      width: MediaQuery.of(context).copyWith().size.width*0.20,
                                    ),
                                    Text('لا يوجد معروضات ',style: TextStyle(
                                        color: Colors.yellow,
                                        fontFamily: ArabicFonts.Cairo,
                                        package:
                                        'google_fonts_arabic',
                                        fontWeight: FontWeight.bold
                                    ),textScaleFactor: 1,),
                                  ],
                                ),
                              )
                          );
                        }
                      }
                    }),
              ),
              SafeArea(
                  top: true,
                  child: IconButton(icon: Icon(Icons.arrow_back,color: Colors.yellow[600],), onPressed:(){Navigator.of(context).pop();})),
            ],
          ),


        )
    );
  }
}
SharedPreferences sharedPreferences;
Future <List> getPosts() async{
  var jsonResponse = null;
  sharedPreferences = await SharedPreferences.getInstance();
  var id =sharedPreferences.getString("token");
  final response2 =await http.post("https://callandbuy.000webhostapp.com/CallAndBuy/GetMyFavPost.php",body:{
    "id":id,
  });
  jsonResponse =json.decode(response2.body);
  return jsonResponse;
}
