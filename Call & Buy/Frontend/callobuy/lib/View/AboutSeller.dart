import 'package:callobuy/Model/AboutSeller.dart';
import 'package:callobuy/main.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart' as url;
import 'dart:core';
import 'Settings/Formates.dart';
class aboutSeller extends StatefulWidget {
  var id;
  aboutSeller(this.id);
  @override
  _aboutSellerState createState() => _aboutSellerState();
}


class _aboutSellerState extends State<aboutSeller> {

  @override
  void initState() {
    super.initState();
    GetNumberofLike();
    GetNumberofPost();
  }

  SharedPreferences sharedPreferences;
  Future Liker() async {

    sharedPreferences = await SharedPreferences.getInstance();
    var Fromid = sharedPreferences.getString("token");
    if (Fromid == null || Fromid==''){
      Directionality(
        textDirection: TextDirection.rtl,
        child: Flushbar(
          messageText: Text(
            "يجب عليك تسجيل الدخول أولا",
            textDirection: TextDirection.rtl,
            textScaleFactor: 1,
            style: TextStyle(
              color:fontColor(themeNotifier.getTheme())?Colors.white:Colors.black,
              fontFamily: ArabicFonts.Cairo,
              package: 'google_fonts_arabic',
            ),
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
      //check
      final response1 = await http.post(
          "https://callandbuy.000webhostapp.com/CallAndBuy/CheckLiker.php",
          body: {
            "Fromid": "$Fromid",
            "Toid": "${widget.id}",
          });
      var jsonres = json.decode(response1.body);
      //insert
      if (jsonres == null || jsonres == false || jsonres=={}) {
        final response2 = await http.post(
            "https://callandbuy.000webhostapp.com/CallAndBuy/Liker.php",
            body: {
              "Fromid": "$Fromid",
              "Toid": "${widget.id}",
            });
        Directionality(
          textDirection: TextDirection.rtl,
          child: Flushbar(
            messageText: Text(
              "تمت إضافة الغرض للمفضلة",
              textDirection: TextDirection.rtl,
              textScaleFactor: 1,
              style: TextStyle(
                color: Colors.white,
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
                color: Colors.white,
                fontFamily: ArabicFonts.Cairo,
                package: 'google_fonts_arabic',
              ),
            ),
            backgroundColor: Colors.red[900],
            icon: IconButton(
              onPressed: () {
                removeLiker(widget.id, Fromid );
               setState(() {

               });
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
  @override
  Widget build(BuildContext context) {
    var phnum;
    var resulth;
    phnum=MediaQuery.of(context).copyWith().size.height/25;
    var rh = MediaQuery.of(context).copyWith().size.height/28;
    var sp=5.1;
    if (MediaQuery.of(context).copyWith().size.height<580){
      phnum=MediaQuery.of(context).copyWith().size.height/35;
    rh =MediaQuery.of(context).copyWith().size.height/20;
    sp=6.0;
    }
   if (MediaQuery.of(context).copyWith().size.height<790){
      resulth =  MediaQuery.of(context).copyWith().size.height/5.6;
    }
    else {
      resulth =  MediaQuery.of(context).copyWith().size.height/5.1;
    }
    return Scaffold(
    body:SafeArea(
      top: false,
      child: Stack(
        children: <Widget>[
          IconButton(icon:Icon(Icons.arrow_back,color: Colors.white,), onPressed:(){
            Navigator.of(context).pop();
          }),
          Image.asset('images/seller.jpg',height:MediaQuery.of(context).copyWith().size.height/2,width:MediaQuery.of(context).copyWith().size.width,fit: BoxFit.cover,),
          Padding(
            padding:EdgeInsets.only(top:MediaQuery.of(context).copyWith().size.height/2.15),
            child: ClipRRect(
              child: Container(
                height:MediaQuery.of(context).copyWith().size.height/1.9,
                margin: EdgeInsets.only(top: 6.0),
                decoration: BoxDecoration(
                    color:themeNotifier.getbackground(),
                    borderRadius: BorderRadius.only(
                      topLeft:Radius.circular(18),
                      topRight: Radius.circular(18),
                    ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.transparent,
                      offset: Offset(0.0, -2.0), //(x,y)
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: FutureBuilder(
                    future: GetSallerInfo(widget.id),
                    builder: (_,snapshot){
                      if (snapshot.connectionState==ConnectionState.waiting){
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      else if (snapshot.hasError){
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.perm_scan_wifi,color: Colors.red,size: MediaQuery.of(context).size.height/6,),
                              Container(
                                height: MediaQuery.of(context).copyWith().size.height/20,
                                width: MediaQuery.of(context).copyWith().size.width/3,
                                child: RaisedButton(onPressed: (){
                                  setState(() {

                                  });
                                },color:themeNotifier.getTheme(),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),child: Text('إعادة التحميل',style: TextStyle(
                                  color:fontColor(themeNotifier.getTheme())?Colors.white:Colors.black,
                                ),textScaleFactor: 1,),),
                              )
                            ],
                          ),
                        );
                      }
                      else {
                        var _content =snapshot.data;
                        return Directionality(
                          textDirection: TextDirection.rtl,
                          child: SizedBox(
                            height:MediaQuery.of(context).copyWith().size.height,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).copyWith().size.width,
                                    height:resulth,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          height: MediaQuery.of(context).copyWith().size.height/17,
                                          child: Text(" ${_content['username']} ",style: TextStyle(
                                            color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black,
                                            fontFamily: ArabicFonts.Cairo,
                                            package: 'google_fonts_arabic',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 26,
                                          ),textScaleFactor: 1,),
                                        ),
                                        Container(
                                          height:rh,
                                          child: Text("البائع",style: TextStyle(
                                              color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black54,
                                              fontFamily: ArabicFonts.Cairo,
                                              package: 'google_fonts_arabic',
                                              fontSize: 26/1.5
                                          ),textScaleFactor: 1,),
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.only(top:phnum),
                                          child: Container(
                                            height: MediaQuery.of(context).copyWith().size.height/25,
                                            child: Text('رقم الهاتف : ${_content['phonenumber']} ',style: TextStyle(
                                                color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black54,
                                                fontFamily: ArabicFonts.Cairo,
                                                package: 'google_fonts_arabic',
                                                fontSize: 26/1.5
                                            ),textScaleFactor: 1,),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Spacer(flex:4,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:   Container(
                                    height:(MediaQuery.of(context).copyWith().size.height/1.1)-(MediaQuery.of(context).copyWith().size.height/2) -MediaQuery.of(context).copyWith().size.height/sp,
                                    child: Column(

                                      crossAxisAlignment: CrossAxisAlignment.center,

                                      mainAxisAlignment: MainAxisAlignment.center,

                                      children: <Widget>[

                                        Row(

                                          children: <Widget>[

                                            Container(
                                              width: MediaQuery.of(context).copyWith().size.width/3.5,
                                            ),

                                            Expanded(
                                              child: Container(

                                                height: MediaQuery.of(context).copyWith().size.height/20,

                                                width:MediaQuery.of(context).copyWith().size.width/3.5,

                                                decoration: BoxDecoration(

                                                  color: Colors.red[900],

                                                  borderRadius: BorderRadius.circular(18),

                                                ),

                                                child: InkWell(
                                                  onTap: (){
                                                    Liker();
                                                  },
                                                  child: Row(

                                                    mainAxisAlignment: MainAxisAlignment.center,

                                                    children: <Widget>[

                                                      Center(child: Icon(Icons.favorite,color: Colors.white,)),

                                                    ],

                                                  ),

                                                ),

                                              ),
                                            ),

                                            Container(
                                              width: MediaQuery.of(context).copyWith().size.width/3.5,
                                            ),

                                          ],

                                        ),
                                        Spacer(flex: 3,),
                                        Align(

                                          alignment: Alignment.bottomCenter,

                                          child: Row(

                                            textDirection: TextDirection.ltr,

                                            children: <Widget>[

                                              Container(
                                                width: MediaQuery.of(context).copyWith().size.width/3.5,
                                                child: ListTile(
                                                  title: Center(
                                                    child:Text('$PostNumber',style: TextStyle(
                                                      color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black,
                                                      fontFamily: ArabicFonts.Cairo,

                                                      package: 'google_fonts_arabic',

                                                      fontWeight: FontWeight.bold,

                                                      fontSize: 23,

                                                    ),textScaleFactor: 1,),

                                                  ),

                                                  subtitle: Center(

                                                    child: Text('منشور',style: TextStyle(
                                                      color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black,
                                                      fontFamily: ArabicFonts.Cairo,

                                                      package: 'google_fonts_arabic',

                                                      fontSize:23/1.5,

                                                    ),textScaleFactor: 1,),

                                                  ),

                                                ),

                                              ),

                                              Expanded(

                                                child: Container(
                                                  height: MediaQuery.of(context).copyWith().size.height/20,
                                                  width:MediaQuery.of(context).copyWith().size.width/3.5,

                                                  decoration:BoxDecoration(

                                                    color:themeNotifier.getTheme(),

                                                    borderRadius: BorderRadius.circular(18),

                                                  ),

                                                  child: InkWell(
                                                    onTap: (){
                                                      url.launch("tel:${_content['phonenumber']}");
                                                    },
                                                    child: Center(

                                                      child: Icon(Icons.call, color:fontColor(themeNotifier.getTheme())?Colors.white:Colors.black,),

                                                    ),

                                                  ),

                                                ),

                                              ),

                                              Container(

                                                width: MediaQuery.of(context).copyWith().size.width/3.5,

                                                child: ListTile(

                                                  title: Center(

                                                    child: Text('$Likenumber',style: TextStyle(
                                                        color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black,
                                                        fontFamily: ArabicFonts.Cairo,

                                                        package: 'google_fonts_arabic',

                                                        fontWeight: FontWeight.bold,

                                                        fontSize: 23

                                                    ),textScaleFactor: 1,),

                                                  ),

                                                  subtitle: Center(

                                                    child: Text('إعجاب',style: TextStyle(
                                                        color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black,
                                                        fontFamily: ArabicFonts.Cairo,

                                                        package: 'google_fonts_arabic',

                                                        fontSize: 23/1.5

                                                    ),textScaleFactor: 1,),

                                                  ),

                                                ),

                                              ),

                                            ],

                                          ),

                                        ),
                                        Expanded(child: Container(
                                          height:MediaQuery.of(context).copyWith().size.height,
                                        )),

                                      ],

                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    }
                ),
              ),
            ),
          ),
          SafeArea(
            top: true,
            child: IconButton(icon:Icon(Icons.arrow_back,color: Colors.white,), onPressed:(){
              Navigator.of(context).pop();
            }),
          ),
        ],
      ),
    )
    );
  }

  var Likenumber="0";
  var PostNumber="0";
  Future GetNumberofLike() async {
    final response = await http.post("https://callandbuy.000webhostapp.com/CallAndBuy/GetNumberOfLike.php",body: {
      "Toid":"${widget.id}",
    });
   var jsonRe =await json.decode(response.body);
   if (jsonRe == false || jsonRe == null || jsonRe =={}){
     if(this.mounted)
     setState(() {
     });
   }
    if (this.mounted){
      setState(() {
Likenumber=StringNumber(int.parse('${jsonRe['COUNT(toid)']}'));
      });
    }
  }
  Future GetNumberofPost() async {
    final response = await http.post("https://callandbuy.000webhostapp.com/CallAndBuy/GetNumberOfShare.php",body: {
      "id":"${widget.id}",
    });
    var jsonRe =await json.decode(response.body);
    if (jsonRe == false || jsonRe == null || jsonRe == {}){
      if(this.mounted)
        setState(() {
        });
    }
    if (this.mounted){
      setState(() {
        PostNumber =StringNumber(int.parse('${jsonRe['COUNT(id)']}'));
      });
    }
  }

  String StringNumber(int number){
    if (number < 1000 )return '${number.toString()}';
    else if (number>=1000 && number <1000000){
      if (number <10000 ){
        if ((number/1000).toString() =='${number.toString()[0]}.0'){

          return '${number.toString()[0]}k';}
        else {
          return '${number.toString()[0]},${number.toString().substring(1,3)}';
        }
      }
      else if (number >= 10000 && number < 100000){
        if ((number/10000).toString()=='${number.toString().substring(0,2)}.0'){
         return '${number.toString().substring(0,1)}k';
        }
        else {
          return '${number.toString().substring(0,1)},${number.toString().substring(2,3)}';
        }

      }
    }

  }


}
