import 'dart:math';

import 'package:flutter/material.dart';
import 'RandomNumberObject.dart';

import 'firestore_api.dart';


class History extends StatelessWidget {
  History({@required this.randomNumber});

  final int randomNumber;
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];


  @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('History'),
  //       centerTitle: false,
  //     ),
  //     body: Center(
  //       child:ListView.builder(
  //           padding: const EdgeInsets.all(8),
  //           itemCount: entries.length,
  //           itemBuilder: (BuildContext context, int index) {
  //             return Container(
  //               height: 50,
  //               child: Center(child: Text('Random number:  ${randomNumber}')),
  //             );
  //           }
  //       ),
  //     ),
  //   );
  // }
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        centerTitle: false,
      ),
      body: Center(
        child: deserialize(context),
      ),
    );
  }

  Widget _operationsList() {
    final List<String> entries = <String>['A', 'B', 'C'];
    final List<int> colorCodes = <int>[600, 500, 100];

    ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 50,
            color: Colors.amber[colorCodes[index]],
            child: Center(child: Text('Entry ${entries[index]}')),
          );
        }
    );
  }

  // uses firestore
  Widget deserialize(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Previous RandomNumbers',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            FutureBuilder<List<Object>>(
              future: FirestoreApi().readAllData(),
              builder: (context, snapshot) {

                if(snapshot.hasError){
                  print('deserialize-err');
                }
                if(snapshot.connectionState == ConnectionState.waiting) {
                  print('deserialize-waiting');
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if(snapshot.hasData) {
                  print('deserialize-hasData');
                  return SingleChildScrollView(
                    child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: snapshot.data.map((firebaseCalculation) {
                      RandomNumberObject tr = RandomNumberObject.fromJson(firebaseCalculation);
                      return Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('RandomNumber: ' + (tr.randomNumber ?? '')),
                            Text('TimeStamp: ' + (tr.timeStamp ?? ''))
                          ],
                        ),
                      );

                    }).toList(),));
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );

  }


  // @override
  // Widget buildHP(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       backgroundColor: Colors.blue,
  //       title: Text("Previous random numbers"),
  //     ),
  //     body: StreamBuilder(
  //       stream: FirebaseFirestore.instance.collection('numbers').snapshots(),
  //       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
  //         if (!snapshot.hasData) {
  //           return Center(
  //             child: CircularProgressIndicator(),
  //           );
  //         }
  //         return ListView(
  //           children: snapshot.data.docs.map((document) {
  //             return Container(
  //               child:
  //               Center(child: Text(document['randomNumber'])),
  //             );
  //           }).toList(),
  //         );
  //       },
  //     ),
  //   );
  // }
 }