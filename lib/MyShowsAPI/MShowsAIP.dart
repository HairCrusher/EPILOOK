import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_app/MyShowsAPI/Response.dart';

class MShowsAPI {
  static final String url = "https://api.myshows.me/v2/rpc/";
  static final String jsonrpc = "2.0";
  static final String id = "myshows_fitality";
  static final Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json"
  };

  final Map<String, dynamic> data = {
    "jsonrpc": jsonrpc,
    "method": "",
    "params": {},
    "id": id
  };

  Future<List<Result>> method (String method, Map<String, dynamic> params) async {
      Map<String, dynamic> resData = data;
      resData['method'] = method;
      resData['params'] = params;
      var res = await http.post(url, body: jsonEncode(resData), headers: headers);
      String body = utf8.decode(res.bodyBytes);
      List<Result> list =
        body.isNotEmpty ? ApiResponse.fromMap(jsonDecode(body)).result : [];
      return list;
  }

  search (String query) {
    return method("shows.Search", {"query": query});
  }
}