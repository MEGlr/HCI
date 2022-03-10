// import 'dart:html';
// import 'package:first_app/Screens/add_product.dart';
// import 'package:flutter/material.dart';
// //import 'package:first_app';
// import 'package:first_app/constants/appcolors.dart';

// class GenButton extends StatefulWidget {
//   final String maintitle;
//   final Color color;
//   final String image;
//   final double edges;
//   Widget Function() createPage;
//   GenButton(
//       {Key? key,
//       required this.maintitle,
//       required this.color,
//       this.image = '',
//       required this.edges,
//       required this.createPage})
//       : super(key: key); //Ti einai to key

//   @override
//   _GenButtonState createState() => _GenButtonState();
// }

// class _GenButtonState extends State<GenButton> {
//   String data = "hello";
//   Color color = AppColors.PURPLE;
//   bool isSelected = false;
//   String image = '';
//   Widget Function() createPage = () => add_product();
//   bool isVisible = true;
//   double edge = 0;

//   @override
//   void initState() {
//     data = widget.maintitle;
//     color = widget.color;
//     image = widget.image;
//     createPage = widget.createPage;
//     edge = widget.edges;
//     if (image == '') isVisible = false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     // bool newSelected = isSelected; //dk why needed
//     return RaisedButton(
//       onPressed: () {
//         Navigator.of(context)
//             .push(MaterialPageRoute(builder: (BuildContext context) {
//           return createPage();
//         }));
//       },
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(edge)),
//       color: color,
//       elevation: 20.0,
//       padding: EdgeInsets.all(25),
//       icon: Ic
//       : Text(data,
//           textAlign: TextAlign.center,
//           style: TextStyle(color: Colors.white, fontFamily: "Rationale")),
//     );
//   }
// }

// Form(
                  //     child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: <Widget>[
                  //       Container(
                  //           color: AppColors.BLUE,
                  //           child: Padding(
                  //               padding: const EdgeInsets.all(10.0),
                  //               child: TextFormField(
                  //                 validator: (value) {
                  //                   if (value == null || value.isEmpty) {
                  //                     return 'fill name';
                  //                   }
                  //                   return null;
                  //                 },
                  //                 decoration:
                  //                     const InputDecoration(hintText: 'Title'),
                  //               ))),
                  //     ])),
                  // SizedBox(height: 20),
                  // Form(
                  //     child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: <Widget>[
                  //       Container(
                  //           color: AppColors.BLUE,
                  //           child: Padding(
                  //               padding: const EdgeInsets.all(10.0),
                  //               child: TextFormField(
                  //                 validator: (value) {
                  //                   if (value == null || value.isEmpty) {
                  //                     return 'fill name';
                  //                   }
                  //                   return null;
                  //                 },
                  //                 decoration:
                  //                     const InputDecoration(hintText: 'Title'),
                  //               )))
                  //     ]))