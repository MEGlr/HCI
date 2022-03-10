import 'dart:html';
import 'package:first_app/Screens/add_product.dart';
import 'package:flutter/material.dart';
//import 'package:first_app';
import 'package:first_app/constants/appcolors.dart';
import 'package:first_app/buttons/general_button.dart';

class GenDisplay extends StatefulWidget {
  final String maintitle;
  final String left;
  final String right;
  final double edges;
  final Color color;
  Widget Function() createPageR;
  Widget Function() createPageL;
  GenDisplay({
    Key? key,
    required this.maintitle,
    required this.left,
    required this.right,
    required this.color,
    //this.image = '',
    required this.edges,
    required this.createPageR,
    required this.createPageL,
  }) : super(key: key); //Ti einai to key

  @override
  _GenDisplayState createState() => _GenDisplayState();
}

class _GenDisplayState extends State<GenDisplay> {
  String maintitle = '';
  String left = '';
  String right = '';
  double edges = 0;
  Color color = AppColors.PURPLE;
  //String image = '';
  Widget Function() createPageR = () => add_product();
  Widget Function() createPageL = () => add_product();
  bool isVisible = true;
  double edge = 0;

  @override
  void initState() {
    maintitle = widget.maintitle;
    color = widget.color;
    right = widget.right;
    left = widget.left;
    //image = widget.image;
    createPageR = widget.createPageR;
    createPageL = widget.createPageL;
    edge = widget.edges;
    //if (image == '') isVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    // bool newSelected = isSelected; //dk why needed
    return AlertDialog(
      backgroundColor: AppColors.MOODY_PINK,
      //insetPadding: EdgeInsets.all(10),
      alignment: Alignment.center,
      content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ListBody(
              children: <Widget>[
                Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset("images/Exclamation.png"),
                      //const Flexible(fit: FlexFit.tight, child: SizedBox(width: 1)),
                      //,
                      Text(
                        maintitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontFamily: "PublicSans"),
                      ),
                      //const Flexible(fit: FlexFit.tight, child: SizedBox(width: 2))
                    ]),
                const Flexible(fit: FlexFit.tight, child: SizedBox(height: 12)),
                Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GenButton(
                          maintitle: left,
                          color: color,
                          font: "PublicSans",
                          edges: 20,
                          createPage: createPageL),
                      const Flexible(fit: FlexFit.tight, child: SizedBox()),
                      GenButton(
                          maintitle: right,
                          color: color,
                          edges: 20,
                          font: "PublicSans",
                          createPage: createPageR),
                    ])
              ],
            )
          ]),
      // actions: <Widget>[
      //   FlatButton(child: Text('hello'), onPressed: () {})
      // ]
    );
  }
}