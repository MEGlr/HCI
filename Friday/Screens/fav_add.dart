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

class fav_add_page extends StatefulWidget {
  const fav_add_page({Key? key}) : super(key: key);

  @override
  State<fav_add_page> createState() => _fav_add_pageState();
}

class _fav_add_pageState extends State<fav_add_page> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _dateTime;
  final _nameController = TextEditingController();
  final _brandController = TextEditingController();
  final _typeController = TextEditingController();
  @override
  void initState() {
    _typeController.text = "";
    _brandController.text = "";
    _nameController.text = "";
    MyData.globally_selected = false;
  }

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
              // Navigator.of(context).pop();
              // Navigator.of(context).pop();
              int count = 1;
              Navigator.popUntil(context, (route) {
                return count++ == 3;
              });
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
              title: const Text('Add Favorite Product',
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
                            maintitle: 'Product Name',
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
                          SizedBox(
                              child: Form_Field(
                            color: AppColors.BLUE,
                            maintitle: 'Product Type',
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
                            maintitle: 'Product Brand',
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
                          // MaterialButton(
                          //     shape: const CircleBorder(),
                          //     padding: const EdgeInsets.all(15),
                          //     color: AppColors.PINK,
                          //     onPressed: () => {
                          //           setState(() => MyData.globally_selected =
                          //               !MyData.globally_selected)
                          //         },
                          //     //print(globally_selected);

                          //     child: Image.asset(
                          //         MyData.globally_selected
                          //             ? 'images/star_filled.png'
                          //             : 'images/star_unfilled.png',
                          //         color: MyData.globally_selected
                          //             ? AppColors.PURPLE
                          //             : Colors.white,
                          //         width: 45,
                          //         height: 45)),

                          const Flexible(fit: FlexFit.tight, child: SizedBox()),
                          Align(
                              alignment: Alignment.bottomRight,
                              child: MaterialButton(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(20),
                                  color: AppColors.BLUE,
                                  onPressed: () {
                                    print("hello");
                                    print(MyData.globally_selected);
                                    if (_formKey.currentState!.validate()) {
                                      final entry = FavoriteItem(
                                        selected: MyData.globally_selected,
                                        brand: _brandController.text,
                                        name: _nameController.text,
                                        type: _typeController.text,
                                      );
                                      Navigator.pop(context, entry);
                                    }
                                  },
                                  child: const Icon(Icons.check,
                                      color: Colors.white, size: 40))),
                        ]))
              ]))));
}
