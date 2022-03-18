import 'package:first_app/constants/appcolors.dart';
import 'package:first_app/Screens/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:first_app/dashed_line.dart';
import 'package:first_app/Screens/prod_to_list.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:first_app/buttons/form_field.dart';
import 'package:first_app/Screens/add_product.dart';
import 'package:first_app/data_classes.dart';
import 'package:first_app/Screens/product_add.dart';
import 'package:first_app/Screens/list_item_add.dart';
import 'package:first_app/dialogs/general_dialog.dart';
import 'package:first_app/Screens/fav_list.dart';

class edit_list extends StatefulWidget {
  final int index;
  const edit_list({Key? key, required this.index}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _edit_list_state();
}

class _edit_list_state extends State<edit_list> {
  //bool isSelectionMode = false;
  Map<int, bool> selectedFlag = {};
  final _grocery_lists = MyData.grocery_lists;
  List<ListItem> _products = <ListItem>[];
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int index = 0;
  @override
  void initState() {
    index = widget.index;
    _nameController.text = _grocery_lists[index].name;
    _products = _grocery_lists[index].products;
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

  void _addFavEntry() async {
    final List<ListItem>? _newEntry =
        await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => fav_list(
                  FromFavList: true,
                )));
    //Navigator.pop(context);
    if (_newEntry != null) {
      _products = _products + _newEntry;

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Edit List',
                textAlign: TextAlign.left,
                style: TextStyle(fontFamily: "Rationale")),
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                tooltip: 'back to main page',
                onPressed: _showAlertDialog),
            backgroundColor: AppColors.BLUE),
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
                    heroTag: "btn1",
                    icon: const Icon(Icons.download),
                    label: const Padding(
                      padding:
                          EdgeInsets.all(15), //apply padding to all four sides
                      child: Text("Load from\n Favourites"),
                    ),
                    onPressed: _addFavEntry,
                    backgroundColor: AppColors.BLUE,
                    tooltip: 'load',
                    elevation: 20.0,
                    shape: StadiumBorder(
                        side: BorderSide(
                            color: AppColors.VERY_LIGHT_BLUE, width: 2)))),
            Container(
              //alignment: Alignment.bottomLeft,
              margin: EdgeInsets.all(17),
              child: Container(
                height: 80.0,
                width: 80.0,
                child: FittedBox(
                    child: FloatingActionButton(
                  heroTag: "btn2",
                  child: const Icon(Icons.check),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final entry = GroceryList(
                          name: _nameController.text, products: _products);
                      Navigator.pop(context, entry);
                    }

                    _nameController.text = "";
                    //_products. = <ProductItem>[];
                  },
                  backgroundColor: AppColors.PINK,
                  tooltip: 'add product',
                  elevation: 20.0,
                )),
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        body: Center(
            child: Container(
                color: AppColors.VERY_LIGHT_BLUE,
                child: Column(children: <Widget>[
                  Form(
                      key: _formKey,
                      child: Form_Field(
                        color: AppColors.PURPLE,
                        controller: _nameController,
                        maintitle: 'List Name',
                        edges: 10,
                        createPage: () => add_product(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'field required';
                          }
                          return null;
                        },
                      )),
                  Stack(children: <Widget>[
                    const MySeparator(color: Colors.white),
                    MaterialButton(
                      onPressed: _addNewEntry,
                      color: AppColors.LIGHT_PURPLE,
                      textColor: Colors.white,
                      child: Icon(
                        Icons.add,
                        size: 24,
                      ),
                      padding: EdgeInsets.all(16),
                      shape: CircleBorder(),
                    )
                  ]),
                  Expanded(child: _buildProductList())
                ]))));
  }

  void _addNewEntry() async {
    final ListItem? _newEntry = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => item_add_page()));
    print(_newEntry);
    if (_newEntry != null) {
      _products.add(ListItem(
          // isFav: MyData.globally_selected,
          brand: _newEntry.brand,
          type: _newEntry.type,
          quantity: _newEntry.quantity,
          // expired: _newEntry.expired,
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

        return Dismissible(
            key: ValueKey<ListItem>(_products[index]),
            background: Container(
              color: AppColors.PINK,
            ),
            onDismissed: (DismissDirection direction) {
              setState(() {
                _products.removeAt(index);
              });
            },
            child: Container(
                color: isSelected ? AppColors.MOODY_PINK : AppColors.LIGHT_BLUE,
                child: InkWell(
                    child: ListTile(
                  //onLongPress: () => onLongPress(isSelected, index),
                  onTap: () => onTap(isSelected, index),
                  leading: _buildSelectIcon(isSelected),

                  title: Text(_products[index].name),
                  subtitle: Text(
                      _products[index].brand + ", " + _products[index].type),
                ))));
      },
    );
  }

  void onTap(bool isSelected, int index) {
    setState(() {
      selectedFlag[index] = !isSelected;
      _products[index].selected = !isSelected;
      print(index);
      print(_products[index].selected);
      //isSelectionMode = selectedFlag.containsValue(true);
    });
  }

  Widget _buildSelectIcon(bool isSelected) {
    return Icon(isSelected ? Icons.check_box : Icons.check_box_outline_blank,
        //color: Theme.of(context).primaryColor,
        color: isSelected ? AppColors.PURPLE : Colors.white);
  }
}
