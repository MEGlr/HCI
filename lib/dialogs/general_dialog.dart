//import 'dart:html';
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
  void Function() createPageR;
  void Function() createPageL;
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
  void Function() createPageR = () => add_product();
  void Function() createPageL = () => add_product();
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
    return Flexible(
        child: AlertDialog(
      backgroundColor: AppColors.MOODY_PINK,
      //insetPadding: EdgeInsets.all(10),
      //alignment: Alignment.center,
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
                      Image.asset("assets/images/Exclamation.png"),
                      //const Flexible(fit: FlexFit.tight, child: SizedBox(width: 1)),
                      //,
                      Expanded(
                          child: Text(
                        maintitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "PublicSans", color: Colors.black),
                      )),
                      //const Flexible(fit: FlexFit.tight, child: SizedBox(width: 2))
                    ]),
                const Flexible(fit: FlexFit.tight, child: SizedBox(height: 12)),
                Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        child: Text(left,
                            style: TextStyle(
                                fontFamily: "PublicSans", color: Colors.white)),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(color),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(20.0)))),
                        onPressed: createPageL,
                      ),
                      const Flexible(fit: FlexFit.tight, child: SizedBox()),
                      TextButton(
                        child: Text(right,
                            style: TextStyle(
                                fontFamily: "PublicSans", color: Colors.white)),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(color),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(20.0)))),
                        onPressed: createPageR,
                      ),
                      // GenButton(
                      //     maintitle: right,
                      //     color: color,
                      //     edges: 20,
                      //     font: "PublicSans",
                      //     createPage: createPageR),
                    ])
              ],
            )
          ]),
      // actions: <Widget>[
      //   FlatButton(child: Text('hello'), onPressed: () {})
      // ]
    ));
  }
}
