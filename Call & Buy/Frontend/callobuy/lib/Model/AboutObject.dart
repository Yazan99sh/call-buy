import 'dart:convert';
import 'package:flushbar/flushbar.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

SharedPreferences sharedPreferences;

Future<List> GetImage(var pid) async {
  final response = await http.post(
      "https://callandbuy.000webhostapp.com/CallAndBuy/GetImageFrombase.php",
      body: {
        "pid": "$pid",
      });
  var jsonResponse = json.decode(response.body);

  return jsonResponse;
}
Future<Map> Checkfav(var pid) async {
  sharedPreferences = await SharedPreferences.getInstance();
  var id = sharedPreferences.getString("token");
  if (id == null || id==''){
    return {'log':'0'};
  }
  else {
    final response1 = await http.post(
        "https://callandbuy.000webhostapp.com/CallAndBuy/CheckFav.php",
        body: {
          "pid": "$pid",
          "id": "$id",
        });
    var jsonres = await json.decode(response1.body);
    return jsonres;
  }
}

removefav(var id, var pid) async {
  final response1 = await http.post(
      "https://callandbuy.000webhostapp.com/CallAndBuy/removFromFav.php",
      body: {
        "pid": "$pid",
        "id": "$id",
      });
}