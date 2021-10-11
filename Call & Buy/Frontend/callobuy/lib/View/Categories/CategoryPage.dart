import 'package:callobuy/View/Categories/CatPost.dart';
import 'package:callobuy/View/Categories/SubCategories.dart';
import 'package:callobuy/View/Settings/Formates.dart';
import 'package:callobuy/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

List Cat = [
  {
    'name': 'أجهزة إلكترونية',
    'image': 'images/electronics.jpg',
    'color': Colors.black
  },
  {
    'name': 'أجهزة كهربائية',
    'image': 'images/electricity.jpg',
    'color': Colors.black
  },
  {
    'name': 'مفروشات',
    'image': 'images/furniture.jpg',
    'color': themeNotifier.getTheme()
  },
  {'name': 'ملابس', 'image': 'images/clothes.jpg', 'color': Colors.white},
  {'name': 'عقارات', 'image': 'images/building.jpg', 'color': Colors.white},
  {'name': 'عربات نقل', 'image': 'images/vechiles.jpg', 'color': Colors.white},
  {'name': 'أخرى', 'image': 'images/others.jpg', 'color': Colors.white}
];

class _CategoryPageState extends State<CategoryPage> {
  var _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    var rat;
    if (MediaQuery.of(context).copyWith().size.height < 580) {
      rat = 5;
    } else {
      rat = 10;
    }
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(18))
        ),
        title: Text(
          'Shekh Express',
          textScaleFactor: 1,
          style: TextStyle(
              fontFamily: ArabicFonts.Cairo,
              package: 'google_fonts_arabic'
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          textDirection: TextDirection.rtl,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).copyWith().size.height / 12,
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 15,
                ),
                child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "جميع الفئات",
                      style: TextStyle(
                          color: fontColor(themeNotifier.getbackground())
                              ? Colors.white
                              : Colors.black,
                          fontFamily: ArabicFonts.Cairo,
                          package: 'google_fonts_arabic'),
                      textScaleFactor: 1,
                    )),
              ),
            ),
            Padding(padding: EdgeInsets.all(1)),
            GridView.builder(
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
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder:(_){
                        if (Cat[index]['name']=='أخرى'){
                          return CatPost(Cat[index],'أخرى');
                        }
                        else
                        return SubCategories(Cat[index]);
                      }));
                    },
                    borderRadius: BorderRadius.circular(14),
                    splashColor: themeNotifier.getplaceHolderColor(),
                    child: Stack(
                      children: <Widget>[
                        Card(
                    elevation:7,
                          shape:RoundedRectangleBorder(
                            side:BorderSide(color: themeNotifier.getTheme(),width: 3),
                            borderRadius: BorderRadius.circular(14)
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Image.asset(
                              Cat[index]['image'],
                              fit: BoxFit.cover,
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                        ),
                        Align(
                          alignment:Alignment.bottomCenter,
                          child: Padding(
                            padding:  EdgeInsets.only(bottom: 8),
                            child: Container(
                              decoration:BoxDecoration(
                                color:themeNotifier.getTheme().withOpacity(0.5),
                                borderRadius: BorderRadius.circular(14)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('${Cat[index]['name']}',textScaleFactor: 1,style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: fontColor(themeNotifier.getTheme())?Colors.white.withOpacity(0.5):Colors.black.withOpacity(0.5),
                                  fontFamily: ArabicFonts.Cairo,
                                  package: 'google_fonts_arabic',
                                ),),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              itemCount: Cat.length,
            )
          ],
        ),
      ),
    );
  }
}
