import 'dart:html';

import 'package:first_app/Screens/add_product.dart';
import 'package:flutter/material.dart';
//import 'package:first_app';
import 'package:first_app/constants/appcolors.dart';

class Product extends StatefulWidget {
  final String maintitle;
  final Color color;
  final String image;
  final String edges;
  Widget Function() createPage;
  Product(
      {Key? key,
      required this.maintitle,
      required this.color,
      this.image = '',
      required this.edges,
      required this.createPage})
      : super(key: key); //Ti einai to key

  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  String data = "hello";
  Color color = AppColors.PURPLE;
  bool isSelected = false;
  String image = '';
  Widget Function() createPage = () => add_product();
  bool isVisible = true;

  @override
  void initState() {
    data = widget.maintitle;
    color = widget.color;
    image = widget.image;
    createPage = widget.createPage;
    if (image == '') isVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    // bool newSelected = isSelected; //dk why needed
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(150.0),
        ),
        child: ListTile(
          tileColor: color,
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return createPage();
            }));
          },
          title: Text(data),
          trailing: Visibility(
              child: Container(child: Image.asset(image)),
              visible: isVisible), //_buildSelectIcon(isSelected, data),
        ));
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
