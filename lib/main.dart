import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/pages/FavList.dart';
import 'package:flutter_app/pages/SerialsList.dart';
import 'package:flutter_app/pages/SearchPage.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_){
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startap Name Generator',
      theme: ThemeData(
        primaryColor: Colors.black,
        cardColor: Colors.black,
        scaffoldBackgroundColor: Color(0xFF191919),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.white,
        ),
        dialogTheme: DialogTheme(
          titleTextStyle: TextStyle(
            color: Colors.white
          ),
          backgroundColor: Color(0xFF191919),
          contentTextStyle: TextStyle(
            color: Colors.white
          )
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(
            color: Colors.blueAccent,
          )
        ),
        tabBarTheme: TabBarTheme(
          unselectedLabelColor: Colors.white,
          labelColor: Colors.blueAccent,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(
              color: Colors.blueAccent,
              width: 2
            ),
          )
        )
      ),
      home: MainPage(),
//      routes: {
//        '/':(BuildContext context) => MainPage(page_id: 1),
//        '/search':(BuildContext context) => MainPage(page_id: 0,),
//      },
//      onGenerateRoute: (routeSettings) {
//        var path = routeSettings.name.split('/');
//
//        if(path[1] == 'single')
//          return new MaterialPageRoute(builder: (context) => new SinglePage(serial: int.parse(path[2])));
//      },
    );
  }
}



class MainPage extends StatefulWidget {

  @override
  State createState() => new MainPageState();
}

class MainPageState extends State<MainPage> with SingleTickerProviderStateMixin{
  double listViewOffset=0.0;

  TabController _tabController;

  final List<Tab> myTabs = <Tab>[
    new Tab(icon: Icon(Icons.search)),
    new Tab(icon: Icon(Icons.list)),
    new Tab(icon: Icon(Icons.favorite)),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: myTabs.length, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EPILOOK'),
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
    );
  }

}

















//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


class RandomWordState extends State<RandomWords> {
  final List<WordPair> _suggestions = <WordPair>[];
  final Set<WordPair> _saved = new Set<WordPair>();
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startap Name Generator'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: _pushSaved,
          ),
        ],
      ),
      body: _buildSuggestions(),
//      drawer: Drawer(
//        child: ListView(
//          padding: EdgeInsets.zero,
//          children: <Widget>[
//            DrawerHeader(
////              child: Text('Drawer Header'),
//              decoration: BoxDecoration(
//                  color: Colors.blue,
//                  shape: BoxShape.circle
//              ),
//            ),
//            ListTile(
//              title: Text('Item 1'),
//              onTap: () {
//                Navigator.pop(context);
//              },
//            ),
//            ListTile(
//              title: Text('Item 2'),
//              onTap: () {
//                Navigator.pop(context);
//              },
//            ),
//          ],
//        ),
//      ),
      bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              title: Text('first'),
              icon: Icon(Icons.ac_unit),
            ),
            BottomNavigationBarItem(
              title: Text('second'),
              icon: Icon(Icons.map),
            ),
            BottomNavigationBarItem(
              title: Text('thrid'),
              icon: Icon(Icons.account_balance_wallet),
            )
          ],
        currentIndex: 1,
      ),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();

          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      final Iterable<ListTile> tiles = _saved.map((WordPair pair) {
        return ListTile(
          title: Text(
            pair.asPascalCase,
            style: _biggerFont,
          ),
        );
      });
      final List<Widget> divided =
          ListTile.divideTiles(context: context, tiles: tiles).toList();

      return Scaffold(
        appBar: AppBar(
          title: Text('Saved Suggestions'),
        ),
        body: ListView(
          children: divided,
        ),
      );
    }));
  }
}

class RandomWords extends StatefulWidget {
  @override
  State createState() => new RandomWordState();
}
