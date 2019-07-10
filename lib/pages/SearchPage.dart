import 'package:flutter/material.dart';
import 'package:flutter_app/MyShowsAPI/SearchResultsList.dart';
import 'dart:io';

import 'package:flutter_app/pages/AddSerialPage.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

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
          if (snapshot.hasData) {
            return snapshot.data;
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Future loadPage() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10.0),
//              color: Colors.black,
              child: TextField(
                textInputAction: TextInputAction.search,
                style: TextStyle(color: Colors.white, fontSize: 20),
                decoration: InputDecoration(
                  labelText: "Поиск",
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.blueAccent,
                    size: 20,
                  ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent)),

//                  filled: true,
//                  fillColor: Colors.black,
                ),
                onChanged: (String str) {
                  if (str.length >= 3 || str.length == 0)
                    setState(() {
                      query = str;
                    });
                },
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
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Необходим доступ к интернету',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddSerialPage()));
              },
              child: Text('Добавьте сериал самостоятельно'),
            ),
          ],
        ),
      );
    }
  }
}
