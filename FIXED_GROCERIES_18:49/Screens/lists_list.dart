// import 'package:first_app/constants/appcolors.dart';
// import 'package:first_app/Screens/welcome_page.dart';
// import 'package:first_app/Screens/add_product.dart';
// import 'package:flutter/material.dart';
// import 'package:first_app/buttons/form_field.dart';
// import 'package:first_app/buttons/state_icon_button.dart';

// class my_cup_list extends StatefulWidget {
//   const my_cup_list({Key? key}) : super(key: key);

//   @override
//   State<StatefulWidget> createState() => _my_cup_list_state();
// }

// class _my_cup_list_state extends State<my_cup_list> {
//   // Widget _buildProductList(){
//   //   return ListView.separated(
//   //     padding: const EdgeInsets.all(16.0),
//   //     itemCount
//   //   )
//   // }
//   final _formKey = GlobalKey<FormState>();
//   Future<void> OpenForm() async {
//     return showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             backgroundColor: AppColors.LIGHT_PINK,
//             content: SingleChildScrollView(
//                 child: ListBody(
//               children: <Widget>[
//                 Form(
//                     key: _formKey,
//                     child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Form_Field(
//                             color: AppColors.PURPLE,
//                             maintitle: 'Product Name',
//                             edges: 10,
//                             createPage: () => add_product(),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'field required';
//                               }
//                               return null;
//                             },
//                           ),
//                           Form_Field(
//                             color: AppColors.BLUE,
//                             maintitle: 'Product Type',
//                             edges: 10,
//                             createPage: () => add_product(),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'field required';
//                               }
//                               return null;
//                             },
//                           ),
//                           Form_Field(
//                             color: AppColors.PINK,
//                             maintitle: 'Product Brand',
//                             edges: 10,
//                             createPage: () => add_product(),
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'field required';
//                               }
//                               return null;
//                             },
//                           ),
//                         ])),
//                 const Flexible(fit: FlexFit.tight, child: SizedBox()),
//                 Row(children: [
//                   state_icon_button(
//                       data: 'notifications',
//                       color: AppColors.VERY_LIGHT_BLUE,
//                       color_back: AppColors.LIGHT_BLUE,
//                       image_off: 'images/notifications_off.png',
//                       image_on: 'images/notifications_on.png'),
//                   const Flexible(fit: FlexFit.tight, child: SizedBox()),
//                   CircleAvatar(
//                       backgroundColor: AppColors.BLUE,
//                       child: IconButton(
//                           onPressed: () {
//                             if (_formKey.currentState!.validate()) {
//                               Navigator.pop(context);
//                             }
//                           },
//                           icon: const Icon(
//                             Icons.check,
//                             color: Colors.white,
//                           ))),
//                 ])
//               ],
//             )),
//             // actions: <Widget>[
//             //   FlatButton(child: Text('hello'), onPressed: () {})
//             // ]
//           );
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           title: const Text('My Cupboards',
//               textAlign: TextAlign.center,
//               style: TextStyle(fontFamily: "Rationale")),
//           centerTitle: true,
//           leading: IconButton(
//             icon: const Icon(Icons.home_sharp),
//             tooltip: 'back to home page',
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//           backgroundColor: AppColors.LIGHT_BLUE),
//       bottomNavigationBar: BottomAppBar(
//         child: Row(
//           mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             IconButton(onPressed: () {}, icon: const Icon(null))
//           ],
//         ),
//         color: AppColors.LIGHT_BLUE,
//       ),
//       floatingActionButton: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         mainAxisSize: MainAxisSize.max,
//         children: <Widget>[
//           Container(
//               // alignment: Alignment.bottomRight,
//               padding: EdgeInsets.only(left: 30.0, bottom: 1.0),
//               child: FloatingActionButton.extended(
//                 icon: const Icon(Icons.sort),
//                 label: const Text('sort'),
//                 onPressed: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => add_product()));
//                 },
//                 backgroundColor: AppColors.PURPLE,
//                 tooltip: 'sort',
//                 elevation: 20.0,
//               )),
//           Container(
//               //alignment: Alignment.bottomLeft,
//               margin: EdgeInsets.all(10),
//               child: FloatingActionButton(
//                 child: const Icon(Icons.add),
//                 onPressed: OpenForm,
//                 backgroundColor: AppColors.PINK,
//                 tooltip: 'add product',
//                 elevation: 20.0,
//               )),
//         ],
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
//       //body: ,
//     );
//   }
// }

// // class Product{
// //   String title;
// //   Task({required this.title})
// // }