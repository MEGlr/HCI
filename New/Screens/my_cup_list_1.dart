import 'package:first_app/Screens/product_add.dart';
import 'package:first_app/constants/appcolors.dart';
//import 'package:first_app/Screens/welcome_page.dart';
import 'package:first_app/Screens/add_product.dart';
import 'package:flutter/material.dart';
import 'package:first_app/buttons/form_field.dart';
import 'package:first_app/buttons/state_icon_button.dart';
import 'package:first_app/buttons/list_item.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:first_app/dialogs/general_dialog.dart';
import 'package:first_app/Screens/number_picker.dart';

class my_cup_list extends StatefulWidget {
//  const my_cup_list({Key? key}) : super(key: key);

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
  bool isSelectionMode = false;
  Map<int, bool> selectedFlag = {};
  final _products = <ProductItem>[];

  void _addNewEntry() async {
    final ProductItem _newEntry = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => product_add_page()));
    print(_newEntry);
    if (_newEntry != null) {
      _products.add(ProductItem(
          brand: _newEntry.brand,
          type: _newEntry.type,
          quantity: _newEntry.quantity,
          name: _newEntry.name));
    }
    setState(() {});
  }

  Widget _buildProductList() {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(),
      padding: const EdgeInsets.all(16.0),
      itemCount: _products.length,
      itemBuilder: (context, index) {
        selectedFlag[index] = selectedFlag[index] ?? false;
        bool isSelected = selectedFlag[index] ?? false;

        return Slidable(
            startActionPane:
                ActionPane(motion: const ScrollMotion(), children: [
              SlidableAction(
                  onPressed: (BuildContext context) {},
                  backgroundColor: AppColors.PINK,
                  foregroundColor: Colors.white,
                  icon: Icons.star,
                  label: 'Fave')
            ]),
            child: InkWell(
                onTap: () {}, //edit product pop up
                //          Product(
                //             maintitle: "foof",
                //             color: AppColors.PINK,
                //             createPage: () => add_product(),
                //             image: 'images/Button.png',
                //             edges:'round')))
                child: ListTile(
                  tileColor:
                      isSelected ? AppColors.VERY_LIGHT_BLUE : AppColors.BLUE,
                  onLongPress: () => onLongPress(isSelected, index),
                  onTap: () => onTap(isSelected, index),
                  title: Text(_products[index].name),
                  subtitle: Text(
                      _products[index].brand + ", " + _products[index].type),
                  leading:
                      _buildSelectIcon(isSelected, _products[index].quantity),
                )));
      },
    );
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
      _dateTime = result;
      setState(() {});
      print(_dateTime);
    }
  }

  void _deleteTask() async {
    bool? _delEntry = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) => GenDisplay(
              maintitle:
                  "Are you sure you want to delete all \n selected items? ",
              color: AppColors.BLUE,
              left: "Cancel",
              right: "Yes",
              edges: 5,
              createPageL: () => Navigator.pop(context, false),
              createPageR: () => Navigator.pop(context, true),
            ));
    if (_delEntry!) {
      _products.removeWhere((element) => element.selected == true);
      if (_products.length == 0) isSelectionMode = false;
      setState(() {});
    }
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
              //Navigator.of(context).pop();
            }
            // context,
            // (route) =>
            //     route.settings.name ==
            //     '/cupList') //Navigator.of(context).push(MaterialPageRoute(builder: (context) => ).then((_){setState(() {

            ));
  }

  // Future<void> OpenForm() async {
  //   //final _formKey = GlobalKey<FormState>();

  //   final ProductItem _newEntry = await showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           backgroundColor: AppColors.LIGHT_PINK,
  //           content: SingleChildScrollView(
  //               child: ListBody(
  //             children: <Widget>[
  //               Align(
  //                   alignment: Alignment.topLeft,
  //                   child: IconButton(
  //                       onPressed: _showAlertDialog,
  //                       icon: const Icon(
  //                         Icons.arrow_back,
  //                         color: AppColors.PURPLE,
  //                         size: 20,
  //                       ))),
  //               Form(
  //                   key: _formKey,
  //                   child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: <Widget>[
  //                         Form_Field(
  //                           color: AppColors.PURPLE,
  //                           maintitle: 'Product Name',
  //                           edges: 10,
  //                           controller: _nameController,
  //                           createPage: () => add_product(),
  //                           validator: (value) {
  //                             if (value == null || value.isEmpty) {
  //                               return 'field required';
  //                             }
  //                             return null;
  //                           },
  //                         ),
  //                         Form_Field(
  //                           color: AppColors.LIGHT_BLUE,
  //                           maintitle: 'Quantity',
  //                           image: 'images/up_down_arrow.png',
  //                           edges: 10,
  //                           controller: _quantController,
  //                           createPage: () => add_product(),
  //                           validator: (value) {
  //                             if (value == null || value.isEmpty) {
  //                               return 'field required';
  //                             }
  //                             return null;
  //                           },
  //                         ),
  //                         RaisedButton.icon(
  //                             onPressed: //_show,
  //                                 () {
  //                               showDatePicker(
  //                                       context: context,
  //                                       initialDate: DateTime.now(),
  //                                       firstDate: DateTime(2021),
  //                                       lastDate: DateTime(2030))
  //                                   .then((date) {
  //                                 setState(() {
  //                                   _dateTime = date!;
  //                                 });
  //                               });
  //                             },
  //                             icon: Image.asset('images/cam_mic.png'),
  //                             label: Text(_dateTime != null
  //                                 ? _dateTime.toString()
  //                                 : 'Expiration Date')),
  //                         Form_Field(
  //                           color: AppColors.BLUE,
  //                           maintitle: 'Product Type',
  //                           edges: 10,
  //                           controller: _typeController,
  //                           createPage: () => add_product(),
  //                           validator: (value) {
  //                             if (value == null || value.isEmpty) {
  //                               return 'field required';
  //                             }
  //                             return null;
  //                           },
  //                         ),
  //                         Form_Field(
  //                           color: AppColors.PINK,
  //                           maintitle: 'Product Brand',
  //                           edges: 10,
  //                           createPage: () => add_product(),
  //                           controller: _brandController,
  //                           validator: (value) {
  //                             if (value == null || value.isEmpty) {
  //                               return 'field required';
  //                             }
  //                             return null;
  //                           },
  //                         ),
  //                       ])),
  //               const Flexible(
  //                   fit: FlexFit.tight,
  //                   child: SizedBox(
  //                     height: 16,
  //                   )),
  //               //Padding(
  //               //  padding: const EdgeInsets.only(right: 1.0),
  //               //child:
  //               Row(
  //                   //mainAxisSize: MainAxisSize.max,
  //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                   children: [
  //                     state_icon_button(
  //                         data: 'notifications',
  //                         color: AppColors.VERY_LIGHT_BLUE,
  //                         color_back: AppColors.LIGHT_BLUE,
  //                         image_off: 'images/notifications_off.png',
  //                         image_on: 'images/notifications_on.png'),
  //                     const Flexible(fit: FlexFit.tight, child: SizedBox()),
  //                     Align(
  //                         alignment: Alignment.bottomRight,
  //                         child: MaterialButton(
  //                             shape: const CircleBorder(),
  //                             padding: const EdgeInsets.all(20),
  //                             color: AppColors.BLUE,
  //                             onPressed: () {
  //                               if (_formKey.currentState!.validate()) {
  //                                 final entry = ProductItem(
  //                                   brand: _brandController.text,
  //                                   name: _dateTime
  //                                       .toString(), //_nameController.text,
  //                                   quantity: _quantController.text,
  //                                   type: _typeController.text,
  //                                   expired: _dateTime,
  //                                 );
  //                                 Navigator.pop(context, entry);
  //                               }
  //                               _quantController.text = "";
  //                               _typeController.text = "";
  //                               _brandController.text = "";
  //                               _nameController.text = "";
  //                             },
  //                             child: const Icon(Icons.check,
  //                                 color: Colors.white, size: 40))),
  //                     //   CircleAvatar(
  //                     //       backgroundColor: AppColors.BLUE,
  //                     //       child: IconButton(
  //                     //           onPressed: _deleteTask,
  //                     //           icon: const Icon(
  //                     //             Icons.check,
  //                     //             color: Colors.white,
  //                     //           ))),
  //                   ])
  //             ],
  //           )),
  //           // actions: <Widget>[
  //           //   FlatButton(child: Text('hello'), onPressed: () {})
  //           // ]
  //         );
  //       });

  //   if (_newEntry != null) {
  //     _products.add(ProductItem(
  //         brand: _newEntry.brand,
  //         type: _newEntry.type,
  //         quantity: _newEntry.quantity,
  //         name: _newEntry.name));
  //   }
  //   setState(() {});
  // }

  // @override
  // void dispose() {
  //   _nameController.dispose();
  //   _brandController.dispose();
  //   _quantController.dispose();
  //   _typeController.dispose();
  //   super.dispose();
  // }

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
              child: _buildSelectAllButton()),
          Container(
              //alignment: Alignment.bottomLeft,
              margin: EdgeInsets.all(10),
              child: _buildDeleteButton()),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: _buildProductList(),
    );
  }

  void onTap(bool isSelected, int index) {
    if (isSelectionMode) {
      setState(() {
        selectedFlag[index] = !isSelected;
        _products[index].selected = !isSelected;
        print(index);
        print(_products[index].selected);
        isSelectionMode = selectedFlag.containsValue(true);
      });
    } else {
      // Open Detail Page
    }
  }

  void onLongPress(bool isSelected, int index) {
    print("here");
    setState(() {
      selectedFlag[index] = false;
      isSelectionMode = selectedFlag.containsValue(true);
      if (_products.length == 1) isSelectionMode = true;
    });
  }

  Widget _buildSelectIcon(bool isSelected, String quant) {
    if (isSelectionMode) {
      return Icon(isSelected ? Icons.check_box : Icons.check_box_outline_blank,
          //color: Theme.of(context).primaryColor,
          color: isSelected ? AppColors.PURPLE : Colors.white);
    } else {
      return CircleAvatar(
          radius: 16,
          backgroundColor: AppColors.LIGHT_BLUE,
          child: CircleAvatar(
              child: Text(quant), radius: 14, backgroundColor: AppColors.BLUE));
    }
  }

  Widget _buildSelectAllButton() {
    bool isFalseAvailable = selectedFlag.containsValue(false);
    if (isSelectionMode) {
      return FloatingActionButton.extended(
        label: Text(isFalseAvailable ? "Select All" : "Cancel"),
        backgroundColor: isFalseAvailable ? AppColors.PURPLE : AppColors.PINK,
        onPressed: _selectAll,
      );
    } else {
      return //FloatingActionButton.extended(
          //
          PopupMenuButton(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        // icon:
        child: Container(
            decoration: BoxDecoration(
                color: AppColors.PURPLE,
                border: Border.all(
                  color: AppColors.PURPLE,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Wrap(children: [
                  const Text('sort',
                      style: TextStyle(
                          color: Colors.white, fontFamily: "PublicSans")),
                  SizedBox(width: 5),
                  const Icon(
                    Icons.sort,
                    color: Colors.white,
                  ),
                ]))),
        color: AppColors.PURPLE,
        tooltip: 'choose sorting critiria',

        elevation: 20.0,
        itemBuilder: (context) => <PopupMenuEntry>[
          const PopupMenuItem(
              value: 1,
              child: ListTile(
                  title:
                      Text('By product name', style: TextStyle(fontSize: 8)))),
          const PopupMenuItem(
              value: 2, child: ListTile(title: Text('By type name'))),
          const PopupMenuItem(
              value: 3, child: ListTile(title: Text('By brand name'))),
          const PopupMenuItem(
              value: 4, child: ListTile(title: Text('Recently Added'))),
        ],
        onSelected: (value) => setState(() {
          if (value == 1) {
            _products.sort((a, b) => a.name.compareTo(b.name));
          }
          if (value == 2) {
            _products.sort((a, b) => a.type.compareTo(b.type));
          }
          if (value == 3) {
            _products.sort((a, b) => a.brand.compareTo(b.brand));
          }
        }),
      );
    }
  }

  void _selectAll() {
    bool isFalseAvailable = selectedFlag.containsValue(false);
    // If false will be available then it will select all the checkbox
    // If there will be no false then it will de-select all
    selectedFlag.updateAll((key, value) => isFalseAvailable);
    setState(() {
      isSelectionMode = selectedFlag.containsValue(true);
    });
  }

  Widget _buildDeleteButton() {
    bool isFalseAvailable = selectedFlag.containsValue(false);
    if (isSelectionMode) {
      return FloatingActionButton(
        child: const Icon(Icons.delete),
        onPressed: _deleteTask,
        backgroundColor: AppColors.PURPLE,
        tooltip: 'delete',
        elevation: 20.0,
      );
    } else {
      return FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: _addNewEntry,
        //   Navigator.of(context).push(
        //       MaterialPageRoute(builder: (context) => product_add_page()));
        // },
        backgroundColor: AppColors.PINK,
        tooltip: 'add product',
        elevation: 20.0,
      );
    }
  }

  Widget slideRightBackground() {
    return Container(
      color: AppColors.PINK,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.star,
              color: Colors.white,
            ),
            Text(
              " Fave",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }
}
