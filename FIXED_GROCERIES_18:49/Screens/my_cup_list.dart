import 'package:first_app/constants/appcolors.dart';
//import 'package:first_app/Screens/welcome_page.dart';
import 'package:first_app/Screens/add_product.dart';
import 'package:flutter/material.dart';
import 'package:first_app/buttons/form_field.dart';
import 'package:first_app/buttons/state_icon_button.dart';
import 'package:first_app/buttons/list_item.dart';
import 'package:first_app/dialogs/general_dialog.dart';
import 'dart:async';

//import 'package:numberpicker/numberpicker.dart';

class my_cup_list extends StatefulWidget {
  const my_cup_list({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _my_cup_list_state();
}

class _my_cup_list_state extends State<my_cup_list> {
  // Widget _buildProductList(){
  //   return ListView.separated(
  //     padding: const EdgeInsets.all(16.0),
  //     itemCount
  //   )
  // }
  final _products = <ProductItem>[];
  void _deleteTask() async {
    bool? _delEntry = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) => GenDisplay(
              maintitle:
                  "You added to your cart a\n product you already seem to \n have in your Cupboards! \n Are you sure you want to\n proceed with buying it?",
              color: AppColors.PURPLE,
              left: "No, go back",
              right: "Yes, I'm sure",
              edges: 5,
              createPageL: () => Navigator.pop(context, false),
              createPageR: () => add_product(),
            ));
    if (_delEntry!) {
      _products.removeWhere((element) => element.Selected);
    }
  }

  Widget _buildProductList() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _products.length,
        itemBuilder: (context, index) {
          return Product(
              maintitle: _products[index].name,
              subtitle: _products[index].brand);
        });
  }

  final _formKey = GlobalKey<FormState>();
  DateTime? _dateTime;
  final _nameController = TextEditingController();
  final _quantController = TextEditingController();
  final _brandController = TextEditingController();
  final _typeController = TextEditingController();

  Future<void> _show() async {
    final DateTime? result = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021),
        lastDate: DateTime(2030));
    if (result != null) {
      print("jel");
      setState(() {
        _dateTime = result;
      });
    }
  }

  Future<void> OpenForm() async {
    final ProductItem _newEntry = await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: AppColors.LIGHT_PINK,
            content: SingleChildScrollView(
                child: ListBody(
              children: <Widget>[
                Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_back,
                          color: AppColors.PURPLE,
                          size: 20,
                        ))),
                Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Form_Field(
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
                          ),
                          Form_Field(
                            color: AppColors.LIGHT_BLUE,
                            maintitle: 'Quantity',
                            image: 'images/up_down_arrow.png',
                            edges: 10,
                            controller: _quantController,
                            createPage: () => add_product(),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'field required';
                              }
                              return null;
                            },
                          ),
                          RaisedButton.icon(
                              onPressed: _show,
                              //() {
                              // showDatePicker(
                              //         context: context,
                              //         initialDate: DateTime.now(),
                              //         firstDate: DateTime(2021),
                              //         lastDate: DateTime(2030))
                              //     .then((date) {
                              //   setState(() {
                              //     _dateTime = date!;
                              //   });
                              // });
                              //},
                              icon: Image.asset('images/cam_mic.png'),
                              label: Text(_dateTime != null
                                  ? _dateTime.toString()
                                  : 'Expiration Date')),
                          Form_Field(
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
                          ),
                          Form_Field(
                            color: AppColors.PINK,
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
                //Padding(
                //  padding: const EdgeInsets.only(right: 1.0),
                //child:
                Row(
                    //mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      state_icon_button(
                          data: 'notifications',
                          color: AppColors.VERY_LIGHT_BLUE,
                          color_back: AppColors.LIGHT_BLUE,
                          image_off: 'images/notifications_off.png',
                          image_on: 'images/notifications_on.png'),
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
                                    brand: _brandController.text,
                                    name: _nameController.text,
                                    quantity: _quantController.text,
                                    type: _typeController.text,
                                    expired: _dateTime,
                                  );
                                  Navigator.pop(context, entry);
                                }
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
                    ])
              ],
            )),
            // actions: <Widget>[
            //   FlatButton(child: Text('hello'), onPressed: () {})
            // ]
          );
        });
    if (_newEntry != null)
      _products.add(ProductItem(
          brand: _newEntry.brand,
          type: _newEntry.type,
          quantity: _newEntry.quantity,
          name: _newEntry.name,
          expired: _newEntry.expired));

    setState(() {});
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('My Cupboards',
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: "Rationale")),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.home_sharp),
            tooltip: 'back to home page',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: AppColors.LIGHT_BLUE),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(onPressed: () {}, icon: const Icon(null))
          ],
        ),
        color: AppColors.LIGHT_BLUE,
      ),
      floatingActionButton: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
              // alignment: Alignment.bottomRight,
              padding: EdgeInsets.only(left: 30.0, bottom: 1.0),
              child: FloatingActionButton.extended(
                icon: const Icon(Icons.sort),
                label: const Text('sort'),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => add_product()));
                },
                backgroundColor: AppColors.PURPLE,
                tooltip: 'sort',
                elevation: 20.0,
              )),
          Container(
              //alignment: Alignment.bottomLeft,
              margin: EdgeInsets.all(10),
              child: FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: OpenForm,
                backgroundColor: AppColors.PINK,
                tooltip: 'add product',
                elevation: 20.0,
              )),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: _buildProductList(),
    );
  }
}

class ProductItem {
  String name;
  String brand;
  String quantity;
  String type;
  bool Selected;
  DateTime? expired;
  ProductItem({
    required this.name,
    required this.brand,
    required this.quantity,
    required this.type,
    this.Selected = false,
    required this.expired,
  });
}



// GenDisplay(
//               maintitle:
//                   "You added to your cart a\n product you already seem to \n have in your Cupboards! \n Are you sure you want to\n proceed with buying it?",
//               color: AppColors.PURPLE,
//               left: "No, go back",
//               right: "Yes, I'm sure",
//               edges: 5,
//               createPageL: () => Navigator.pop(context, false),
//               createPageR: () => Navigator.pop(context, true),
//             ));