import 'dart:developer';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// 一个无状态部件 相当于管理整个app
// 无 状态的 widgets 是不可变的，这意味着它们的属性不能改变 —— 所有的值都是 final。

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

// 首页有状态部件
// 有 状态的 widgets 也是不可变的，但其持有的状态可能在 widget 生命周期中发生变化，
// 实现一个有状态的 widget 至少需要两个类：
//  1）一个 StatefulWidget 类；
//  2）一个 State 类，StatefulWidget 类本身是不变的，但是 State 类在 widget 生命周期中始终存在。

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// state类，属性只能在这里面定义，State 类在 widget 生命周期中始终存在
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: const Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: RandomWords(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// 自己也定义一个有状态部件
// 写法
// 至少有两个类，一个有状态部件类 一个状态类
//  1.定义一个有状态部件 继承有状态部件类 StatefulWiget
//  2.定义一个状态类，保存属性

// statefulwiget是一个抽象类
// abstract 类，定义方法，不能实例化

class PersonalCenter extends StatefulWidget {
  const PersonalCenter({Key? key, required this.title}) : super(key: key);

  final String title;

  //需要重写createState方法，写法如下：
  @override
  State<PersonalCenter> createState() => _PersonalCenterState();
}

class _PersonalCenterState extends State<PersonalCenter> {
  String a = "";
  String b = "";
  String c = "";
  String d = "";

  void onPressed() {
    log("Hello!! I am the iron man.");

    // 应该是传入了一个匿名方法
    setState(() {
      a = WordPair.random().asPascalCase;
      b = WordPair.random().asPascalCase;
      c = WordPair.random().asPascalCase;
      d = WordPair.random().asPascalCase;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Center(
            child: Column(
          children: <Widget>[
            // 模版写法
            Text("${a}is comming"),
            Text(b),
            Text(c),
            Text(d),
            FloatingActionButton(onPressed: onPressed, tooltip: 'random')
          ],
        )));
  }
}

// class MyWidget extends StatefulWidget {
//   const MyWidget({Key? key}) : super(key: key);

//   @override
//   State<MyWidget> createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<MyWidget> {
//   @override
//   Widget build(BuildContext context) {

//   }
// }

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return _buildSuggestions();
  }

  ListView _buildSuggestions() {
    // 等于说，每次一滑到底都会触发一次itemBuilder匿名函数
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return const Divider(); /*2*/
          log(i.toString());
          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return ListTile(
            title: Text(
              _suggestions[index].asPascalCase,
              style: _biggerFont,
            ),
          );
        });
  }
}
