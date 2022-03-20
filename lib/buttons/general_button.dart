//import 'dart:html';
import 'package:first_app/Screens/add_product.dart';
import 'package:flutter/material.dart';
//import 'package:first_app';
import 'package:first_app/constants/appcolors.dart';

class GenButton extends StatefulWidget {
  final String maintitle;
  final Color color;
  final String image;
  final double edges;
  final String font;
  Widget Function() createPage;
  GenButton(
      {Key? key,
      required this.maintitle,
      required this.color,
      this.image = '',
      required this.edges,
      required this.font,
      required this.createPage})
      : super(key: key); //Ti einai to key

  @override
  _GenButtonState createState() => _GenButtonState();
}

class _GenButtonState extends State<GenButton> {
  String data = "hello";
  Color color = AppColors.PURPLE;
  bool isSelected = false;
  String font = "PublicSans";
  String image = '';
  Widget Function() createPage = () => add_product();
  bool isVisible = true;
  double edge = 0;

  @override
  void initState() {
    data = widget.maintitle;
    color = widget.color;
    image = widget.image;
    createPage = widget.createPage;
    edge = widget.edges;
    font = widget.font;
    if (image == '') isVisible = false;
  }

// "Rationale"
// "PublicSans"
  @override
  Widget build(BuildContext context) {
    // bool newSelected = isSelected; //dk why needed
    return RaisedButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return createPage();
          }));
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(edge)),
        color: color,
        elevation: 20.0,
        padding: EdgeInsets.all(25),
        child: Row(children: [
          Text(data,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontFamily: font)),
          Visibility(
            child: Image.asset(image),
            visible: isVisible,
          )
        ]));
  }
}

//   Widget _buildSelectIcon(bool isSelected, data) {
//     if (isSelectionMode) {
//       return Icon(
//         isSelected ?  : Icons.check_box_outline_blank,
//         color: Colors.white,
//       );
//     } else {
//       return const Icon(null);
//     }
//   }

//   void onTap(bool giveSelected) {

//       setState(() {
//         isSelected = !giveSelected;
//       });
//     } else {
//       print("Hehe");
//     }
//   }
// }
