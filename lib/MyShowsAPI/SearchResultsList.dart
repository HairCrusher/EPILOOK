import 'package:flutter/material.dart';
import 'package:flutter_app/MyShowsAPI/MShowsAIP.dart';
import 'package:flutter_app/MyShowsAPI/Response.dart';
import 'package:flutter_app/MyShowsAPI/SearchResultCard.dart';

class SearchResultsList extends StatelessWidget {

  final String _query;

  SearchResultsList({String query}):_query = query;

  @override
  Widget build(BuildContext context) {
    if(_query == "") return Container();

    return Container(
      child: FutureBuilder<List<Result>>(
        future: MShowsAPI().search(_query),
        builder: (BuildContext context, AsyncSnapshot<List<Result>> snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.data.isNotEmpty) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    Result item = snapshot.data[index];
                    return SearchResultCard(serial: item);
                  }
              );
            }else{
              return Center(
                  child:  Text('Сериалов не найдено :(', style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize:16,
                  ),),
              );
            }
          }else{
              return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}