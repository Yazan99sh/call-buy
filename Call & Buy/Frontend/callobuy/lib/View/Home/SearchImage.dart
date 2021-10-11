import 'package:cached_network_image/cached_network_image.dart';
import 'package:callobuy/Model/Home/HomeScreen.dart';
import 'package:callobuy/View/Settings/Formates.dart';
import 'package:callobuy/main.dart';
import 'package:flutter/material.dart';
class SearchImage extends StatefulWidget {
  var id ;

  SearchImage(this.id);

  @override
  _SearchImageState createState() => _SearchImageState();
}

class _SearchImageState extends State<SearchImage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future:GetImage(widget.id),builder: (_,snapshot){
      List initdata=snapshot.data;
      if (snapshot.connectionState== ConnectionState.waiting){
        return Center(child: CircularProgressIndicator());
      }
      else if (snapshot.hasError || initdata.isEmpty){
        if (snapshot.hasError)
        return Center(child: Container(
          width: MediaQuery.of(context).copyWith().size.width,
          height: MediaQuery.of(context).copyWith().size.height,
          color:themeNotifier.getplaceHolderColor(),
          child:IconButton(icon:Icon(Icons.refresh,color:fontColor(themeNotifier.getplaceHolderColor())?Colors.white:Colors.black,
          ), onPressed: (){
            setState(() {
            });
          }),
        ));
        else return Center(child: Image.asset('images/Empty.png',width: MediaQuery.of(context).size.width/8.5,fit: BoxFit.cover,color: themeNotifier.getTheme(),));
      }
      else {
        var image = snapshot.data;
        return  CachedNetworkImage(
          useOldImageOnUrlChange: false,
          fit: BoxFit.cover,
          fadeInDuration: Duration(milliseconds: 10),
          fadeOutDuration: Duration(milliseconds: 10),
          imageUrl:'${image[0]['imagename']}',
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              Center(child: CircularProgressIndicator(value: downloadProgress.progress,backgroundColor:themeNotifier.getplaceHolderColor(),)),
          errorWidget: (context, url, error) => IconButton(icon:Icon(Icons.refresh,color:fontColor(themeNotifier.getplaceHolderColor())?Colors.white:Colors.black,
          ),onPressed: (){
            setState(() {
            });
          },),
        );
      }
    });
  }
}
