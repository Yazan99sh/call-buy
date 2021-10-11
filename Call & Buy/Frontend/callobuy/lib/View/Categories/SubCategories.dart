import 'package:callobuy/View/Categories/CatPost.dart';
import 'package:callobuy/View/Settings/Formates.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';

import '../../main.dart';

class SubCategories extends StatefulWidget {
  var Cat;

  SubCategories([this.Cat]);

  @override
  _SubCategoriesState createState() => _SubCategoriesState();
}

class _SubCategoriesState extends State<SubCategories> {
  @override
  Widget build(BuildContext context) {
    var SubCat = [''];
    var subIcon;
    if (widget.Cat['name'] == 'أجهزة كهربائية') {
      SubCat = ['غسالات', 'برادات', 'مكيفات', 'سخانات', 'أفران', 'أخرى'];
      subIcon = [
        Image.asset(
          'Icons/WashingMachine.png',
          width: MediaQuery.of(context).size.width / 5,
          color:
              fontColor(themeNotifier.getTheme()) ? Colors.white : Colors.black,
        ),
    Image.asset(
    'Icons/refrigerator.png',
    width: MediaQuery.of(context).size.width / 5,
    color:
    fontColor(themeNotifier.getTheme()) ? Colors.white : Colors.black,
    ),
        Image.asset(
          'Icons/air-conditioner.png',
          width: MediaQuery.of(context).size.width / 5,
          color:
          fontColor(themeNotifier.getTheme()) ? Colors.white : Colors.black,
        ),
        Image.asset(
          'Icons/heater.png',
          width: MediaQuery.of(context).size.width / 5,
          color:
          fontColor(themeNotifier.getTheme()) ? Colors.white : Colors.black,
        ),
        Image.asset(
          'Icons/oven.png',
          width: MediaQuery.of(context).size.width / 5,
          color:
          fontColor(themeNotifier.getTheme()) ? Colors.white : Colors.black,
        ),
       Container(
         width:MediaQuery.of(context).size.width / 5,
         decoration: BoxDecoration(
           color:fontColor(themeNotifier.getTheme()) ? Colors.white : Colors.black,
           shape: BoxShape.circle
         ),
         child: Center(
           child: Text('?',style: TextStyle(
             color: themeNotifier.getTheme(),
             fontSize: MediaQuery.of(context).size.width / 7
           ),textScaleFactor: 1,),
         ),
       )
      ];
    }
    else if (widget.Cat['name'] == 'أجهزة إلكترونية') {
      SubCat = [
        'هواتف محمولة',
        'لابتوبات',
        'إكسسوارات',
        'حواسيب',
        'شاشات',
        'أخرى'
      ];
      subIcon = [
        Icon(
          Icons.phone_android,
          size:MediaQuery.of(context).size.width / 5,
          color:
          fontColor(themeNotifier.getTheme()) ? Colors.white : Colors.black,
        ),
        Icon(
          Icons.laptop,
          size: MediaQuery.of(context).size.width / 5,
          color:
          fontColor(themeNotifier.getTheme()) ? Colors.white : Colors.black,
        ),
        Icon(
          Icons.headset,
          size: MediaQuery.of(context).size.width / 5,
          color:
          fontColor(themeNotifier.getTheme()) ? Colors.white : Colors.black,
        ),
        Icon(
          Icons.desktop_mac,
          size: MediaQuery.of(context).size.width / 5,
          color:
          fontColor(themeNotifier.getTheme()) ? Colors.white : Colors.black,
        ),
        Icon(
          Icons.tv,
          size: MediaQuery.of(context).size.width / 5,
          color:
          fontColor(themeNotifier.getTheme()) ? Colors.white : Colors.black,
        ),
        Container(
          width:MediaQuery.of(context).size.width / 5,
          decoration: BoxDecoration(
              color:fontColor(themeNotifier.getTheme()) ? Colors.white : Colors.black,
              shape: BoxShape.circle
          ),
          child: Center(
            child: Text('?',style: TextStyle(
                color: themeNotifier.getTheme(),
                fontSize: MediaQuery.of(context).size.width / 7
            ),textScaleFactor: 1,),
          ),
        ),
      ];
    }
    else if (widget.Cat['name'] == 'مفروشات') {
      SubCat = ['أسّرة', 'صوفات', 'برادي', 'سجاد', 'أدوات مطبخ', 'أخرى'];
      subIcon = [
        Image.asset(
          'Icons/bed.png',
          width: MediaQuery.of(context).size.width / 5,
          color:
          fontColor(themeNotifier.getTheme()) ? Colors.white : Colors.black,
        ),
        Image.asset(
          'Icons/sofa.png',
          width: MediaQuery.of(context).size.width / 5,
          color:
          fontColor(themeNotifier.getTheme()) ? Colors.white : Colors.black,
        ),
        Image.asset(
          'Icons/curtain.png',
          width: MediaQuery.of(context).size.width / 5,
          color:
          fontColor(themeNotifier.getTheme()) ? Colors.white : Colors.black,
        ),
        Image.asset(
          'Icons/carpet.png',
          width: MediaQuery.of(context).size.width / 5,
          color:
          fontColor(themeNotifier.getTheme()) ? Colors.white : Colors.black,
        ),
        Image.asset(
          'Icons/cooking.png',
          width: MediaQuery.of(context).size.width / 5,
          color:
          fontColor(themeNotifier.getTheme()) ? Colors.white : Colors.black,
        ),
        Container(
          width:MediaQuery.of(context).size.width / 5,
          decoration: BoxDecoration(
              color:fontColor(themeNotifier.getTheme()) ? Colors.white : Colors.black,
              shape: BoxShape.circle
          ),
          child: Center(
            child: Text('?',style: TextStyle(
                color: themeNotifier.getTheme(),
                fontSize: MediaQuery.of(context).size.width / 7
            ),textScaleFactor: 1,),
          ),
        ),
      ];
    } else if (widget.Cat['name'] == 'عربات نقل') {
      SubCat = [
        'شاحنات',
        'دراجات هوائية',
        'دراجات نارية',
        'دراجات كهربائية',
        'أخرى'
      ];
      subIcon = [
        Image.asset(
          'Icons/truck.png',
          width: MediaQuery.of(context).size.width / 5,
          color:
          fontColor(themeNotifier.getTheme()) ? Colors.white : Colors.black,
        ),
        Image.asset(
          'Icons/bike.png',
          width: MediaQuery.of(context).size.width / 5,
          color:
          fontColor(themeNotifier.getTheme()) ? Colors.white : Colors.black,
        ),
        Image.asset(
          'Icons/bike (1).png',
          width: MediaQuery.of(context).size.width / 5,
          color:
          fontColor(themeNotifier.getTheme()) ? Colors.white : Colors.black,
        ),
        Image.asset(
          'Icons/bike (2).png',
          width: MediaQuery.of(context).size.width / 5,
          color:
          fontColor(themeNotifier.getTheme()) ? Colors.white : Colors.black,
        ),
        Container(
          width:MediaQuery.of(context).size.width / 5,
          decoration: BoxDecoration(
              color:fontColor(themeNotifier.getTheme()) ? Colors.white : Colors.black,
              shape: BoxShape.circle
          ),
          child: Center(
            child: Text('?',style: TextStyle(
                color: themeNotifier.getTheme(),
                fontSize: MediaQuery.of(context).size.width / 7
            ),textScaleFactor: 1,),
          ),
        ),
      ];
    } else if (widget.Cat['name'] == 'عقارات') {
      SubCat = ['مزارع', 'منازل', 'محال تجارية', 'أخرى'];
      subIcon = [
        Image.asset(
          'Icons/tree.png',
          width: MediaQuery.of(context).size.width / 5,
          color:
          fontColor(themeNotifier.getTheme()) ? Colors.white : Colors.black,
        ),
        Image.asset(
          'Icons/real-estate.png',
          width: MediaQuery.of(context).size.width / 5,
          color:
          fontColor(themeNotifier.getTheme()) ? Colors.white : Colors.black,
        ),
        Image.asset(
          'Icons/market.png',
          width: MediaQuery.of(context).size.width / 5,
          color:
          fontColor(themeNotifier.getTheme()) ? Colors.white : Colors.black,
        ),
        Container(
          width:MediaQuery.of(context).size.width / 5,
          decoration: BoxDecoration(
              color:fontColor(themeNotifier.getTheme()) ? Colors.white : Colors.black,
              shape: BoxShape.circle
          ),
          child: Center(
            child: Text('?',style: TextStyle(
                color: themeNotifier.getTheme(),
                fontSize: MediaQuery.of(context).size.width / 7
            ),textScaleFactor: 1,),
          ),
        ),
      ];
    }
    else {
      SubCat = [
        'ملابس ولادي',
        'ملابس نسواني',
        'ملابس رجالي',
        'أحذية ولادي',
        'أحذية نسواني',
        'أحذية رجالي',
        'أخرى'
      ];
      subIcon = [
        Image.asset(
          'Icons/baby.png',
          width: MediaQuery.of(context).size.width / 5,
          color:
          fontColor(themeNotifier.getTheme()) ? Colors.white : Colors.black,
        ),
        Image.asset(
          'Icons/dress.png',
          width: MediaQuery.of(context).size.width / 5,
          color:
          fontColor(themeNotifier.getTheme()) ? Colors.white : Colors.black,
        ),
        Image.asset(
          'Icons/shirt.png',
          width: MediaQuery.of(context).size.width / 5,
          color:
          fontColor(themeNotifier.getTheme()) ? Colors.white : Colors.black,
        ),
        Image.asset(
          'Icons/baby-shoes.png',
          width: MediaQuery.of(context).size.width / 5,
          color:
          fontColor(themeNotifier.getTheme()) ? Colors.white : Colors.black,
        ),
        Image.asset(
          'Icons/shoe.png',
          width: MediaQuery.of(context).size.width / 5,
          color:
          fontColor(themeNotifier.getTheme()) ? Colors.white : Colors.black,
        ),
        Image.asset(
          'Icons/shoes.png',
          width: MediaQuery.of(context).size.width / 5,
          color:
          fontColor(themeNotifier.getTheme()) ? Colors.white : Colors.black,
        ),
        Container(
          width:MediaQuery.of(context).size.width / 5,
          decoration: BoxDecoration(
              color:fontColor(themeNotifier.getTheme()) ? Colors.white : Colors.black,
              shape: BoxShape.circle
          ),
          child: Center(
            child: Text('?',style: TextStyle(
                color: themeNotifier.getTheme(),
                fontSize: MediaQuery.of(context).size.width / 7
            ),textScaleFactor: 1,),
          ),
        ),
      ];
    }
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18)
        ),
        centerTitle: true,
        title: Text(
          '${widget.Cat['name']}',
          textScaleFactor: 1,
          style: TextStyle(
            fontFamily: ArabicFonts.Cairo,
            package: 'google_fonts_arabic',
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio:
                  (MediaQuery.of(context).copyWith().size.width / 2) /
                      (MediaQuery.of(context).copyWith().size.height / 4),
              crossAxisCount: 2),
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemBuilder: (_, index) {
            return SafeArea(
              bottom: true,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return CatPost(widget.Cat,SubCat[index]);
                  }));
                },
                borderRadius: BorderRadius.circular(14),
                splashColor: themeNotifier.getplaceHolderColor(),
                child: Stack(
                  children: <Widget>[
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      color: themeNotifier.getTheme(),
                      child: Center(
                        child: subIcon[index],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(bottom:MediaQuery.of(context).size.height*0.004,),
                        child: Text(
                          '${SubCat[index]}',
                          textScaleFactor: 1,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: fontColor(themeNotifier.getTheme())
                                ? Colors.white
                                : Colors.black,
                            fontFamily: ArabicFonts.Cairo,
                            package: 'google_fonts_arabic',
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          itemCount: SubCat.length,
        ),
      ),
    );
  }
}
