import 'dart:html';

import 'package:flutter/material.dart';

class my_cup_list extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('SMART\n CUPBOARDS',
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: "Rationale")),
            centerTitle: true,
            backgroundColor: AppColors.BLUE),
        body: Center(child: Text('hello')));
  }
}
