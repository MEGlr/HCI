// import 'package:first_app/Screens/product_add.dart';
// import 'package:first_app/constants/appcolors.dart';
// //import 'package:first_app/Screens/welcome_page.dart';
// import 'package:first_app/Screens/add_product.dart';
// import 'package:flutter/material.dart';
// import 'package:first_app/buttons/form_field.dart';
// import 'package:first_app/buttons/state_icon_button.dart';
// import 'package:first_app/buttons/list_item.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:first_app/dialogs/general_dialog.dart';
// import 'package:intl/intl.dart';

// class MyDialog extends StatefulWidget {
//   @override
//   _MyDialogState createState() => _MyDialogState();
// }

// class _MyDialogState extends State<MyDialog> {
//   final _formKey = GlobalKey<FormState>();
//   DateTime? _dateTime;
//   final _nameController = TextEditingController();
//   final _quantController = TextEditingController();
//   final _brandController = TextEditingController();
//   final _typeController = TextEditingController();

//   Future<void> _show() async {
//     final DateTime? result = await showDatePicker(
//         context: context,
//         initialDate: DateTime.now(),
//         firstDate: DateTime(2021),
//         lastDate: DateTime(2030));
//     if (result != null) {
//       print("jel");
//       _dateTime = result;
//       setState(() {});
//       print(_dateTime);
//     }
//   }

//   Future<void> _showAlertDialog() async {
//     return showDialog<void>(
//         context: context,
//         barrierDismissible: false, // user must tap button!
//         builder: (BuildContext context) => GenDisplay(
//             maintitle:
//                 "Are you sure you want to go back?\nAll changes will be lost. ",
//             color: AppColors.BLUE,
//             left: "Cancel",
//             right: "Yes",
//             edges: 5,
//             createPageL: () => Navigator.pop(context),
//             createPageR: () {
//               Navigator.of(context).pop();
//               //Navigator.of(context).pop();
//             }
//             // context,
//             // (route) =>
//             //     route.settings.name ==
//             //     '/cupList') //Navigator.of(context).push(MaterialPageRoute(builder: (context) => ).then((_){setState(() {

//             ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       backgroundColor: AppColors.LIGHT_PINK,
//       content: SingleChildScrollView(
//           child: ListBody(
//         children: <Widget>[
//           Align(
//               alignment: Alignment.topLeft,
//               child: IconButton(
//                   onPressed: _showAlertDialog,
//                   icon: const Icon(
//                     Icons.arrow_back,
//                     color: AppColors.PURPLE,
//                     size: 20,
//                   ))),
//           Form(
//               key: _formKey,
//               child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Form_Field(
//                       color: AppColors.PURPLE,
//                       maintitle: 'Product Name',
//                       edges: 10,
//                       controller: _nameController,
//                       createPage: () => add_product(),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'field required';
//                         }
//                         return null;
//                       },
//                     ),
//                     Form_Field(
//                       color: AppColors.LIGHT_BLUE,
//                       maintitle: 'Quantity',
//                       image: 'images/up_down_arrow.png',
//                       edges: 10,
//                       controller: _quantController,
//                       createPage: () => add_product(),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'field required';
//                         }
//                         return null;
//                       },
//                     ),
//                     RaisedButton.icon(
//                         onPressed: _show,
//                         //() {
//                         // showDatePicker(
//                         //         context: context,
//                         //         initialDate: DateTime.now(),
//                         //         firstDate: DateTime(2021),
//                         //         lastDate: DateTime(2030))
//                         //     .then((date) {
//                         //   setState(() {
//                         //     _dateTime = date!;
//                         //   });
//                         // });
//                         //},
//                         icon: Image.asset('images/cam_mic.png'),
//                         label: Text(_dateTime != null
//                             ? _dateTime.toString()
//                             : 'Expiration Date')),
//                     Form_Field(
//                       color: AppColors.BLUE,
//                       maintitle: 'Product Type',
//                       edges: 10,
//                       controller: _typeController,
//                       createPage: () => add_product(),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'field required';
//                         }
//                         return null;
//                       },
//                     ),
//                     Form_Field(
//                       color: AppColors.PINK,
//                       maintitle: 'Product Brand',
//                       edges: 10,
//                       createPage: () => add_product(),
//                       controller: _brandController,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'field required';
//                         }
//                         return null;
//                       },
//                     ),
//                   ])),
//           const Flexible(
//               fit: FlexFit.tight,
//               child: SizedBox(
//                 height: 16,
//               )),
//           //Padding(
//           //  padding: const EdgeInsets.only(right: 1.0),
//           //child:
//           Row(
//               //mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 state_icon_button(
//                     data: 'notifications',
//                     color: AppColors.VERY_LIGHT_BLUE,
//                     color_back: AppColors.LIGHT_BLUE,
//                     image_off: 'images/notifications_off.png',
//                     image_on: 'images/notifications_on.png'),
//                 const Flexible(fit: FlexFit.tight, child: SizedBox()),
//                 Align(
//                     alignment: Alignment.bottomRight,
//                     child: MaterialButton(
//                         shape: const CircleBorder(),
//                         padding: const EdgeInsets.all(20),
//                         color: AppColors.BLUE,
//                         onPressed: () {
//                           if (_formKey.currentState!.validate()) {
//                             final entry = ProductItem(
//                               brand: _brandController.text,
//                               name:
//                                   _dateTime.toString(), //_nameController.text,
//                               quantity: _quantController.text,
//                               type: _typeController.text,
//                               expired:
//                                   DateFormat("dd/MM/yyyy").format(_dateTime),
//                             );
//                             Navigator.pop(context, entry);
//                           }
//                           _quantController.text = "";
//                           _typeController.text = "";
//                           _brandController.text = "";
//                           _nameController.text = "";
//                         },
//                         child: const Icon(Icons.check,
//                             color: Colors.white, size: 40))),
//                 //   CircleAvatar(
//                 //       backgroundColor: AppColors.BLUE,
//                 //       child: IconButton(
//                 //           onPressed: _deleteTask,
//                 //           icon: const Icon(
//                 //             Icons.check,
//                 //             color: Colors.white,
//                 //           ))),
//               ])
//         ],
//       )),
//       // actions: <Widget>[
//       //   FlatButton(child: Text('hello'), onPressed: () {})
//       // ]
//     );
//   }
// }
  
// // class MyDialog extends StatefulWidget {
// //   @override
// //   _MyDialogState createState() => _MyDialogState();
// // }

// // class _MyDialogState extends State<MyDialog> {
// //   String name = "";
// //   bool button = false;
// //   DateTime when = DateTime.now();

// //   @override
// //   Widget build(BuildContext context) {
// //     return AlertDialog(
// //       title: Text("Save Event"),
// //       content: Column(
// //         children: <Widget>[
// //           Expanded(
// //             child: TextField(
// //               autofocus: true,
// //               decoration: InputDecoration(labelText: "Event Name"),
// //               onChanged: (value) {
// //                 name = value;
// //               },
// //               onSubmitted: (value) {},
// //             ),
// //           ),
// //           Expanded(
// //               child: Row(
// //             children: <Widget>[
// //               Text("Date of Event "),
// //               RaisedButton(
// //                   child: Text(DateFormat("dd/MM/yyyy").format(when)),
// //                   onPressed: () async {
// //                     DateTime? picked = await showDatePicker(
// //                       context: context,
// //                       initialDate: when,
// //                       firstDate: DateTime(2015, 8),
// //                       lastDate: DateTime(2101),
// //                     );
// //                     setState(() {
// //                       when = picked!;
// //                     });
// //                   }),
// //             ],
// //           ))
// //         ],
// //       ),
// //       actions: <Widget>[
// //         FlatButton(
// //             child: const Text('OK'),
// //             onPressed: () {
// //               Navigator.of(context).pop(true);
// //             }),
// //         FlatButton(
// //             child: const Text("CANCEL"),
// //             onPressed: () {
// //               Navigator.of(context).pop(false);
// //             }),
// //       ],
// //     );
// //   }

// //   Future<bool?> getNameDate(BuildContext context) async {
// //     return showDialog<bool>(
// //       context: context,
// //       barrierDismissible: false,
// //       builder: (BuildContext context) {
// //         return AlertDialog(
// //           title: Text("Save Event"),
// //           content: Column(
// //             children: <Widget>[
// //               Expanded(
// //                 child: TextField(
// //                   autofocus: true,
// //                   decoration: InputDecoration(labelText: "Event Name"),
// //                   onChanged: (value) {
// //                     name = value;
// //                   },
// //                   onSubmitted: (value) {},
// //                 ),
// //               ),
// //               Expanded(
// //                   child: Row(
// //                 children: <Widget>[
// //                   Text("Date of Event "),
// //                   RaisedButton(
// //                       child: Text(DateFormat("dd/MM/yyyy").format(when)),
// //                       onPressed: () async {
// //                         DateTime? picked = await showDatePicker(
// //                           context: context,
// //                           initialDate: when,
// //                           firstDate: DateTime(2015, 8),
// //                           lastDate: DateTime(2101),
// //                         );
// //                         setState(() {
// //                           when = picked!;
// //                         });
// //                       }),
// //                 ],
// //               ))
// //             ],
// //           ),
// //           actions: <Widget>[
// //             FlatButton(
// //                 child: const Text('OK'),
// //                 onPressed: () {
// //                   Navigator.of(context).pop(true);
// //                 }),
// //             FlatButton(
// //                 child: const Text("CANCEL"),
// //                 onPressed: () {
// //                   Navigator.of(context).pop(false);
// //                 }),
// //           ],
// //         );
// //       },
// //     );
// //   }
// // }
  