import 'package:callobuy/View/Account/Login_page.dart';
import 'package:callobuy/View/Settings/Formates.dart';
import 'package:callobuy/main.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:http/http.dart' as http;
class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}
class _SignUpPageState extends State<SignUpPage> {
  final _formkey=GlobalKey<FormState>();
  bool flage=false;
  bool val = false;
  bool  eye=true;
  final focus = FocusNode(); final focus2 = FocusNode();
var user=TextEditingController();
  var phone=TextEditingController();
  var pass=TextEditingController();
  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).copyWith(textScaleFactor: 1);
    return Scaffold(
       // resizeToAvoidBottomInset: false,
        body:SingleChildScrollView(
          child:isloading==false? Stack(
            children: <Widget>[
              Image.asset('images/Signup.jpg',fit: BoxFit.cover,height:MediaQuery.of(context).copyWith().size.height/2,width:MediaQuery.of(context).copyWith().size.width,),
              Padding(
                padding:  EdgeInsets.only(top:MediaQuery.of(context).copyWith().size.height/2.3),
                child: Container(
                  decoration: BoxDecoration(
                   color:themeNotifier.getbackground(),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(14))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Form(
                      key:_formkey,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  onChanged:flage==true ? (value){
                                    _formkey.currentState.validate();
                                  }:null,
                                  validator: (value){
                                    print(value[1].toString());
                                    if (value.isEmpty){
                                      return 'الرجاء ملئ الحقل بالمطلوب';
                                    }
                                    else if (value.length!=10){
                                      return 'الرقم غير صالح';
                                    }
                                    else if ((value[0].toString()!='0' && value[1].toString()!='9')|| (value[0].toString()=='0' && value[1].toString()!='9')||(value[0].toString()!='0' && value[1].toString()=='9') ){
                                      return 'الرقم غير صالح';
                                    }
                                    else return null;
                                  },
                                  controller: phone,
                                  onFieldSubmitted: (v){
                                    FocusScope.of(context).requestFocus(focus);
                                  },
                                  keyboardType:TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  textDirection: TextDirection.rtl,
                                  cursorColor:themeNotifier.getTheme(),
                                  style: TextStyle(
                                    color: fontColor(themeNotifier.getbackground())?Colors.white:Colors.black,
                                    fontFamily: ArabicFonts.Cairo,
                                    package: 'google_fonts_arabic',
                                  ),
                                  decoration: InputDecoration(
                                    errorStyle: TextStyle(
                                      fontFamily: ArabicFonts.Cairo,
                                      package: 'google_fonts_arabic',
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(14),
                                        borderSide: BorderSide(color:fontColor(themeNotifier.getbackground())?Colors.white54:Colors.black54,),
                                      ),
                                      labelText: "رقم الهاتف",
                                      hintText: "مثال : 0912345678",
                                      hintStyle: TextStyle(
                                        color:themeNotifier.getIcon()==themeNotifier.getbackground() ?(fontColor(themeNotifier.getbackground())?Colors.white:Colors.black54):themeNotifier.getIcon(),
                                      ),
                                      labelStyle: TextStyle(
                                        fontFamily: ArabicFonts.Cairo,
                                        package: 'google_fonts_arabic',
                                        color:themeNotifier.getIcon()==themeNotifier.getbackground() ?(fontColor(themeNotifier.getbackground())?Colors.white:Colors.black54):themeNotifier.getIcon(),
                                      ),
                                      prefixIcon:Icon(Icons.phone,color:themeNotifier.getIcon()==themeNotifier.getbackground() ?(fontColor(themeNotifier.getbackground())?Colors.white:Colors.black54):themeNotifier.getIcon(),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(14))),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: user,
                                  focusNode: focus,
                                  onChanged:flage==true ? (value){
                                    _formkey.currentState.validate();
                                  }:null,
                                  textInputAction: TextInputAction.next,
                                  validator: (value){
                                    if (value.isEmpty){
                                      return 'الرجاء ملئ الحقل بالمطلوب';
                                    }
                                    else if (value.length<6){
                                      return 'اسم المتخدم أقصر من اللازم';
                                    }
                                    else if (value.length>14){
                                      return 'اسم المتخدم أطول من اللازم';
                                    }
                                    else return null;
                                  },
                                  onFieldSubmitted: (v){
                                    FocusScope.of(context).requestFocus(focus2);
                                  },
                                  style: TextStyle(
color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black,
                                    fontFamily: ArabicFonts.Cairo,
                                    package: 'google_fonts_arabic',
                                  ),
                                  cursorColor: themeNotifier.getTheme(),
                                  decoration: InputDecoration(
                                    errorStyle: TextStyle(
                                      fontFamily: ArabicFonts.Cairo,
                                      package: 'google_fonts_arabic',
                                    ),
                                      labelText: "اسم المستخدم",
                                      labelStyle: TextStyle(
                                        fontFamily: ArabicFonts.Cairo,
                                        package: 'google_fonts_arabic',
                                        color:themeNotifier.getIcon()==themeNotifier.getbackground() ?(fontColor(themeNotifier.getbackground())?Colors.white:Colors.black54):themeNotifier.getIcon(),
                                      ),
                                      prefixIcon: Icon(Icons.person,color:themeNotifier.getIcon()==themeNotifier.getbackground() ?(fontColor(themeNotifier.getbackground())?Colors.white:Colors.black54):themeNotifier.getIcon(),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(14)),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: BorderSide(color: fontColor(themeNotifier.getbackground())?Colors.white54:Colors.black54),
                                    )
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  onChanged:flage==true ? (value){
                                    _formkey.currentState.validate();
                                  }:null,
                                  controller: pass,
                                  focusNode: focus2,
                                  textDirection: TextDirection.ltr,
                                  obscureText: eye,
                                  textInputAction: TextInputAction.done,
                                  cursorColor: themeNotifier.getTheme(),
                                  validator: (value){
                                    if (value.isEmpty){
                                      return 'الرجاء ملئ الحقل بالمطلوب';
                                    }
                                    else if (value.length<6){
                                      return 'كلمة السر قصيرة';
                                    }
                                    else return null;
                                  },
                                  style: TextStyle(
                                    color: fontColor(themeNotifier.getbackground())?Colors.white:Colors.black,
                                    fontFamily: ArabicFonts.Cairo,
                                    package: 'google_fonts_arabic',
                                  ),
                                  decoration: InputDecoration(
                                    errorStyle: TextStyle(
                                      fontFamily: ArabicFonts.Cairo,
                                      package: 'google_fonts_arabic',
                                    ),
                                      labelText: "كلمة المرور",
                                      labelStyle: TextStyle(
                                        color:themeNotifier.getIcon()==themeNotifier.getbackground() ?(fontColor(themeNotifier.getbackground())?Colors.white:Colors.black54):themeNotifier.getIcon(),
                                        fontFamily: ArabicFonts.Cairo,
                                        package: 'google_fonts_arabic',
                                      ),
                                      suffixIcon:IconButton(icon:Icon(eye==false?Icons.visibility:Icons.visibility_off, color:themeNotifier.getIcon()==themeNotifier.getbackground() ?(fontColor(themeNotifier.getbackground())?Colors.white:Colors.black54):themeNotifier.getIcon(),
                                          ), onPressed:(){
                                        setState(() {
                                          if(eye){
                                            eye=false;
                                          }
                                          else eye=true;
                                        });
                                      }),
                                      prefixIcon: Icon(Icons.lock,color:themeNotifier.getIcon()==themeNotifier.getbackground() ?(fontColor(themeNotifier.getbackground())?Colors.white:Colors.black54):themeNotifier.getIcon(),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: fontColor(themeNotifier.getbackground())?Colors.white54:Colors.black54),
                                      borderRadius: BorderRadius.circular(14)
                                    )
                                  
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0, top: 8.0, bottom: 0),
                                child: Container(
                                  child: Row(
                                    //crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    textDirection: TextDirection.rtl,
                                    children: <Widget>[
                                      Checkbox(
                                          value: val,
                                          onChanged: (bool vale) {
                                            setState(() {
                                              val = vale;
                                            });
                                          }),
                                      Text(
                                        "أوافق على شروط ",
                                        style: TextStyle(
                                          color:fontColor(themeNotifier.getbackground())?Colors.white:Colors.black54,
                                          fontFamily: ArabicFonts.Cairo,
                                          package: 'google_fonts_arabic',
                                        ),
                                        textScaleFactor: 1,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(14),
                                        ),
                                        child: InkWell(
                                          borderRadius: BorderRadius.circular(14),
                                          child: Text(
                                            "الخدمة",
                                            style: TextStyle(
                                              color:themeNotifier.getTheme(),
                                              fontFamily: ArabicFonts.Cairo,
                                              package: 'google_fonts_arabic',
                                              fontWeight: FontWeight.bold
                                            ),
                                            textScaleFactor: 1,
                                          ),
                                          onTap: (){
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(25),
                                child: Container(
                                  width:MediaQuery.of(context).copyWith().size.width*0.65,
                                  child: RaisedButton(
                                    disabledColor:themeNotifier.getplaceHolderColor(),
                                    onPressed:val==false?null:(){
                                      setState(() {
                                        flage=true;
                                      });
                                      if (_formkey.currentState.validate()){
                                        addAccount(user.text, phone.text, pass.text);
                                      }
                                    },
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    color:themeNotifier.getTheme(),
                                    child: Text(
                                      "إرسال",
                                      style: TextStyle(
                                        color:fontColor(themeNotifier.getTheme())?Colors.white:Colors.white,
                                        fontFamily: ArabicFonts.Cairo,
                                        package: 'google_fonts_arabic',
                                      ),
                                      textScaleFactor: 1,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                  ),
                ),
              ),
              SafeArea(
                top: true,
                child: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,), onPressed: (){
                  Navigator.of(context).pop();
                }),
              ),
              Padding(
                padding: const EdgeInsets.only(top:12.0),
                child: SafeArea(
                    top: true,
                    child: Center(
                      child: Text('تسجيل اشتراك',textScaleFactor: 1,style: TextStyle(
                        color: Colors.white,
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                      ),),
                    )),
              )
            ],
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
        ));
  }
  bool isloading=false;
  Future addAccount(String username,String phonnumber,String password)async{
    if (this.mounted)
    setState(() {
      isloading=true;
    });
   final response = await http.post(
        "https://callandbuy.000webhostapp.com/CallAndBuy/AddAccount.php",
        body: {
          "username": "$username",
          "phonenumber": "$phonnumber",
          'password': "$password",
        });
   if (response.statusCode!=200) {
     if (this.mounted)
       setState(() {
         isloading=false;
       });
     Directionality(
       textDirection: TextDirection.rtl,
       child: Flushbar(
         borderRadius: 14,
         backgroundColor: Colors.red,
         duration: Duration(seconds: 2),
         messageText: Text('هناك مشكلة ما يرجى إعادة المحاولة', style: TextStyle(
           color: Colors.white,
           fontFamily: ArabicFonts.Cairo,
           package: 'google_fonts_arabic',
         ), textScaleFactor: 1,textDirection: TextDirection.rtl,),
       )..show(context),
     );
   }
   if (response.body.toString()=='false'){
     if (this.mounted)
       setState(() {
         isloading=false;
       });
      Directionality(
        textDirection: TextDirection.rtl,
        child: Flushbar(
          borderRadius:14,
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
          messageText:Text('رقم هاتف غير صالح',textScaleFactor: 1,style: TextStyle(
            fontFamily: ArabicFonts.Cairo,
            package: 'google_fonts_arabic',
            color: Colors.white,
          ),textDirection: TextDirection.rtl,),
        )..show(context),
      );
   }
   else {
     isloading=false;
     Navigator.of(context).pop();
     Navigator.of(context).push(MaterialPageRoute(builder: (_){
       return LoginPage();
     }));
   }

  }
}
