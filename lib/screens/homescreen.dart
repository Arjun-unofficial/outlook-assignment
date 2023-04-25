// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:outshade_assignment/widgets/list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Outshade'),
        elevation: 1,
      ),
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return List(
              index: index,
            );
          }),
    );
  }
}
