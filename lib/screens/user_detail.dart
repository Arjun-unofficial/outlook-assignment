// ignore_for_file: annotate_overrides, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  late String name;
  String age = '';
  String gender = '';

  void _setinfohandler(name) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? jsonString = prefs.getString(name);

    Map<String, dynamic> myMap = json.decode(jsonString!);

    setState(() {
      name = name;
      age = myMap['age'] ?? '';
      gender = myMap['gender'] ?? '';
    });
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final arguments = (ModalRoute.of(context)?.settings.arguments ??
          <String, String>{}) as Map;
      name = arguments['name'] ?? '';
      print('name is::: $name');
      _setinfohandler(name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Info'),
        elevation: 3,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Name: $name',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Age: $age',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Gender: $gender',
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
