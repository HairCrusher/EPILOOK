import 'package:flutter/material.dart';
import 'package:image_picker_modern/image_picker_modern.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/Database/Database.dart';
import 'package:flutter_app/Database/SerialModel.dart';
import 'package:flutter_app/AppbarMenuItems.dart';

class AddSerialPage extends StatefulWidget {
  @override
  State createState() => AddSerialPageState();
}

class AddSerialPageState extends State<AddSerialPage> {
  File _image;
  String _title;
  String _desc;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  void removeImage() {
    setState(() {
      _image = null;
    });
  }


  void saveSerial() async {

    Serial serial = new Serial(
      title: _title,
      desc: _desc,
      episode: 1,
      season: 1,
      fav: false
    );

    await DBProvider.db.newSerial(serial, localFile: _image);

    Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
    Scaffold.of(context).showSnackBar(SnackBar(content: Text('Сериал добавлен!'),duration: Duration(seconds: 1),));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/logoText.png', height: 30,),
        actions: <Widget>[
          Theme(
//            data: Theme.of(context).copyWith(
//              cardColor: Colors.white,
//              appBarTheme: AppBarTheme(
//                actionsIconTheme: IconThemeData(
//                  color: Colors.deepOrange
//                )
//              )
//            ),
            data: ThemeData(cardColor: Color(0xFF191919)),
            child: PopupMenuButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              onSelected: (index) {
                Navigator.push(
                    this.context,
                    MaterialPageRoute(
                        builder: (context) => AppbarMenuItems.getPage(index)));
              },
              itemBuilder: (BuildContext context) {
                return AppbarMenuItems().menuList;
              },
            ),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: _image == null
                ? Container(
                    height: (MediaQuery.of(context).size.width - 20) * 0.7,
//              color: Colors.black,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.fromBorderSide(BorderSide(
                            color: Colors.blueAccent,
                            width: 2,
                            style: BorderStyle.solid))),
                    child: Center(
                      child: InkWell(
                        onTap: getImage,
                        child: Icon(
                          Icons.add_circle_outline,
                          color: Colors.blueAccent,
                          size: 50,
                        ),
                      ),
                    ),
                  )
                : Container(
                    height: (MediaQuery.of(context).size.width - 20) * 0.7,
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        FittedBox(
                          fit: BoxFit.cover,
                          child: Image.file(
                            _image,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        Positioned(
                          height: 100,
                          width: 100,
                          right: 0,
                          top: 0,
                          child: InkWell(
                            onTap: removeImage,
                            child: Icon(
                              Icons.remove_circle_outline,
                              color: Colors.white,
                              size: 50,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              style: TextStyle(color: Colors.white, fontSize: 20),
              decoration: InputDecoration(
                labelText: 'Название сериала',
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent)),
              ),
              onChanged: (str) {
                _title = str;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              style: TextStyle(color: Colors.white, fontSize: 20),
              maxLines: 10,
              minLines: 3,
              decoration: InputDecoration(
                labelText: 'Описание сериала',
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent)),
              ),
              onChanged: (str) {
                _desc = str;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: RaisedButton(
                  onPressed: saveSerial,
                  child: Text('Добавить'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
