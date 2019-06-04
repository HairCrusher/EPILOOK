import 'package:flutter/material.dart';
import 'package:flutter_app/Database/SerialModel.dart';
import 'package:flutter_app/Database/Database.dart';
import 'package:flutter_app/CardWidget2.dart';
import 'dart:math' as math;


class SerialsListPage extends StatefulWidget {

  SerialsListPage({Key key}) : super(key:key);

  @override
  State createState() => _SerialsListPageState();
}

class _SerialsListPageState extends State<SerialsListPage>{

  final _myListKey = GlobalKey<AnimatedListState>();

  void listStateUpdate(){
    this.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Serial>>(
        future: DBProvider.db.getAllSerials(),
        builder: (BuildContext context, AsyncSnapshot<List<Serial>> snapshot) {
          if(snapshot.hasData){
//            return AnimatedList(
//              key: _myListKey,
//              initialItemCount: snapshot.data.length,
//              itemBuilder: (BuildContext context, int index, Animation animation){
//                Serial item = snapshot.data[index];
//                  return SlideTransition(
//                    position: animation.drive(Tween(begin: Offset(0, 0), end: Offset(100, 0))),
//                    child: SerialCard(serial: item, listStateUpdate: this.listStateUpdate, key: UniqueKey(),),
//                  );
//              },
//            );
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index){
                  Serial item = snapshot.data[index];
                  return SerialCard(serial: item, listStateUpdate: this.listStateUpdate, key: UniqueKey(),);
                }
            );
//            return OrientationBuilder(
//              builder: (context, orientation) {
//                return GridView.count(
//                    crossAxisCount: orientation == Orientation.portrait ? 1 : 2,
//                    children: snapshot.data.map((item) => SerialCard(item, this.listStateUpdate)).toList(),
//                );
//              },
//            );
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