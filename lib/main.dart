import 'dart:convert';

import 'package:application/network/network_call.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';

void main() {
  // IMPORTANT: Uncomment the line `enableFlutterDriverExtension();` before making a submission. Failure in doing so will not execute the automated testcases.

  enableFlutterDriverExtension();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  NetworkCall nc = new NetworkCall();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: FutureBuilder<dynamic>(
          future: nc.getAllResturants(), // async work
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data['results'].length,
                  itemBuilder: (context, i) {
                    return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: _listView(snapshot, i));
                  });
            }
            return Center(child: CircularProgressIndicator());
          },
        )),
      ),
    );
  }

  _listView(snapshot, i) {
    return ListTile(
      trailing: Container(
        width: 22,
        height: 22,
        color: Colors.green,
        child: Center(
          child: Text(
            snapshot.data['results'][i]['rating'] != null
                ? '${snapshot.data['results'][i]['rating']}'
                : "NA",
            style: TextStyle(fontSize: 17, color: Colors.white),
          ),
        ),
      ),
      subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //user_ratings_total
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              snapshot.data['results'][i]['name'] != null
                  ? '${snapshot.data['results'][i]['name']}'
                  : "NA",
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  "Total Rating: ",
                  style: TextStyle(fontSize: 9),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  snapshot.data['results'][i]['user_ratings_total'] != null
                      ? '${snapshot.data['results'][i]['user_ratings_total']}'
                      : "NA",
                  softWrap: false,
                  overflow: TextOverflow.fade,
                  style: TextStyle(fontSize: 9),
                ),
              ),
            ],
          ),
        ],
      ),
      leading: snapshot.data['results'][i]['icon'] != null
          ? Image.network(snapshot.data['results'][i]['icon'])
          : Icon(Icons.flag),
    );
  }
}
