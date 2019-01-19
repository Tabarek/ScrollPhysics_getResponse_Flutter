import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {

  final FixedExtentScrollController fixedExtentScrollController =
  new FixedExtentScrollController();


  final String url = "https://jsonplaceholder.typicode.com/todos";
  List data;

  Future<String> getTitle() async {
    var res = await http.get(Uri.encodeFull(url));


    setState(() {
      var resBody = json.decode(res.body);

      data = resBody;



    });

    return "Success!";
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const Text('List'),
        ),
        body: data == null ? Center(
          child: CircularProgressIndicator(),
        )
            : ListWheelScrollView(
            itemExtent: 60.0,
            controller: fixedExtentScrollController,
            children: data
                .map((val) =>
                Container(
//                  color: Colors.amberAccent,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Card(

                          color: Colors.tealAccent,
                          child: Container(

                              padding: EdgeInsets.all(15.0),
                              child: Row(

                                children: <Widget>[

                                Text("Title: "),
                                  Expanded(
                                    child: Text(val["title"],
                                        style: TextStyle(
                                            fontSize: 10.0,
                                            color: Colors.black87),),

                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                ))
                .toList()),
      ),
    );
  }
  @override
  void initState() {
    super.initState();
    this.getTitle();
  }
}