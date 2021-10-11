
import 'dart:convert';

import 'package:http/http.dart' as http;
Future <Map> GetSallerInfo(var id) async{
  final response = await http.post("https://callandbuy.000webhostapp.com/CallAndBuy/getSellerInfo.php",body: {
    "id":"$id",
  });
  var jsonResponse = json.decode(response.body);
  return jsonResponse;
}
Future removeLiker(var toid, var fromid) async {
  final response = await http.post("https://callandbuy.000webhostapp.com/CallAndBuy/RemovFromLiker.php",body: {
    "Fromid":"$fromid",
    "Toid":"$toid",
  });
}