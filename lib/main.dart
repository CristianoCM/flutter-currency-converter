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
      )));
}

Future<Map> getData() async {
  http.Response res = await http.get(api);
  return json.decode(res.body);
}

Widget buildTextField(String label, String prefix, TextEditingController con, Function f) {
  return TextField(
    controller: con,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.amber,
        ),
        border: OutlineInputBorder(),
        prefixText: prefix,
        prefixStyle: 
          TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.amber))
    ),
    style: TextStyle(
      color: Colors.amber,
      fontSize: 25.0,
    ),
    onChanged: f,
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final realController = TextEditingController();
  final dollarController = TextEditingController();
  final euroController = TextEditingController();

  double dollar;
  double euro;

  void _realChanged(String text) {
    
  }

  void _dollarChanged(String text) {
    
  }

  void _euroChanged(String text) {
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Currency Converter"),
            centerTitle: true,
            backgroundColor: Colors.amber),
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
                          buildTextField("Real", "R\$ ", realController, _realChanged),
                          Divider(),
                          buildTextField("Dollar", "US\$ ", dollarController, _dollarChanged),
                          Divider(),
                          buildTextField("Dollar", "€ ", euroController, _euroChanged),
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
