import 'package:flutter/material.dart';
import 'package:flutter_app/Database/SerialModel.dart';
import 'package:flutter_app/Database/Database.dart';
import 'package:flutter_app/CardWidget.dart';
import 'dart:math' as math;


class FavListPage extends StatefulWidget {

  FavListPage({Key key}) : super(key:key);

  @override
  State createState() => _FavListPageState();
}

class _FavListPageState extends State<FavListPage>{

  void listStateUpdate(){
    this.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(title: Text('Список сериалов')),
      body: FutureBuilder<List<Serial>>(
          future: DBProvider.db.getFavSerials(),
          builder: (BuildContext context, AsyncSnapshot<List<Serial>> snapshot) {
            if(snapshot.hasData){
              if(snapshot.data.length == 0)
                return Center(
                    child: Container(
                        height: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Вы еще не добавили ни одного\r\nсериала в избранное!', style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize:16,
                            ), textAlign: TextAlign.center,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.favorite_border, color: Colors.red, size: 40,),
                                Icon(Icons.arrow_forward, color: Colors.white, size: 40,),
                                Icon(Icons.favorite, color: Colors.red, size: 40,),
                              ],
                            ),
                            Text('Нажмите на сердечко\r\nна карточке сериала', style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize:16,
                            ), textAlign: TextAlign.center,)
                          ],
                        )
                    )
                );

              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index){
                    Serial item = snapshot.data[index];
                    return SerialCard(serial: item, listStateUpdate: this.listStateUpdate, key: UniqueKey(),);
                  }
              );
            }else{
              return Center(child: CircularProgressIndicator());
            }
          }
      ),
//      floatingActionButton: FloatingActionButton(
//        child: Icon(Icons.add),
//        onPressed: () async {
//          Serial rnd = testSerials[math.Random().nextInt(testSerials.length)];
//          await DBProvider.db.newSerial(rnd);
////          debugPrint(DBProvider.db.getAllSerials().toString());
//          setState(() {});
//        },
//      ),
    );
  }

  List<Serial> testSerials = [
    Serial(title: 'Serial 1', poster: 'tree.jpg', fav: false, desc: 'saddsasda', episode: 7, season: 2),
    Serial(title: 'Serial 2', poster: 'tree.jpg', fav: false, desc: 'saddsasda', episode: 6, season: 4),
    Serial(title: 'Serial 3', poster: 'tree.jpg', fav: false, desc: 'saddsasda', episode: 5, season: 5),
    Serial(title: 'Serial 4', poster: 'tree.jpg', fav: false, desc: 'saddsasda', episode: 4, season: 6),
    Serial(title: 'Serial 5', poster: 'tree.jpg', fav: false, desc: 'saddsasda', episode: 3, season: 7),
    Serial(title: 'Serial 6', poster: 'tree.jpg', fav: false, desc: 'saddsasda', episode: 2, season: 1),
    Serial(title: 'Serial 7', poster: 'tree.jpg', fav: false, desc: 'saddsasda', episode: 1, season: 3),
  ];
}