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
//import 'package:first_app/buttons/form_field_function.dart';
import 'package:first_app/dialogs/general_dialog.dart';
import 'package:first_app/data_classes.dart';
import 'package:first_app/Screens/my_cup_list_1.dart';
import 'package:first_app/buttons/cam_mic.dart';

class product_edit_page extends StatefulWidget {
  final int index;
  const product_edit_page({Key? key, required this.index}) : super(key: key);
  @override
  State<product_edit_page> createState() => _product_edit_pageState();
}

class _product_edit_pageState extends State<product_edit_page> {
  int index = 0;
  @override
  void initState() {
    index = widget.index;
    print((_products[index].expired).toString());
    _expController.text = (_products[index].expired).toString();
    _nameController.text = _products[index].name;
    _typeController.text = _products[index].type;
    _brandController.text = _products[index].brand;
    _quantController.text = _products[index].quantity;
    MyData.globally_selected = _products[index].isFav;
  }

  final _formKey = GlobalKey<FormState>();
  final _products = MyData.products;

  DateTime? _dateTime;
  final _nameController = TextEditingController();
  final _quantController = TextEditingController();
  final _brandController = TextEditingController();
  final _typeController = TextEditingController();
  final _expController = TextEditingController();
  int? _currentIntValue;

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
                    MyData.globally_selected = false;
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

  Future<void> _show() async {
    final DateTime? result = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021),
        lastDate: DateTime(2030),
        builder: (context, child) => Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: AppColors.BLUE, // header background color
                  onPrimary: AppColors.VERY_LIGHT_BLUE, // header text color
                  onSurface: AppColors.BLUE, // body text color
                ),
                textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                  primary: AppColors.BLUE, // button text color
                )),
                dialogBackgroundColor: AppColors.VERY_LIGHT_BLUE,
              ),
              child: child!,
            ));
    if (result != null) {
      print("jel");
      setState(() {
        _dateTime = result;
        _expController.text = (_dateTime).toString();
      });
    }
  }

  void _show_mic_text(int i) async {
    final String result = await Navigator.of(context).push(PageRouteBuilder(
        opaque: false, pageBuilder: (context, __, ___) => cam_and_mic()));

    setState(() {
      if (i == 0) {
        _nameController.text = result;
      } else if (i == 1) {
        _typeController.text = result;
      } else {
        _brandController.text = result;
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _brandController.dispose();
    _quantController.dispose();
    _typeController.dispose();
    _expController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
      onWillPop: () async {
        _showAlertDialog();
        return true;
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
              title: const Text('Edit Product',
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
                                'Product Name : ' + _products[index].name,
                            edges: 10,
                            controller: _nameController,
                            createPage: () => _show_mic_text(0),
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
                            maintitle:
                                'Product Type : ' + _products[index].type,
                            edges: 10,
                            controller: _typeController,
                            createPage: () => _show_mic_text(1),
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
                                'Product Brand : ' + _products[index].brand,
                            edges: 10,
                            createPage: () => _show_mic_text(3),
                            controller: _brandController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'field required';
                              }
                              return null;
                            },
                          ),
                        ])),
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
                              : 'Quantity : ' + _products[index].quantity,
                          hintStyle: TextStyle(color: Colors.white),
                          suffixIcon: IconButton(
                            onPressed: _numberShow1,
                            icon: Image.asset('assets/images/up_down_arrow.png',
                                color: Colors.white),
                          ),
                        ),
                      )),
                ),
                Container(
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: _expController,
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
                          fillColor: AppColors.PINK,
                          //labelText: data,
                          //labelStyle: TextStyle(color: Colors.brown),
                          hintText: (_dateTime != null
                              ? _dateTime.toString()
                              : 'Expiration Date : ' +
                                  (_products[index].expired).toString()),
                          hintStyle: TextStyle(color: Colors.white),
                          suffixIcon: IconButton(
                            onPressed: _show,
                            icon:
                                Icon(Icons.calendar_today, color: Colors.white),
                          ),
                        ),
                      )),
                ),
                // RaisedButton(
                //     onPressed: _show,
                //     shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(10)),
                //     color: AppColors.PINK,
                //     padding: EdgeInsets.all(20),
                //     child: Column(mainAxisSize: MainAxisSize.min, children: [
                //       Icon(
                //         Icons.calendar_today,
                //         size: 40,
                //         color: Colors.white,
                //       ),
                //       Row(mainAxisSize: MainAxisSize.min, children: [
                //         Text(
                //             //_dateTime != null
                //             //? DateFormat("dd/MM/yyyy").format(_dateTime)
                //             //:
                //             'Expiration Date',
                //             textAlign: TextAlign.center,
                //             style: TextStyle(
                //                 color: Colors.white, fontFamily: "PublicSans")),
                //         SizedBox(width: 10),
                //         IconButton(
                //             icon: Image.asset('images/cam_mic.png'),
                //             onPressed: () {
                //               print("hello");
                //               Navigator.of(context).pop();
                //             }),
                //       ])
                //     ])),
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
                              color: AppColors.PURPLE,
                              color_back: AppColors.PINK_PINK,
                              image_on: 'assets/images/star_unfilled.png',
                              image_off: 'assets/images/star_filled.png'),
                          Align(
                              alignment: Alignment.bottomLeft,
                              child: MaterialButton(
                                  elevation: 0,
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(20),
                                  color: AppColors.PURPLE,
                                  onPressed: () {
                                    _products.removeAt(index);
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                my_cup_list()));
                                  },
                                  child: const Icon(Icons.delete,
                                      color: Colors.white, size: 30))),
                          const Flexible(fit: FlexFit.tight, child: SizedBox()),

                          Align(
                              alignment: Alignment.bottomRight,
                              child: MaterialButton(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(20),
                                  color: AppColors.BLUE,
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      final entry = ProductItem(
                                        isFav: MyData.globally_selected,
                                        brand: _brandController.text,
                                        name: _nameController.text,
                                        quantity:
                                            // _currentIntValue != null
                                            //     ? (_currentIntValue).toString()
                                            //     :
                                            _quantController.text,
                                        type: _typeController.text,
                                        expired:
                                            //DateFormat("dd/MM/yyyy")
                                            //  .format(
                                            _expController.text,
                                      );
                                      Navigator.pop(context, entry);
                                    }
                                    print(_quantController.text);
                                    _quantController.text = "";
                                    _typeController.text = "";
                                    _brandController.text = "";
                                    _nameController.text = "";
                                    _expController.text = '';
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

