import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/pages/FavList.dart';
import 'package:flutter_app/pages/SerialsList.dart';
import 'package:flutter_app/pages/SearchPage.dart';
import 'package:flutter_app/AppbarMenuItems.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.black).then((__){
      FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
      runApp(MyApp());
    });
  });
}

GlobalKey<MainPageState> globalMainPage = GlobalKey();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EpiLook',
      theme: ThemeData(
          primaryColor: Colors.black,
          cardColor: Colors.black,
          scaffoldBackgroundColor: Color(0xFF191919),
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.white,
          ),
          dialogTheme: DialogTheme(
              titleTextStyle: TextStyle(color: Colors.white),
              backgroundColor: Color(0xFF191919),
              contentTextStyle: TextStyle(color: Colors.white)),
          inputDecorationTheme: InputDecorationTheme(
              labelStyle: TextStyle(
            color: Colors.blueAccent,
          )),
          tabBarTheme: TabBarTheme(
              unselectedLabelColor: Colors.white,
              labelColor: Colors.blueAccent,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(color: Colors.blueAccent, width: 2),
              ))),
      home: MainPage(
        key: globalMainPage,
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  State createState() => new MainPageState();
}

class MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  double listViewOffset = 0.0;

  TabController _tabController;

  final List<Tab> myTabs = <Tab>[
    new Tab(icon: Icon(Icons.search)),
    new Tab(icon: Icon(Icons.list)),
    new Tab(icon: Icon(Icons.favorite)),
  ];

  int _index = 1;

  void switchPageTo(int index) {
    this._tabController.index = index;
  }

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(
        vsync: this, length: myTabs.length, initialIndex: _index);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            'assets/logoText.png',
            height: 30,
          ),
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
        body: TabBarView(
          children: <Widget>[
            SearchPage(key: PageStorageKey<String>('SearchPage')),
            SerialsListPage(key: PageStorageKey<String>('SerialsList')),
            FavListPage(key: PageStorageKey<String>('FavList'))
          ],
          controller: _tabController,
        ),
        bottomNavigationBar: Material(
          color: Colors.black,
          child: TabBar(
            tabs: myTabs,
            controller: _tabController,
//        labelColor: Colors.blue,
          ),
        ),
      ),
    );
  }
}
