import 'dart:convert';
import 'package:callobuy/View/Settings/Settings.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:callobuy/View/MyPostPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
SharedPreferences sharedPreferences;
Future<List> GetImage(var pid) async {
  Dio dios = new Dio();
  dios.interceptors.add(DioCacheManager(CacheConfig(maxMemoryCacheCount:1000,baseUrl:"https://callandbuy.000webhostapp.com/CallAndBuy/GetImageFrombase.php")).interceptor);

  final response = await dios.post("https://callandbuy.000webhostapp.com/CallAndBuy/GetImageFrombase.php",
    data:FormData.fromMap({
    "pid": pid,
  }),
  );
  var jsonResponse = await json.decode(response.data);
  return jsonResponse;
}
Future<List> getPosts() async {
  Dio dios = new Dio();
  sharedPreferences=await SharedPreferences.getInstance();
  var jsonResponse;
  if (sharedPreferences.get('address')=='' || sharedPreferences.get('address')==null) {
    dios.interceptors.add(DioCacheManager(CacheConfig(baseUrl:"https://callandbuy.000webhostapp.com/CallAndBuy/GetPostInfo.php")).interceptor);
    final response = await dios.post('https://callandbuy.000webhostapp.com/CallAndBuy/GetPostInfo.php',
     // options:buildConfigurableCacheOptions(maxAge:Duration(days: 3),maxStale: Duration(days: 7)),
    );
     jsonResponse = await json.decode(response.data);
  }
  else {
    dios.interceptors.add(DioCacheManager(CacheConfig(baseUrl: "https://callandbuy.000webhostapp.com/CallAndBuy/getPostAddress.php ")).interceptor);
    var response = await dios
        .post("https://callandbuy.000webhostapp.com/CallAndBuy/getPostAddress.php",data:FormData.fromMap({'address':"${sharedPreferences.get('address')}"}),
        //options: buildCacheOptions(Duration(days: 3))
    );
     jsonResponse = await json.decode(response.data);
  }
  List<dynamic>Post =new List();
  if (jsonResponse!=null){
    for(int i=0;i<jsonResponse.length;i++){
      String btime=jsonResponse[i]['expiredDate'];
      var byear =int.parse(btime.substring(0,4));
      var bmonth=int.parse(btime.substring(5,7));
      var bday=int.parse(btime.substring(8,10));
      var bhour=int.parse(btime.substring(11,13));
      var bminute=int.parse(btime.substring(14,16));
      var bsecond=int.parse(btime.substring(17,19));
      int estimateTs = DateTime(byear, bmonth, bday, bhour, bminute,bsecond).millisecondsSinceEpoch;
      int now = DateTime
          .now()
          .millisecondsSinceEpoch;
      Duration remaining = Duration(milliseconds: estimateTs - now);
      if (remaining.toString().contains('-')){
        DeleteImage(jsonResponse[i]['pid']);
        deletePost(jsonResponse[i]['pid']);
      }else {
        Post.add(jsonResponse[i]);
      }
    }
  }
  return Post;
}
Future<List> getAds() async {
  Dio dios = new Dio();
  dios.interceptors.add(DioCacheManager(CacheConfig(baseUrl: "https://callandbuy.000webhostapp.com/CallAndBuy/GetAds.php")).interceptor);
  final response = await dios.get("https://callandbuy.000webhostapp.com/CallAndBuy/GetAds.php",
      options: buildCacheOptions(Duration(days: 3),)
  );
  var jsonResponse = await json.decode(response.data);
  if (jsonResponse== false ) jsonResponse =[];
  return jsonResponse;
}
Future gotoSettengs(BuildContext context) async {
  Map result = await Navigator.of(context).push(MaterialPageRoute(
    builder: (BuildContext context) {
      return Settings();
    },
  ));
}
Future <List> Search (var word,bool filter,bool val,var subcategory,var FromePrice,var ToPrice,var site,var sort,var ThingType) async {
  Dio dios = new Dio();
  if (!filter) {
    dios.interceptors.add(DioCacheManager(CacheConfig(baseUrl: "https://callandbuy.000webhostapp.com/CallAndBuy/Search.php")).interceptor);
    final response = await dios.post(
        "https://callandbuy.000webhostapp.com/CallAndBuy/Search.php",
        data: FormData.fromMap({
          "search": "$word",
        }),
       // options: buildCacheOptions(Duration(days: 3))
    );
    var jsonResponse = await json.decode(response.data);

    return jsonResponse;
  }
  else{
    var ListSort={'ترتيب بحسب التاريخ من الأقدم للأحدث':'history default','ترتيب بحسب التاريخ من الأحدث للأقدم':'history Desc','ترتيب بحسب السعر من الأرخص للأغلى':'Price Asc','ترتيب بحسب السعر من الأغلى للأرخص':'Price Desc',};
    dios.interceptors.add(DioCacheManager(CacheConfig(baseUrl: "https://callandbuy.000webhostapp.com/CallAndBuy/FiltredSearch.php")).interceptor);
    final response = await dios.post(
        "https://callandbuy.000webhostapp.com/CallAndBuy/FiltredSearch.php",
        data:  FormData.fromMap({
          "search": "$word",
          'checkbox':"$val",
          'Subtype':"$subcategory",
          'FromePrice':"$FromePrice",
          'ToPrice':"$ToPrice",
          'site':"$site",
          'sort':"${ListSort[sort]}",
          'ThingType':"$ThingType"
        }),
      //  options: buildCacheOptions(Duration(days: 3))
    );
    var jsonResponse = await json.decode(response.data);
    return jsonResponse;
  }
}