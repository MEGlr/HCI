import 'dart:html';
import 'package:first_app/Screens/add_product.dart';
import 'package:flutter/material.dart';
//import 'package:first_app';
import 'package:first_app/constants/appcolors.dart';

class Form_Field extends StatefulWidget {
  final String maintitle;
  final Color color;
  final String image;
  final double edges;
  Widget Function() createPage;
  final String? Function(String?)? validator;
  TextEditingController? controller;
  Form_Field({
    Key? key,
    required this.maintitle,
    required this.color,
    this.image = 'images/cam_mic.png',
    required this.edges,
    required this.createPage,
    this.validator,
    this.controller,
  }) : super(key: key); //Ti einai to key

  @override
  _Form_FieldState createState() => _Form_FieldState();
}

class _Form_FieldState extends State<Form_Field> {
  String data = "";
  Color color = AppColors.PURPLE;
  bool isSelected = false;
  String image = 'images/cam_mic.png';
  Widget Function() createPage = () => add_product();
  bool isVisible = true;
  double edge = 0;
  TextEditingController? controller;
  String? Function(String?)? validator;
  //  = (value) {
  //   if (value == null || value.isEmpty) {
  //     return 'fill name';
  //   }
  //   return null;
  // };

  @override
  void initState() {
    data = widget.maintitle;
    color = widget.color;
    image = widget.image;
    createPage = widget.createPage;
    edge = widget.edges;
    validator = widget.validator;
    controller = widget.controller;
    if (image == '') isVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    // bool newSelected = isSelected; //dk why needed
    return Container(
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextFormField(
            controller: controller,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white),
            validator: validator,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(edge),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: color,
              labelText: data,
              labelStyle: TextStyle(color: Colors.brown),
              hintText: data,
              hintStyle: TextStyle(color: Colors.brown),
              suffixIcon: IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return createPage();
                  }));
                },
                icon: Image.asset(image, color: Colors.white),
              ),
            ),
          )),
    );
  }
}
