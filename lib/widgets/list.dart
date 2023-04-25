// ignore_for_file: must_be_immutable, no_logic_in_create_state, annotate_overrides, unnecessary_string_interpolations, prefer_const_constructors, dead_code

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/data.dart';

class List extends StatefulWidget {
  int index;

  List({super.key, required this.index});

  @override
  State<List> createState() => _ListState(index: index);
}

class _ListState extends State<List> {
  int index;
  bool login = false;

  _ListState({required this.index});

  late String name;

  void initState() {
    super.initState();
    name = data[index]["name"] ?? "";
    checkloginstatus();
  }

  void checkloginstatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final value = prefs.getString('$name');

    if (value == null) {
      setState(() {
        login = false;
      });
    } else {
      setState(() {
        login = true;
      });
    }
  }

  String age = '';
  String gender = '';

  // Function to show the age and gender prompt
  Future<void> _showPrompt() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Age and Gender'),
          content: Column(
            children: [
              TextField(
                onChanged: (value) {
                  setState(() {
                    age = value;
                  });
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Age'),
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    gender = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Gender'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Use the age and gender values where needed
                Navigator.of(context).pop();
                loginhandler();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void loginhandler() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> myMap = {
      'age': age,
      'gender': gender,
    };

    String jsonString = json.encode(myMap);
    await prefs.setString(name, jsonString);

    setState(() {
      login = true;
    });
  }

  void logouthandler() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(name);

    setState(() {
      login = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (login) {
          Navigator.pushNamed(context, '/userinfoScreen',
              arguments: {'name': name});
        }
      },
      child: ListTile(
          leading: Text(
            "${data[index]["id"]}",
            style: TextStyle(fontSize: 15),
          ),
          trailing: login
              ? GestureDetector(
                  onTap: () => logouthandler(),
                  child: Text(
                    "Log out",
                    style: TextStyle(fontSize: 15),
                  ),
                )
              : GestureDetector(
                  onTap: () => _showPrompt(),
                  child: Text(
                    "Log in",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
          title: Text(
            "${data[index]["name"]}",
            style: TextStyle(
                color: login ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold),
          )),
    );
  }
}
