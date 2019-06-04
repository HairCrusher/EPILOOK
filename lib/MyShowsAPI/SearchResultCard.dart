import 'package:flutter/material.dart';
import 'package:flutter_app/Database/Database.dart';
import 'package:flutter_app/MyShowsAPI/Response.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_html/flutter_html.dart';

class SearchResultCard extends StatefulWidget {
  final Result _serial;

  SearchResultCard({Result serial}) : _serial = serial;

  @override
  State createState() => SearchResultCardState(_serial);
}

class SearchResultCardState extends State<SearchResultCard> {
  Result serial;

  SearchResultCardState(Result res) {
    serial = res;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      elevation: 10,
      clipBehavior: Clip.antiAlias,
      shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4))),
      child: Stack(
        children: <Widget>[
          Center(
            child: CachedNetworkImage(
              width: MediaQuery.of(context).size.width - 5,
//              height: 192,
              imageUrl: serial.image,
              placeholder: (context, url) => Container(
                height: 192,
                child: Center(child: CircularProgressIndicator(),),
              ),
              errorWidget: (context, url, error) => new Icon(Icons.error),
//              errorWidget: (context, url, error) => new Text(error.toString()),
              fit: BoxFit.cover,
            ),
//          child: FadeInImage.assetNetwork(
//              placeholder: 'assets/loading.gif',
//              image: serial.image,
//              fit: BoxFit.cover,
//
//          ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            width: MediaQuery.of(context).size.width - 5,
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    serial.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(color: Colors.black, blurRadius: 4),
                      ]
                    ),
                  ),
                ),
                Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () async {
                        await DBProvider.db.newSerial(serial.toSerial());
                        Scaffold.of(context).showSnackBar(SnackBar(content: Text('Сериал добавлен!'),duration: Duration(seconds: 1),));
                    },
                      color: Colors.blueAccent,
                      child: Text(
                        "Добавить",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    RaisedButton(
                      child: Text("Описание"),
                      onPressed: () {
                        Navigator.push(context, PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (BuildContext context, _, __) => DescPopup(title: serial.title, desc: serial.description),
                          transitionsBuilder: (___, animation, _____, child){
                            return FadeTransition(
                              opacity: animation,
                              child: ScaleTransition(scale: animation, child: child,),
                            );
                          }
                        ));
                      },
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

//  @override
//  Widget build(BuildContext context) {
//    return Card(
//      child: Container(
//        padding: EdgeInsets.all(10.0),
//        decoration: BoxDecoration(
//          borderRadius: BorderRadius.all(Radius.circular(4)),
//          image: DecorationImage(
//              image: CachedNetworkImageProvider(serial.image,
//
//              ),
//              fit: BoxFit.cover),
//        ),
//        margin: EdgeInsets.all(10.0),
//        child: Column(
//          children: <Widget>[
//            InkWell(
//              child: Text(
//                serial.title,
//                softWrap: true,
//                maxLines: 2,
//                overflow: TextOverflow.ellipsis,
//                style: TextStyle(
//                    fontSize: 20.0,
//                    color: Colors.white,
//                    fontWeight: FontWeight.bold,
//                    shadows: [
//                      Shadow(color: Colors.black, blurRadius: 10),
//                    ]),
//              ),
//            ),
//            Padding(
//              padding: const EdgeInsets.only(bottom: 50),
//              child: IconButton(
//                icon: Icon(Icons.add),
//                onPressed: () {
//                  print('+++++++++++++');
//                },
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//  }

}

class DescPopup extends StatelessWidget {
  final String _title;
  final String _desc;

  DescPopup({String title, String desc}):_title = title, _desc = desc;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_title, style: TextStyle(fontSize: 18),),
      content: SingleChildScrollView(
        child: Html(
          data: _desc,
          padding: EdgeInsets.all(10),
          defaultTextStyle: TextStyle(color: Colors.white),
        ),
      ),
      actions: <Widget>[
        RaisedButton(
          textColor: Colors.white,
          child: Text('Назад'),
          color: Colors.blueAccent,
          onPressed: (){
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
