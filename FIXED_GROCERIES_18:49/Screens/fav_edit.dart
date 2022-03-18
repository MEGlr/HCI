import 'package:flutter/material.dart';
import 'package:first_app/buttons/general_button.dart';
import 'package:first_app/constants/appcolors.dart';
//import 'package:first_app/Screens/my_cup_list_1.dart';
import 'package:first_app/add_form.dart';
import 'package:first_app/buttons/form_field.dart';
import 'package:first_app/Screens/add_product.dart';
import 'package:first_app/buttons/state_icon_button.dart';
//import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:first_app/Screens/number_picker.dart';
import 'package:first_app/buttons/form_field_function.dart';
import 'package:first_app/dialogs/general_dialog.dart';
import 'package:first_app/data_classes.dart';

class fav_edit_page extends StatefulWidget {
  final int index;
  const fav_edit_page({Key? key, required this.index}) : super(key: key);
  @override
  State<fav_edit_page> createState() => _fav_edit_pageState();
}

class _fav_edit_pageState extends State<fav_edit_page> {
  int index = 1;
  @override
  void initState() {
    index = widget.index;

    _nameController.text = _favorites[index].name;
    _typeController.text = _favorites[index].type;
    _brandController.text = _favorites[index].brand;
  }

  final _formKey = GlobalKey<FormState>();
  final _favorites = MyData.favorites;

  DateTime? _dateTime;
  final _nameController = TextEditingController();

  final _brandController = TextEditingController();
  final _typeController = TextEditingController();

  Future<void> _showAlertDialog() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) => GenDisplay(
            maintitle:
                "Are you sure you want to go back?\nAll changes will be lost. ",
            color: AppColors.BLUE,
            left: "Cancel",
            right: "Yes",
            edges: 5,
            createPageL: () => Navigator.pop(context),
            createPageR: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            }
            // context,
            // (route) =>
            //     route.settings.name ==
            //     '/cupList') //Navigator.of(context).push(MaterialPageRoute(builder: (context) => ).then((_){setState(() {

            ));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _brandController.dispose();
    _typeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
      onWillPop: () async {
        _showAlertDialog();
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
              title: const Text('Edit Favorite Product',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: "Rationale")),
              centerTitle: true,
              backgroundColor: AppColors.BLUE),
          body: Padding(
              padding: EdgeInsets.all(10),
              child: Column(children: [
                Form(
                    key: _formKey,
                    child: Wrap(spacing: 5.0,
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                              child: Form_Field(
                            color: AppColors.PURPLE,
                            maintitle:
                                'Product Name : ' + _favorites[index].name,
                            edges: 10,
                            controller: _nameController,
                            createPage: () => add_product(),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'field required';
                              }
                              return null;
                            },
                          )),
                          // SizedBox(
                          //     child: Form_Field_f(
                          //   color: AppColors.LIGHT_BLUE,
                          //   maintitle: //'Quantity',
                          //       _currentIntValue != null
                          //           ? ('$_currentIntValue')
                          //           : 'Quantity',
                          //   image: 'images/up_down_arrow.png',
                          //   edges: 10,
                          //   controller: _quantController,
                          //   createPage: _numberShow1,
                          //   validator: (value) {
                          //     if (value == null || value.isEmpty) {
                          //       return 'field required';
                          //     }
                          //     return null;
                          //   },
                          // )),
                          // Container(
                          //   child: Padding(
                          //       padding: const EdgeInsets.all(10.0),
                          //       child: TextFormField(
                          //         // controller: _expController,
                          //         // validator: (value) {
                          //         //   if (value == null || value.isEmpty) {
                          //         //     return 'field required';
                          //         //   }
                          //         //   return null;
                          //         // },
                          //         cursorColor: Colors.white,
                          //         style: TextStyle(color: Colors.white),
                          //         decoration: InputDecoration(
                          //           //isCollapsed: true,
                          //           //contentPadding: const EdgeInsets.all(10),
                          //           border: OutlineInputBorder(
                          //             borderRadius: BorderRadius.circular(10),
                          //             borderSide: BorderSide.none,
                          //           ),
                          //           filled: true,
                          //           fillColor: AppColors.PINK,
                          //           //labelText: data,
                          //           //labelStyle: TextStyle(color: Colors.brown),
                          //           hintText: // _dateTime != null
                          //               //? DateFormat("dd/MM/yyyy")
                          //               //    .format(_dateTime):
                          //               'Expiration Date',

                          //           hintStyle: TextStyle(
                          //               color: Colors.white,
                          //               fontFamily: "PublicSans"),
                          //           suffixIcon: IconButton(
                          //             onPressed: _show,
                          //             icon: Icon(Icons.calendar_today,
                          //                 color: Colors.white),
                          //           ),
                          //         ),
                          //       )),
                          // ),
                          SizedBox(
                              child: Form_Field(
                            color: AppColors.BLUE,
                            maintitle:
                                'Product Type : ' + _favorites[index].type,
                            edges: 10,
                            controller: _typeController,
                            createPage: () => add_product(),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'field required';
                              }
                              return null;
                            },
                          )),
                          Form_Field(
                            color: AppColors.PINK_PINK,
                            maintitle:
                                'Product Brand : ' + _favorites[index].brand,
                            edges: 10,
                            createPage: () => add_product(),
                            controller: _brandController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'field required';
                              }
                              return null;
                            },
                          ),
                        ])),
                const Flexible(
                    fit: FlexFit.tight,
                    child: SizedBox(
                      height: 16,
                    )),
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                        //mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          state_icon_button(
                              data: 'add to favorites',
                              color: AppColors.BLUE,
                              color_back: AppColors.LIGHT_BLUE,
                              image_on: 'images/notifications_on.png',
                              image_off: 'images/notifications_off.png'),
                          const Flexible(fit: FlexFit.tight, child: SizedBox()),
                          Align(
                              alignment: Alignment.bottomRight,
                              child: MaterialButton(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(20),
                                  color: AppColors.BLUE,
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      final entry = FavoriteItem(
                                        brand: _brandController.text,
                                        name: _nameController.text,
                                        type: _typeController.text,
                                      );
                                      Navigator.pop(context, entry);
                                    }

                                    _typeController.text = "";
                                    _brandController.text = "";
                                    _nameController.text = "";
                                  },
                                  child: const Icon(Icons.check,
                                      color: Colors.white, size: 40))),
                          //   CircleAvatar(
                          //       backgroundColor: AppColors.BLUE,
                          //       child: IconButton(
                          //           onPressed: _deleteTask,
                          //           icon: const Icon(
                          //             Icons.check,
                          //             color: Colors.white,
                          //           ))),
                        ]))
              ]))));
}
//}

