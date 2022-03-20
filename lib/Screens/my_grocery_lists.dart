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
import 'package:first_app/Screens/create_a_list.dart';
import 'package:first_app/Screens/edit_a_list.dart';
import 'package:first_app/data_classes.dart';

class my_groceries extends StatefulWidget {
  final bool FromFavList;

  const my_groceries({Key? key, this.FromFavList = false}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _my_groceries_state();
}

class _my_groceries_state extends State<my_groceries> {
  bool isSelectionMode = false;
  Map<int, bool> selectedFlag = {};
  //final _grocery_lists = <ProductItem>[];
  final _grocery_lists = MyData.grocery_lists;
  bool FromFavList = false;
  @override
  initState() {
    FromFavList = widget.FromFavList;
    isSelectionMode = FromFavList;
    MyData.globally_selected = false;
  }

  void _addNewEntry() async {
    final GroceryList? _newEntry = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => create_list()));
    // print(_newEntry);
    if (_newEntry != null) {
      _grocery_lists
          .add(GroceryList(name: _newEntry.name, products: _newEntry.products));
    }
    setState(() {});
  }

  void _editEntry(index) async {
    final GroceryList? _newEntry =
        await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => edit_list(
                  index: index,
                )));
    if (_newEntry != null) {
      // if (_newEntry.isFav == false) {
      //   _favorites.removeWhere((element) =>
      //       (element.name == _grocery_lists[index].name &&
      //           element.brand == _grocery_lists[index].brand));
      // } else {
      //   int findex = _favorites.indexWhere((element) =>
      //       (element.name == _grocery_lists[index].name &&
      //           element.brand == _grocery_lists[index].brand));
      //   if (findex > 0) {
      //     _favorites[findex].brand = _newEntry.brand;
      //     _favorites[findex].type = _newEntry.type;
      //     _favorites[findex].name = _newEntry.name;
      //   } else {
      //     _favorites.add(FavoriteItem(
      //       brand: _newEntry.brand,
      //       type: _newEntry.type,
      //       name: _newEntry.name,
      //       //selected: _newEntry.selected
      //     ));
      //   }
      // }

      _grocery_lists[index].name = _newEntry.name;
      _grocery_lists[index].products = _newEntry.products;
    }
    MyData.globally_selected = false;
    setState(() {});
  }

  void _addToFavs() async {
    bool? _delEntry = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) => GenDisplay(
              maintitle: "Add all selected items to ? ",
              color: AppColors.BLUE,
              left: "No, go back",
              right: "Done",
              edges: 5,
              createPageL: () => Navigator.pop(context, false),
              createPageR: () => Navigator.pop(context, true),
            ));
    if (_delEntry!) {
      //print('aaaaaaaaa');
      //print(MyData.favorites[0].selected);
      List<ListItem> temp = <ListItem>[];
      for (GroceryList i in _grocery_lists) {
        if (i.selected) {
          print('eeeee');
          temp = temp + i.products;
        }
      }
      final prod_entry = temp;

      print("lengrh");
      isSelectionMode = false;
      _grocery_lists.forEach((f) => f.selected = false);
      setState(() {});
      Navigator.pop(context, prod_entry);
    }
  }

  Widget _buildProductList() {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(),
      padding: const EdgeInsets.all(16.0),
      itemCount: _grocery_lists.length,
      itemBuilder: (context, index) {
        selectedFlag[index] = selectedFlag[index] ?? false;
        //bool isSelected = selectedFlag[index] ?? false;
        bool isSelected = _grocery_lists[index].selected;

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
                  title: Text(_grocery_lists[index].name),
                  // subtitle: Text(
                  //     _grocery_lists[index].brand + ", " + _grocery_lists[index].type),
                  leading: _buildSelectIcon(isSelected),
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
      _grocery_lists.removeWhere((element) => element.selected == true);
      isSelectionMode = false;
      _grocery_lists.forEach((f) => f.selected = false);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: const Text('Grocery Lists',
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
        _grocery_lists[index].selected = !isSelected;
        print(index);
        print(_grocery_lists[index].selected);
        isSelectionMode = selectedFlag.containsValue(true);
      });
    } else {
      _editEntry(index);
    }
  }

  void onLongPress(bool isSelected, int index) {
    print("here");
    setState(() {
      selectedFlag[index] = false;
      //isSelectionMode = selectedFlag.containsValue(true);
      isSelectionMode = true;
      if (_grocery_lists.length == 1) isSelectionMode = true;
    });
  }

  Widget _buildSelectIcon(bool isSelected) {
    if (isSelectionMode) {
      return Icon(isSelected ? Icons.check_box : Icons.check_box_outline_blank,
          //color: Theme.of(context).primaryColor,
          color: isSelected ? AppColors.PURPLE : Colors.white);
    } else {
      return Icon(Icons.list_sharp);
    }
  }

  Widget _buildSelectAllButton() {
    bool isFalseAvailable = selectedFlag.containsValue(false);
    if (isSelectionMode) {
      return FloatingActionButton.extended(
        label: Text(isFalseAvailable ? "Select All" : "Cancel"),
        backgroundColor: isFalseAvailable ? AppColors.PURPLE : AppColors.PINK,
        onPressed: isFalseAvailable
            ? _selectAll
            : () {
                _grocery_lists.forEach((f) => f.selected = false);
                Navigator.pop(context);
              },
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
                  title: Text('By list name', style: TextStyle(fontSize: 8)))),
        ],
        onSelected: (value) => setState(() {
          if (value == 1) {
            _grocery_lists.sort((a, b) => a.name.compareTo(b.name));
          }
        }),
      );
    }
  }

  void _selectAll() {
    bool isFalseAvailable = selectedFlag.containsValue(false);
    // If false will be available then it will select all the checkbox
    // If there will be no false then it will de-select all
    _grocery_lists..forEach((f) => f.selected = true);
    selectedFlag.updateAll((key, value) => isFalseAvailable);
    setState(() {
      isSelectionMode = selectedFlag.containsValue(true);
    });
  }

  Widget _buildDeleteButton() {
    bool isFalseAvailable = selectedFlag.containsValue(false);
    if (FromFavList) {
      return FloatingActionButton(
        child: const Icon(Icons.check),
        onPressed: _addToFavs,
        backgroundColor: AppColors.PURPLE,
        tooltip: 'add selected products',
        elevation: 20.0,
      );
    } else if (isSelectionMode) {
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
        tooltip: 'add list',
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
