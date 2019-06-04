import 'package:flutter/material.dart';
import 'package:flutter_app/MyShowsAPI/SearchResultsList.dart';
import 'dart:io';

class SearchPage extends StatefulWidget {

  SearchPage({Key key}) : super(key:key);

  @override
  State createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  String query = "";

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadPage(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.hasData){
            return snapshot.data;
          }else{
            return Center(child: CircularProgressIndicator());
          }
        }
    );
  }

  Future loadPage() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                textInputAction: TextInputAction.search,
                style: TextStyle(
                  color: Colors.white
                ),
                decoration: InputDecoration(
                  labelText: "Поиск",
                  icon: Icon(Icons.search, color: Colors.blueAccent,),
                  border: InputBorder.none,
                ),
                onSubmitted: (String str) {
                  setState(() {
                    query = str;
                  });
                },
              ),
            ),
            Expanded(child: SearchResultsList(query: query)),
          ],
        );
      }
    } on SocketException catch (_) {
      return Center(child: Text('Необходим доступ к интернету', style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold
      ),),);
    }
  }
}
