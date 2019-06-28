import 'package:flutter/material.dart';
import 'package:flutter_app/AppbarMenuItems.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {

  final String str0 = "Связаться с нами";
  final String str1 = "agoos@yandex.ru";

  final String str2 = "gysanton@gmail.com";
  final String str3 = "Будем признательны за обратную связь и дельные советы!";

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
                    context,
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
//        mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(str0, style: TextStyle(color: Colors.white),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  child: Text(str1, style: TextStyle(color: Colors.blue)),
                  onTap: () async {
                    const url = 'mailto:agoos@yandex.ru?subject=EpiLook';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  }
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  child: Text(str2, style: TextStyle(color: Colors.blue)),
                  onTap: () async {
                    const url = 'mailto:gysanton@gmail.com?subject=EpiLook';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  }
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(str3, style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}

