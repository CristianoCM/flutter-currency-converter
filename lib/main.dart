import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const api = "https://api.hgbrasil.com/finance?format=json&key=dae82fc2";

void main() async {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(
      hintColor: Colors.amber,
      primaryColor: Colors.white,
    )
  ));
}

Future<Map> getData() async {
  http.Response res = await http.get(api);
  return json.decode(res.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  double dollar;
  double euro;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Currency Converter"),
        centerTitle: true,
        backgroundColor: Colors.amber
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text(
                  "Loading data...", 
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Error while fetching data...", 
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                dollar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];

                return SingleChildScrollView(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(
                        Icons.monetization_on,
                        size: 150.0,
                        color: Colors.amber,
                      ),
                      Divider(),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Real",
                          labelStyle: TextStyle(
                            color: Colors.amber,
                          ),
                          border: OutlineInputBorder(),
                          prefixText: "R\$ ",
                        ),
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 25.0,
                        ),
                      ),
                      Divider(),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Dollar",
                          labelStyle: TextStyle(
                            color: Colors.amber,
                          ),
                          border: OutlineInputBorder(),
                          prefixText: "\$ ",
                        ),
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 25.0,
                        ),
                      ),
                      Divider(),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Euro",
                          labelStyle: TextStyle(
                            color: Colors.amber,
                          ),
                          border: OutlineInputBorder(),
                          prefixText: "€ ",
                        ),
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 25.0,
                        ),
                      )
                    ],
                  )
                );
              }
          }
        },
      )
    );
  }
}