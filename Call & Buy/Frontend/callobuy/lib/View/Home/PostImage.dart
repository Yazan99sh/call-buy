import 'package:cached_network_image/cached_network_image.dart';
import 'package:callobuy/Model/Home/HomeScreen.dart';
import 'package:callobuy/View/Home/HomeScreen.dart';
import 'package:callobuy/View/Settings/Formates.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
class PostImage extends StatefulWidget {
  var pid;
  Color Primary;
  Color Shadow;
  @override
  _PostImageState createState() => _PostImageState();

  PostImage(this.pid,this.Primary,this.Shadow);
}

class _PostImageState extends State<PostImage> {
  @override
  Widget build(BuildContext context) {
    var rat;
    var ratim;
    if (MediaQuery.of(context).copyWith().size.height < 500){
      rat = 2.3;
      ratim = 5;
    }
    else if (MediaQuery.of(context).copyWith().size.height < 580) {
      rat = 2.6;
      ratim = 5;
    }
    else if (MediaQuery.of(context).copyWith().size.height < 640) {
      rat = 2.55;
      ratim = 4.8;
    }
    else if (MediaQuery.of(context).copyWith().size.height <= 790) {
      rat = 2.8;
      ratim = 5;
    } else {
      rat = 3.2;
      ratim = 5.2;
    }
    return  FutureBuilder(
      future: GetImage(widget.pid),
      builder: (_, snapshotm) {
        if (snapshotm.connectionState ==
            ConnectionState.waiting) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: widget.Shadow,
                borderRadius:BorderRadius.circular(14),
              ),
              width:
              MediaQuery.of(context)
                  .copyWith()
                  .size
                  .width,
              height:MediaQuery.of(context)
                  .copyWith()
                  .size
                  .height /
                  ratim,
              child: Center(
                child: CircularProgressIndicator(

                ),
              ),
            ),
          );
        } else if (snapshotm.hasError) {
          return Padding(
            padding: EdgeInsets.all(8),
            child: Container(
              decoration: BoxDecoration(
                color: widget.Shadow,
                borderRadius:BorderRadius.circular(14),
              ),
              width:
              MediaQuery.of(context)
                  .copyWith()
                  .size
                  .width,
              height:
              MediaQuery.of(context)
                  .copyWith()
                  .size
                  .height /
                  ratim,
              child:Center(
                child: IconButton(icon:Icon(Icons.refresh,color:fontColor(widget.Shadow)?Colors.white:Colors.black,), onPressed:(){
                  setState(() {
                  });
                }),
              ),
            ),
          );
        } else {
          List images = snapshotm.data;
          if (images.isNotEmpty)
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
             decoration: BoxDecoration(
               color:widget.Shadow,
               borderRadius: BorderRadius.circular(14),
             ),
              width:
              MediaQuery.of(context)
                  .copyWith()
                  .size
                  .width,
              height: MediaQuery.of(context)
                  .copyWith()
                  .size
                  .height /
                  ratim,
              child: ClipRRect(
                borderRadius:
                BorderRadius.circular(
                    14),
                child:Hero(
                  tag: 'tag-${images[0]['imagename']}',
                  child: CachedNetworkImage(
                    useOldImageOnUrlChange: false,
                    fit: BoxFit.cover,
                    fadeInDuration: Duration(milliseconds: 10),
                    fadeOutDuration: Duration(milliseconds: 10),
                    imageUrl:'${images[0]['imagename']}',
                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                        Center(child: CircularProgressIndicator(value: downloadProgress.progress,backgroundColor:widget.Shadow,)),
                    errorWidget: (context, url, error) => IconButton(icon:Icon(Icons.refresh,color:fontColor(widget.Shadow)?Colors.white:Colors.black,),onPressed: (){
                      setState(() {
                      });
                    },),
                  ),
                ),
              ),
            ),
          );
          else {
         return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
        decoration: BoxDecoration(
        color:widget.Shadow,
        borderRadius: BorderRadius.circular(14),
        ),
        width:
        MediaQuery.of(context)
            .copyWith()
            .size
            .width,
        height: MediaQuery.of(context)
            .copyWith()
            .size
            .height /
        ratim,
        child: ClipRRect(
        borderRadius:
        BorderRadius.circular(
        14),
        child:Center(child: Image.asset('images/Empty.png',fit: BoxFit.cover,width: MediaQuery.of(context).size.width/5,color:widget.Primary,)),
        ),
        ),
        );
          }
        }
      },
    );
  }
}
