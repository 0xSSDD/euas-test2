import 'package:flutter/material.dart';
import 'dart:math';
import 'package:firebase_core/firebase_core.dart';
import 'history.dart';
import 'package:intl/intl.dart';
import 'firestore_api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Random number generator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final _random = new Random();
  String _timeString = '';

  void _incrementCounter() {
    _getTime();

    setState(() {
      _counter = _random.nextInt(1000);
    });
    Map<String, dynamic> randomNumberMap = {'randomNumber': _counter.toString(), 'timeStamp': _timeString};
    FirestoreApi().addData(randomNumberMap);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
        centerTitle: false,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.history), onPressed: () {
            _navigateAndDisplayHistory(context);
          })
        ],


      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Your random number and timestamp is:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              '$_timeString',

            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );

    // return FutureBuilder<FirebaseApp>(
    //     future: Firebase.initializeApp(),
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return Center(child: CircularProgressIndicator());
    //       }
    //       return Scaffold(
    //         appBar: AppBar(
    //           title: Text(widget.title),
    //           centerTitle: false,
    //           actions: <Widget>[
    //
    //             IconButton(
    //                 icon: Icon(Icons.history), onPressed: () {
    //               _navigateAndDisplayHistory(context);
    //             })
    //           ],
    //         ),
    //         body: Column(
    //         ),
    //         floatingActionButton: FloatingActionButton(
    //           onPressed: _incrementCounter,
    //           tooltip: 'Increment',
    //           child: Icon(Icons.add),
    //         ),
    //       );
    //     }
    // );
  }

  void _getTime() {
    final String formattedDateTime =
    DateFormat('yyyy-MM-dd kk:mm:ss').format(DateTime.now()).toString();
    setState(() {
      _timeString = formattedDateTime;
      print(_timeString);
    });
  }

  _navigateAndDisplayHistory(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => History(randomNumber: _counter))
    );
    print(_counter);
  }
}