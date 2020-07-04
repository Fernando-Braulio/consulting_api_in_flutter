import 'dart:convert';

import 'package:consulting_api_in_flutter/API.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<API> _api;

  Future<List<API>> _getUser() async {
    try {
      List<API> listUser = List();
      final response =
          await http.get('https://jsonplaceholder.typicode.com/users');

      if (response.statusCode == 200 || response.statusCode == 201) {
        var descodeJson = jsonDecode(response.body);
        descodeJson.forEach((item) => listUser.add(API.fromJson(item)));
        return listUser;
      } else {
        print("Error");
        return null;
      }
    } catch (e) {
      print("Error");
      return null;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUser().then((map) {
      _api = map;
      print(map.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemCount: _api.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 80,
            color: Colors.blue,
            child: Text(
              "Nome: "+_api[index].name
            ),
          ),
        );
      },
    ));
  }
}
