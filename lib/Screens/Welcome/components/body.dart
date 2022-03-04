// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:first_app/constants/appcolors.dart';
import 'package:first_app/Screens/my_cup_list.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('SMART\n CUPBOARDS',
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: "Rationale")),
            centerTitle: true,
            backgroundColor: AppColors.BLUE),
        body: Container(
            alignment: Alignment.center,
            color: AppColors.VERY_LIGHT_BLUE,
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RaisedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => my_cup_list()));
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0)),
                          color: AppColors.PINK,
                          elevation: 20.0,
                          padding: EdgeInsets.all(25),
                          child: Text(
                            'My Cupboards',
                            style: TextStyle(
                                color: Colors.white, fontFamily: "Rationale"),
                          )
                          //,
                          //
                          ),
                      SizedBox(height: 20),
                      RaisedButton(
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0)),
                          color: AppColors.BLUE,
                          elevation: 20.0,
                          padding: EdgeInsets.all(25),
                          child: Text(
                            'My Favourite\n Products',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white, fontFamily: "Rationale"),
                          )
                          //,
                          //
                          ),
                      SizedBox(height: 20),
                      RaisedButton(
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0)),
                          color: AppColors.LIGHT_BLUE,
                          elevation: 20.0,
                          padding: EdgeInsets.all(25),
                          child: Text(
                            'My Grocery Lists',
                            style: TextStyle(
                                color: Colors.white, fontFamily: "Rationale"),
                          )
                          //,
                          //
                          ),
                      IconButton(
                        icon: Image.asset('assets/icons/Button.svg'),
                        iconSize: 50,
                        onPressed: () {},
                      )
                    ],
                  ),
                )
              ],
            )));
  }
}
