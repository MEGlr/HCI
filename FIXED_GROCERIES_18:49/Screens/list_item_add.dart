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

class item_add_page extends StatefulWidget {
  final bool FromFavList;
  const item_add_page({Key? key, this.FromFavList = false}) : super(key: key);

  @override
  State<item_add_page> createState() => _item_add_pageState();
}

class _item_add_pageState extends State<item_add_page> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _dateTime;
  final _nameController = TextEditingController();
  final _quantController = TextEditingController();
  final _brandController = TextEditingController();
  final _typeController = TextEditingController();

  int? _currentIntValue;
  bool FromFavList = false;
  @override
  initState() {
    FromFavList = widget.FromFavList;
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
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            }
            // context,
            // (route) =>
            //     route.settings.name ==
            //     '/cupList') //Navigator.of(context).push(MaterialPageRoute(builder: (context) => ).then((_){setState(() {

            ));
  }

  _handleValueChanged(int value) {
    if (value != null) {
      setState(() {
        _currentIntValue = value;
      });
    }
  }

  Future<void> _numberShow1() async {
    int? currentValue = 1;
    showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: AppColors.LIGHT_PINK,
            title: Text("Quantity",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.PURPLE, fontFamily: "Rationale")),
            content: StatefulBuilder(builder: (context, SBsetState) {
              return NumberPicker(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    // boxShadow: [
                    //   BoxShadow(
                    //       color: AppColors.MOODY_PINK.withOpacity(0.7),
                    //       spreadRadius: 5,
                    //       blurRadius: 10,
                    //       offset: Offset(0, 0))
                    // ],
                    border: Border.all(color: AppColors.PURPLE),
                  ),
                  //  axis: Axis.horizontal,
                  haptics: true,
                  selectedTextStyle: TextStyle(
                    color: Colors.black,
                  ),
                  value: (currentValue != null ? (currentValue) : 1)!,
                  minValue: 1,
                  maxValue: 20,
                  onChanged: (value) {
                    setState(() => currentValue =
                        value); // to change on widget level state
                    SBsetState(() => currentValue = value);
                    setState(() {}); //* to change on dialog state
                  });
            }),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.check,
                  color: AppColors.PURPLE,
                ),
                onPressed: () {
                  setState(() {
                    print(currentValue);
                    _currentIntValue = currentValue!;
                    _quantController.text = '$currentValue';
                  });
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _brandController.dispose();
    _quantController.dispose();
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
              title: const Text('Add Product',
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
                          Container(
                            child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  controller: _quantController,
                                  cursorColor: Colors.white,
                                  style: TextStyle(color: Colors.white),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'field required';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    //isCollapsed: true,
                                    //contentPadding: const EdgeInsets.all(10),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: AppColors.LIGHT_BLUE,
                                    //labelText: data,
                                    //labelStyle: TextStyle(color: Colors.brown),
                                    hintText: _currentIntValue != null
                                        ? ('$_currentIntValue')
                                        : 'Quantity',
                                    hintStyle: TextStyle(color: Colors.white),
                                    suffixIcon: IconButton(
                                      onPressed: _numberShow1,
                                      icon: Image.asset(
                                          'images/up_down_arrow.png',
                                          color: Colors.white),
                                    ),
                                  ),
                                )),
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
                                      final entry = ListItem(
                                        // selected: MyData.globally_selected,
                                        brand: _brandController.text,
                                        name: _nameController.text,
                                        quantity:
                                            // _currentIntValue != null
                                            //     ? (_currentIntValue).toString()
                                            //     :
                                            _quantController.text,
                                        type: _typeController.text,
                                      );
                                      Navigator.pop(context, entry);
                                    }
                                    print(_quantController.text);
                                    _quantController.text = "";
                                    _typeController.text = "";
                                    _brandController.text = "";
                                    _nameController.text = "";
                                    MyData.globally_selected = false;
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

