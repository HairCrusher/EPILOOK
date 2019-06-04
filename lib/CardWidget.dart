import 'package:flutter/material.dart';
import 'package:flutter_app/pages/SinglePage.dart';
import 'package:flutter_app/Database/SerialModel.dart';
import 'package:flutter_app/Database/Database.dart';
import 'package:path/path.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class SerialCard extends StatefulWidget {
  final int id;
  final String title;
  final String desc;
  final String poster;
  final int season;
  final int episode;
  final bool fav;
  final Serial _serial;
  final Function _listStateUpdate;

//  SerialCard({
//    this.id,
//    this.title,
//    this.desc,
//    this.poster,
//    this.season,
//    this.episode,
//    this.fav,
//  });

  SerialCard({Key key, Serial serial, Function listStateUpdate})
      : _serial = serial,
        id = serial.id,
        title = serial.title,
        desc = serial.desc,
        poster = serial.poster,
        season = serial.season,
        episode = serial.episode,
        fav = serial.fav,
        _listStateUpdate = listStateUpdate,
        super(key: key);

  @override
  _SerialCardState createState() => _SerialCardState();
}

class _SerialCardState extends State<SerialCard> {
  int _id;
  int _episode;
  int _season;
  bool _fav;

  @override
  void initState() {
    super.initState();
    _id = widget.id;
    _episode = widget.episode;
    _season = widget.season;
    _fav = widget.fav;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    child: InkWell(
                      onTap: () => _goSingle(widget._serial),
                      child: Text(
                        '${widget.title}',
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(color: Colors.black, blurRadius: 10),
                            ]),
                      ),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                            _fav ? Icons.favorite : Icons.favorite_border,
                            color: Colors.red),
                        iconSize: 40,
                        onPressed: () => _tapFav(),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.white),
                        iconSize: 40,
                        onPressed: () => _openMenu(widget._serial),
                      )
                    ],
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                children: <Widget>[
                  Text(
                    'Сезон ',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(color: Colors.black, blurRadius: 10),
                        ]),
                  ),
                  InkWell(
                    onTap: () => _changeValues(widget._serial),
                    child: Text(
                      _season.toString(),
                      style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(color: Colors.black, blurRadius: 10),
                          ]),
                    ),
                  ),
                  Text(
                    ' серия ',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(color: Colors.black, blurRadius: 10),
                        ]),
                  ),
                  InkWell(
                    onTap: () => _changeValues(
                          widget._serial,
                        ),
                    child: Text(
                      _episode.toString(),
                      style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(color: Colors.black, blurRadius: 10),
                          ]),
                    ),
                  ),
                ],
              ),
//              child: Text(
//                'Сезон $_season серия $_episode',
//                style: TextStyle(
//                    fontSize: 20.0,
//                    color: Colors.white,
//                    fontWeight: FontWeight.bold,
//                    shadows: [
//                      Shadow(color: Colors.black, blurRadius: 10),
//                    ]),
//              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FloatingActionButton(
                  heroTag: 'btn1_$_id',
                  child: Icon(
                    Icons.chevron_left,
                    size: 50,
                  ),
                  onPressed: () => _minSeason(),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
                FloatingActionButton(
                  heroTag: 'btn2_$_id',
                  child: Icon(
                    Icons.remove,
                    size: 50,
                  ),
                  onPressed: () => _minEpisode(),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
                FloatingActionButton(
                  heroTag: 'btn3_$_id',
                  child: Icon(
                    Icons.add,
                    size: 50,
                  ),
                  onPressed: () => _plusEpisode(),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
                FloatingActionButton(
                  heroTag: 'btn4_$_id',
                  child: Icon(
                    Icons.chevron_right,
                    size: 50,
                  ),
                  onPressed: () => _plusSeason(),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
              ],
            )
          ],
        ),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          image: DecorationImage(
//              image: AssetImage(
//                'assets/images/${widget.poster}',
//              ),
              image: FileImage(File(widget.poster)),
              fit: BoxFit.cover),
        ),
      ),
      margin: EdgeInsets.all(10.0),
    );
  }

  _minSeason() {
    setState(() {
      _season = _season == 1 ? _season : _season - 1;
      DBProvider.db.changeSerialSe(_id, _season);
    });
  }

  _plusSeason() {
    setState(() {
      _season++;
      DBProvider.db.changeSerialSe(_id, _season);
    });
  }

  _minEpisode() {
    setState(() {
      _episode = _episode == 1 ? _episode : _episode - 1;
      DBProvider.db.changeSerialEp(_id, _episode);
    });
  }

  _plusEpisode() {
    setState(() {
      _episode++;
      DBProvider.db.changeSerialEp(_id, _episode);
    });
  }

  _tapFav() {
    setState(() {
      _fav = !_fav;
      DBProvider.db.changeSerialFav(_id, _fav);
    });
  }

  _goSingle(Serial serial) {
//    Navigator.pushNamed(this.context, '/single/' + serial.id.toString());
    Navigator.push(
        this.context,
        MaterialPageRoute(
            builder: (context) => SinglePage(
                  serial: serial,
                )));
  }

  _openMenu(Serial serial) {
    Navigator.push(
        this.context,
        PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, _, __) => CardPopup(
                serial: serial,
                listStateUpdate: widget._listStateUpdate,
              ),
        )).then((value) {
      setState(() {});
    });
  }

  _changeValues(Serial serial) {
    Navigator.push(
        this.context,
        PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, _, __) => ValuesPopup(
                serial: serial,
                listStateUpdate: widget._listStateUpdate,
              ),
        )).then((value) {
      setState(() {});
    });
  }
}

class CardPopup extends StatelessWidget {
  final Serial _serial;
  final Function _listStateUpdate;

  CardPopup({Serial serial, Function listStateUpdate})
      : _serial = serial,
        _listStateUpdate = listStateUpdate;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Удалить сериал из списка?'),
      actions: <Widget>[
        FlatButton(
          child: Text('Отмена'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text('Да'),
          onPressed: () async {
            await DBProvider.db.deleteSerial(_serial);
            _listStateUpdate();
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

class ValuesPopup extends StatelessWidget {
  final Serial _serial;
  final Function _listStateUpdate;
  int _se;
  int _ep;

  ValuesPopup({Serial serial, Function listStateUpdate})
      : _serial = serial,
        _listStateUpdate = listStateUpdate,
        _se = serial.season,
        _ep = serial.episode;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Ввести значения'),
      content: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Flexible(
              child: TextField(
            decoration: InputDecoration(labelText: 'Сезон'),
            keyboardType: TextInputType.number,
            onChanged: (str) {
              _se = int.parse(str);
              print('onChanged - ' + _se.toString());
            },
          )),
          Flexible(
            child: Text('      '),
          ),
          Flexible(
              child: TextField(
            decoration: InputDecoration(labelText: 'Серия'),
            keyboardType: TextInputType.number,
            onChanged: (str) {
              _ep = int.parse(str);
              print('onChanged - ' + _ep.toString());
            },
          )),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Отмена'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        RaisedButton(
          child: Text(
            'Готово',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () async {
            await DBProvider.db.changeSerialSe(_serial.id, _se);
            await DBProvider.db.changeSerialEp(_serial.id, _ep);
            _listStateUpdate();
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
