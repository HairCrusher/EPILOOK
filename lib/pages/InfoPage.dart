import 'package:flutter/material.dart';
import 'package:flutter_app/AppbarMenuItems.dart';

class InfoPage extends StatelessWidget {

  final String str0 = "v.1.0";
  final String str1 =
  "Приложение Epilook создано небольшой группой разработчиков, задумавшихся о том, почему нет быстрого и предельно простого способа запомнить серию любимого сериала на которой остановился.";
  final String str2 = "Сезоны прерываются, выходят новые и уже сложно вспомнить, так сложно, что проще начать смотреть новый сериал. "
  "Что уже говорить о длинных аниме-сериалах из нескольких сотен эпизодов!";
  final String str3 = "Приложение имеет встроенный поиск сериала, а если Вы не нашли там то, что смотрите сейчас, можете добавить самостоятельно всё, что пожелаете!";

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
              child: Text(str1, style: TextStyle(color: Colors.white)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(str2, style: TextStyle(color: Colors.white),),
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

