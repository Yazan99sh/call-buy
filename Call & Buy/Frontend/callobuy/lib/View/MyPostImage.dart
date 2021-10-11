import 'package:cached_network_image/cached_network_image.dart';
import 'package:callobuy/Model/Home/HomeScreen.dart';
import 'package:callobuy/View/PhotoReview.dart';
import 'package:callobuy/main.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'Settings/Formates.dart';
class MyPostImage extends StatefulWidget {
  var pid;

  MyPostImage(this.pid);

  @override
  _MyPostImageState createState() => _MyPostImageState();
}

class _MyPostImageState extends State<MyPostImage> {
  @override
  Widget build(BuildContext context) {
    var imagerat;
    if(MediaQuery.of(context).copyWith().size.height<500){
imagerat=2.65;
    }
    else if(MediaQuery.of(context).copyWith().size.height<580){
imagerat=2.75;
    }
    else if(MediaQuery.of(context).copyWith().size.height < 640) {
      imagerat=2.8;
    }
    else if (MediaQuery.of(context).copyWith().size.height < 735) {
imagerat=2.8;
    }
    else if (MediaQuery.of(context).copyWith().size.height < 790) {
      imagerat=3.0;
    }
    else {
imagerat=3.2;
    }
    return FutureBuilder(
      future:GetImage(widget.pid),
      builder:(_,snapshot){
        if (snapshot.connectionState==ConnectionState.waiting){
          return Container(
            height: MediaQuery.of(context).copyWith().size.height/imagerat,
            width: MediaQuery.of(context).copyWith().size.width,
            color:themeNotifier.getplaceHolderColor(),
            child: Center(
              child:CircularProgressIndicator(
                valueColor:
                AlwaysStoppedAnimation<
                    Color>(
                  fontColor(themeNotifier.getplaceHolderColor())?Colors.white:Colors.black,),
              ) ,
            ),
          );
        }
        else if (snapshot.hasError){
          return Container(
            height: MediaQuery.of(context).copyWith().size.height/imagerat,
            width: MediaQuery.of(context).copyWith().size.width,
            color:themeNotifier.getplaceHolderColor(),
            child: Center(
              child:IconButton(icon:Icon(Icons.refresh, color:fontColor(themeNotifier.getplaceHolderColor())?Colors.white:Colors.black,), onPressed:(){
                setState(() {
                });
              }),
            ),
          );
        }
        else{
          List image =snapshot.data;
          return Container(
            height: MediaQuery.of(context).copyWith().size.height/imagerat,
            width: MediaQuery.of(context).copyWith().size.width,
            child: Carousel(
              onImageTap: (i){
                Navigator.of(context).push(MaterialPageRoute(builder:(_){
                  return PhotoReview(image,i);
                }));
              },
              dotColor:themeNotifier.getplaceHolderColor(),
              boxFit: BoxFit.cover,
              autoplay: false,
              animationCurve: Curves.fastOutSlowIn,
              animationDuration: Duration(milliseconds: 1000),
              dotSize: 6.0,
              dotIncreasedColor:themeNotifier.getTheme(),
              dotBgColor: Colors.transparent,
              dotPosition: DotPosition.bottomCenter,
              dotVerticalPadding: 10.0,
              showIndicator: true,
              indicatorBgPadding: 7.0,
              borderRadius: false,
              images: image.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return ClipRRect(
                      child:CachedNetworkImage(
                        useOldImageOnUrlChange: false,
                        fit: BoxFit.cover,
                        fadeInDuration: Duration(milliseconds: 10),
                        fadeOutDuration: Duration(milliseconds: 10),
                        imageUrl:'${i['imagename']}',
                        progressIndicatorBuilder: (context, url, downloadProgress) =>
                            Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                        errorWidget: (context, url, error) => IconButton(icon:Icon(Icons.refresh,color:fontColor(themeNotifier.getplaceHolderColor())?Colors.white:Colors.black,),onPressed:(){
                          setState(() {
                          });
                        },),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          );
        }
      } ,
    );
  }
}
