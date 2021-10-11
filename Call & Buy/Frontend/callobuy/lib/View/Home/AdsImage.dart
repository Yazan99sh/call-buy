import 'package:cached_network_image/cached_network_image.dart';
import 'package:callobuy/View/Settings/Formates.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class AdsImage extends StatefulWidget {
  Map i;

  AdsImage(this.i);

  @override
  _AdsImageState createState() => _AdsImageState();
}

class _AdsImageState extends State<AdsImage> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      useOldImageOnUrlChange: false,
      fit: BoxFit.cover,
      fadeInDuration: Duration(milliseconds: 10),
      fadeOutDuration: Duration(milliseconds: 10),
      imageUrl:'${widget.i['ad']}',
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
      errorWidget: (context, url, error) => IconButton(icon:Icon(Icons.refresh,color:fontColor(themeNotifier.getplaceHolderColor())?Colors.white:Colors.black,),onPressed:(){
        setState(() {
        });
      },),
    );
  }
}
