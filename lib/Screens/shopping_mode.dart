import 'package:first_app/Screens/my_grocery_lists.dart';
import 'package:first_app/constants/appcolors.dart';
import 'package:first_app/Screens/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:first_app/Screens/my_shopping_cart.dart';
import 'package:first_app/buttons/cam_mic.dart';
import 'package:first_app/data_classes.dart';
import 'package:first_app/Screens/list_item_add.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:first_app/Screens/fav_list.dart';
import 'package:first_app/dialogs/general_dialog.dart';
import 'package:first_app/buttons/cam_mic.dart';
import 'package:first_app/ocr_page.dart';

class shopping_mode extends StatefulWidget {
  const shopping_mode({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _shopping_mode_state();
}

class _shopping_mode_state extends State<shopping_mode> {
  List<ListItem> _products = MyData.shopping; //= <ListItem>[];

  void _addNewEntry() async {
    final ListItem? _newEntry =
        await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => item_add_page(
                  FromFavList: true,
                )));
    Navigator.pop(context);

    if (_newEntry != null) {
      _products.add(ListItem(
          brand: _newEntry.brand,
          type: _newEntry.type,
          name: _newEntry.name,
          quantity: _newEntry.quantity));

      for (ProductItem j in MyData.products) {
        if (_newEntry.name == j.name && _newEntry.brand == j.brand)
          _showDialog_exists(_products.last);
      }
    }
    setState(() {});
  }

  void _addFavEntry() async {
    final List<ListItem>? _newEntry =
        await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => fav_list(
                  FromFavList: true,
                )));
    Navigator.pop(context);
    if (_newEntry != null) {
      for (ListItem i in _newEntry)
        _products.add(ListItem(
            brand: i.brand, type: i.type, name: i.name, quantity: i.quantity));

      List<ListItem> temp = <ListItem>[];
      for (ListItem i in _newEntry) {
        for (ProductItem j in MyData.products) {
          if (i.name == j.name && i.brand == j.brand) temp.add(i);
        }
      }
      //int count = temp.length;
      for (ListItem i in temp) {
        //  count--;
        _showDialog_exists(i);
      }
      setState(() {});
    }
  }

  void _addListEntry() async {
    final List<ListItem>? _newEntry =
        await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => my_groceries(
                  FromFavList: true,
                )));
    //Navigator.pop(context);
    if (_newEntry != null) {
      for (ListItem i in _newEntry)
        _products.add(ListItem(
            brand: i.brand, type: i.type, name: i.name, quantity: i.quantity));

      List<ListItem> temp = <ListItem>[];
      for (ListItem i in _newEntry) {
        for (ProductItem j in MyData.products) {
          if (i.name == j.name && i.brand == j.brand) temp.add(i);
        }
      }
      // int count = temp.length;
      for (ListItem i in temp) {
        //  count--;
        _showDialog_exists(i);
      }
      setState(() {});
    }
  }

  Future<void> _fill_dateDialog(int index) async {
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
        MyData.current.add(ProductItem(
            name: _products[index].name,
            brand: _products[index].brand,
            quantity: _products[index].quantity,
            type: _products[index].type,
            isFav: false,
            expired: result.toString()));
        _products.removeAt(index);
      });
    }
  }

  Future<void> _showDialog_exists(ListItem i) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) => GenDisplay(
              maintitle:
                  "You added to your cart product: ${i.name} (of brand : ${i.brand}), \n which you already seem to have in your Cupboards! \n Are you sure you want to proceed with buying it?",
              color: AppColors.BLUE,
              left: "Discard product",
              right: "Keep",
              edges: 5,
              createPageL: () {
                _products.remove(i);
                Navigator.pop(context);

                setState(() {});
              }, // Navigator.pop(context);},
              createPageR: () => {Navigator.pop(context)},
            ));
  }

  Future<void> _showlertDialog_unchecked() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) => GenDisplay(
              maintitle:
                  "You haven't checked all items from your list!\nAre you sure you want to exit shopping mode without them?",
              color: AppColors.BLUE,
              left: "No, hold on",
              right: "Yes",
              edges: 5,
              createPageL: () => Navigator.pop(context),
              createPageR: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => shopping_cart()));
              }
              //   }
              ,
            ));
  }

  Widget _buildProductList() {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(),
      padding: const EdgeInsets.all(16.0),
      itemCount: _products.length,
      itemBuilder: (context, index) {
        //selectedFlag[index] = selectedFlag[index] ?? false;
        //bool isSelected = selectedFlag[index] ?? false;
        //bool isSelected = _products[index].selected;

        return Dismissible(
            key: ValueKey<ListItem>(_products[index]),
            background: Container(
              color: AppColors.LIGHT_PURPLE,
            ),
            onDismissed: (DismissDirection direction) {
              setState(() {
                _products.removeAt(index);
              });
            },
            child: InkWell(
                onTap: () {},
                child: ListTile(
                  tileColor:
                      //isSelected ?
                      //   AppColors.VERY_LIGHT_BLUE:
                      AppColors.BLUE,
                  onLongPress: () => _fill_dateDialog(index),
                  // onTap: () => onTap(isSelected, index),
                  title: Text(_products[index].name),
                  subtitle: Text(
                      _products[index].brand + ", " + _products[index].type),
                  leading: CircleAvatar(
                      radius: 16,
                      backgroundColor: AppColors.LIGHT_BLUE,
                      child: CircleAvatar(
                          child: Text(_products[index].quantity),
                          radius: 14,
                          backgroundColor: AppColors.BLUE)),
                )));
      },
    );
  }

  void _show_cam_text() async {
    final String result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => OCRPage(
              twice: false,
            )));
    int index = -1;
    for (ListItem i in _products) {
      if (i.name == result) {
        int curr = _products.indexWhere((element) => element == i);
        if (curr >= 0) index = curr;
      }
    }
    if (index < 0) {
    } else {
      _fill_dateDialog(index);
    }
  }

  @override
  void initState() {
    MyData.globally_selected = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            title: const Text('Things to buy',
                textAlign: TextAlign.left,
                style: TextStyle(fontFamily: "Rationale")),
            leading: IconButton(
              icon: const Icon(Icons.home_sharp),
              tooltip: 'back to home page',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                tooltip: 'Shopping Cart',
                onPressed: () {
                  bool temp = false;
                  for (ListItem i in _products)
                    if (i.selected == false) temp = true;
                  if (temp == true) {
                    _showlertDialog_unchecked();
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => shopping_cart()));
                  }
                },
              )
            ],
            backgroundColor: AppColors.LIGHT_BLUE),
//        body: _buildProductList(),
        body: Column(children: [
          Container(
              color: AppColors.VERY_LIGHT_BLUE,
              child: Container(
                  color: AppColors.BLUE,
                  child: Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                      child: Row(
                        children: [
                          SizedBox(width: 20),
                          DottedBorder(
                              borderType: BorderType.RRect,
                              radius: Radius.circular(15),
                              //padding: EdgeInsets.all(6),
                              color: AppColors.LIGHT_BLUE,
                              child: FlatButton(
                                onPressed: _addListEntry,
                                //() => showDialog<String>(
                                //     context: context,
                                //     builder: (BuildContext context) =>
                                //         cam_and_mic()),
                                child: Text('Load Grocery List',
                                    style: TextStyle(
                                        color:
                                            Color.fromRGBO(233, 233, 233, 1))),
                                textColor: Colors.white,
                              )),
                          DottedBorder(
                              borderType: BorderType.Circle,
                              //radius: Radius.circular(15),
                              //padding: EdgeInsets.all(6),
                              color: AppColors.LIGHT_BLUE,
                              child: FlatButton(
                                onPressed: () => showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        add_to_list()),
                                child: Icon(Icons.add,
                                    color: Color.fromRGBO(233, 233, 233, 1)),
                                textColor: Colors.white,
                              )),
                        ],
                      )))),
          Flexible(
              fit: FlexFit.tight,
              child: SizedBox(
                  height: 200.0,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const Divider(),
                    padding: const EdgeInsets.all(16.0),
                    itemCount: _products.length,
                    itemBuilder: (context, index) {
                      //selectedFlag[index] = selectedFlag[index] ?? false;
                      //bool isSelected = selectedFlag[index] ?? false;
                      //bool isSelected = _products[index].selected;

                      return Dismissible(
                          key: ValueKey<ListItem>(_products[index]),
                          background: Container(
                            color: AppColors.LIGHT_PURPLE,
                          ),
                          onDismissed: (DismissDirection direction) {
                            setState(() {
                              _products.removeAt(index);
                            });
                          },
                          child: InkWell(
                              onTap: () {},
                              child: ListTile(
                                tileColor:
                                    //isSelected ?
                                    //   AppColors.VERY_LIGHT_BLUE:
                                    AppColors.BLUE,
                                onLongPress: () => _fill_dateDialog(index),
                                // onTap: () => onTap(isSelected, index),
                                title: Text(_products[index].name),
                                subtitle: Text(_products[index].brand +
                                    ", " +
                                    _products[index].type),
                                leading: CircleAvatar(
                                    radius: 16,
                                    backgroundColor: AppColors.LIGHT_BLUE,
                                    child: CircleAvatar(
                                        child: Text(_products[index].quantity),
                                        radius: 14,
                                        backgroundColor: AppColors.BLUE)),
                              )));
                    },
                  )))
        ]),
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
            //SizedBox(height: 20),
            Container(
                // alignment: Alignment.bottomRight,
                padding: EdgeInsets.only(left: 30.0, bottom: 1.0),
                child: CameraButton()),
            Container(
                //alignment: Alignment.bottomLeft,
                margin: EdgeInsets.all(10),
                child: ShoppingModeButton(context)),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startDocked);
  }

  Widget ShoppingModeButton(context) {
    return InkWell(
      child: Container(
          child: Image.asset(
        'assets/images/shopping_mode_on.png',
        height: 130,
        alignment: Alignment.bottomRight,
      )),
      onTap: () => showDialog<String>(
          context: context, builder: (BuildContext context) => help_pop_up()),
    );
  }

  Widget CameraButton() {
    return SizedBox(
        height: 90.0,
        width: 90.0,
        child: FittedBox(
            child: FloatingActionButton(
                backgroundColor: AppColors.PINK,
                onPressed: _show_cam_text,
                child: Icon(Icons.camera, color: Colors.white))));
  }

  Widget add_to_list() {
    return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        backgroundColor: AppColors.PURPLE,
        title: const Text('Add a product to your list',
            style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: _addNewEntry,
              style: ButtonStyle(
                  padding:
                      MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(20)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(AppColors.PINK),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: AppColors.PINK)))),
              child: const Text('Add product manually'),
            ),
            Padding(
                padding: EdgeInsets.only(top: 8),
                child: TextButton(
                  onPressed: _addFavEntry,
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.all(20)),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          AppColors.LIGHT_BLUE),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: AppColors.LIGHT_BLUE)))),
                  child: const Text('Load from Favourites'),
                )),
          ],
        ));
  }

  Widget help_pop_up() {
    return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        backgroundColor: AppColors.MOODY_PINK,
        title: const Text('YOU ARE IN SHOPPING MODE!',
            textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
        content: SingleChildScrollView(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('This is what you can do here:',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white)),
            TextButton(
                onPressed: () {},
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(20)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(AppColors.PINK),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: AppColors.PINK)))),
                child: Expanded(
                    child: Text(
                  'Add things to your shopping list to remember to buy them!\nUse the buttons to load from your grocery lists,your faves or to add products manually!',
                  textAlign: TextAlign.center,
                ))),
            TextButton(
                onPressed: () {},
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(20)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(AppColors.MOODY_PINK),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side:
                                BorderSide(color: AppColors.VERY_LIGHT_BLUE)))),
                child: Column(children: [
                  TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.all(20)),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppColors.LIGHT_BLUE),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          color: AppColors.LIGHT_BLUE)))),
                      child: Text(
                        'Use the Camera Button at the bottom left of your screen to scan the name of the product you are going to buy',
                        textAlign: TextAlign.center,
                      )),
                  TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.all(20)),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppColors.LIGHT_PURPLE),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          color: AppColors.LIGHT_PURPLE)))),
                      child: Text(
                        'or\n Long press on one of the items of your list to move to your shopping cart',
                        textAlign: TextAlign.center,
                      )),
                  TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.all(20)),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppColors.LIGHT_BLUE),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          color: AppColors.LIGHT_BLUE)))),
                      child: Text(
                        'Swipe Right on the item you want to remove from your current shopping list to delete it',
                        textAlign: TextAlign.center,
                      ))
                ])),
            TextButton(
                onPressed: () {},
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(20)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(AppColors.BLUE),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: AppColors.BLUE)))),
                child: Expanded(
                    child: Text(
                  'Tap on the shopping cart icon to review it and eventually add the products to your cupboards',
                  textAlign: TextAlign.center,
                ))),
          ],
        )));
  }
}
