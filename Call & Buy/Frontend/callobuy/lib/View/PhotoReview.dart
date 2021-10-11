import 'package:cached_network_image/cached_network_image.dart';
import 'package:callobuy/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
class PhotoReview extends StatefulWidget {
  var i;
  var init;
  @override
  _PhotoReviewState createState() => _PhotoReviewState();

  PhotoReview(this.i,this.init);
}

class _PhotoReviewState extends State<PhotoReview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom:Radius.elliptical(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height/30)),
          ),
          centerTitle: true,
          title: Text(
            "مستعرض الصور",
            style: TextStyle(
              fontFamily: ArabicFonts.Cairo,
              package: 'google_fonts_arabic',
            ),
            textScaleFactor: 1,
          ),
        ),
      body:  SafeArea(
        top: true,
        child: Container(
          height:MediaQuery.of(context).size.height ,
          width:MediaQuery.of(context).size.width,
          child: PhotoViewGallery.builder(
            scrollPhysics:BouncingScrollPhysics(),
            itemCount: widget.i.length,
            pageController:PageController(initialPage:widget.init) ,
            builder: (BuildContext context, int index) {
              return PhotoViewGalleryPageOptions(
                minScale: PhotoViewComputedScale.contained * 0.8,
                imageProvider: CachedNetworkImageProvider('${widget.i[index]['imagename']}'),
                initialScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered,
                  heroAttributes: PhotoViewHeroAttributes(tag: widget.i[index]['imagename']),
              );
            },
            backgroundDecoration: BoxDecoration(
              color:themeNotifier.getbackground(),
            ),
            //minScale: PhotoViewComputedScale.contained * 0.8,
            //imageProvider:CachedNetworkImageProvider('${widget.i}',
            ),
          ),
        ),
      );
  }
}
