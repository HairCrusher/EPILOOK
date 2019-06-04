import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/Database/SerialModel.dart';
import 'package:flutter_html/flutter_html.dart';

class SinglePage extends StatefulWidget {
  final Serial _serial;

  SinglePage({Serial serial}) : _serial = serial;

  @override
  State createState() => SinglePageState();
}

class SinglePageState extends State<SinglePage> {
  @override
  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('EPILOOK'),
//      ),
//      body: ListView(
//        children: <Widget>[
//          Container(
//            decoration: BoxDecoration(
//                image: DecorationImage(
//                    image: FileImage(File(_serial.poster)), fit: BoxFit.cover)),
//            height: 200,
//          ),
//          Padding(
//            padding: const EdgeInsets.all(8.0),
//            child: Column(
//              children: <Widget>[
//                Text(
//                  _serial.title,
//                  style: TextStyle(fontSize: 25),
//                ),
//                Html(
//                  data: _serial.desc,
//                  padding: EdgeInsets.all(10),
//                ),
//              ],
//            ),
//          ),
//        ],
//      ),
//    );
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 200,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: Hero(tag: 'serial_'+widget._serial.id.toString(), child: Image.file(File(widget._serial.poster), fit: BoxFit.cover)),
                title: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(widget._serial.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold
                    ),
                ),
                ),
              ),
            )
          ];
        },
        scrollDirection: Axis.vertical,
        body: Padding(
          padding: EdgeInsets.all(8),
          child: Html(
            defaultTextStyle: TextStyle(
              color: Colors.white
            ),
            data: widget._serial.desc,
            padding: EdgeInsets.all(10),
          ),
        ),
      ),
    );
  }
}
