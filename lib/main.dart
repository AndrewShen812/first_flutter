import 'dart:async';

import 'package:first_flutter/route_test.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

import 'navi_page.dart';

void main() /*=> runApp(new MyApp());*/ {
  runZoned(() => runApp(MyApp()),
      zoneSpecification: new ZoneSpecification(
        handleUncaughtError: (Zone self,
          ZoneDelegate parent, Zone zone, Object error, StackTrace stackTrace) {
            print("Ooooops, get error!");
            print(stackTrace);
          },
        print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
          parent.print(zone, "get log: $line");
      }),
      onError: (Object obj, StackTrace stack) {
        print(obj);
        print(stack);
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
//      theme: new ThemeData(
//        primaryColor: Colors.white,
//      ),
      title: 'Welcome to Flutter',
      initialRoute: "/", // 名为"/"的路由作为应用的home(首页)
//      home: new RandomWords(),
      // 注册页面路由
      routes: {
        //注册首页路由
        "/" : (context) => new RandomWords(),
//        "test_route" : (context) => TestRoute()
        "navi_route" : (context) => NaviPage()
      },
      onGenerateRoute: (settings) {
        /// 页面跳转前判断
        WidgetBuilder builder;
        if (settings.name == "test_route") {
          print("gen test page");
          builder = (context) => new TestRoute();
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = new Set<WordPair>();

  final _biggerFont = const TextStyle(fontSize: 18.0);

  // 对于每个建议的单词对都会调用一次itemBuilder，然后将单词对添加到ListTile行中
  // 在偶数行，该函数会为单词对添加一个ListTile row.
  // 在奇数行，该函数会添加一个分割线widget，来分隔相邻的词对。
  // 注意，在小屏幕上，分割线看起来可能比较吃力。
  Widget _buildSuggestions() {
    return new ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return new Divider();
        // 语法 "i ~/ 2" 表示i除以2，但返回值是整形（向下取整），比如i为：1, 2, 3, 4, 5
        // 时，结果为0, 1, 1, 2, 2， 这可以计算出ListView中减去分隔线后的实际单词对数量
        final index = i ~/ 2;
        // last item in list
        if (index >= _suggestions.length) {
          // ...接着再生成10个单词对，然后添加到建议列表
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    final saved = _saved.contains(pair);
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        saved ? Icons.favorite : Icons.favorite_border,
        color: saved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (saved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  ScrollController _scrollController = new ScrollController();
  bool showBackTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      double offset = _scrollController.offset;
      print(offset);
      if (offset < 1000.0 && showBackTop) {
        setState(() {
          showBackTop = false;
        });
      }
      if (offset > 1000.0 && !showBackTop) {
        setState(() {
          showBackTop = true;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    final wordPair = new WordPair.random();
//    return new Text(wordPair.asPascalCase);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Flutter Name Generator Demo'),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pressSaved)
        ],
      ),
      body: _buildSuggestions(),
      floatingActionButton: !showBackTop? null : FloatingActionButton(
        child: Icon(Icons.arrow_upward),
        onPressed: () {
          _scrollController.animateTo(
              0.0,
              duration: Duration(milliseconds: 200),
              curve: Curves.ease);
        }
      ),
    );
  }

  void _pressSaved() {
//    Navigator.pushNamed(context, "test_route", arguments: DateTime.now().millisecondsSinceEpoch);
    Navigator.pushNamed(context, "navi_route");
/*    Navigator.of(context).push(new MaterialPageRoute(
      builder: (context) {
        final tiles = _saved.map(
          (WordPair pair) {
            return new ListTile(
              title: new Text(
                pair.asPascalCase,
                style: _biggerFont,
              ),
            );
          },
        );

        final divided = ListTile.divideTiles(
          context: context,
          tiles: tiles,
        ).toList();

        return new Scaffold(
          appBar: new AppBar(
            title: new Text('Saved WordPairs'),
          ),
          body: new ListView(
            children: divided,
          ),
        );
      }
    )).whenComplete(() {
      print("navi back");
    });*/
  }
}
