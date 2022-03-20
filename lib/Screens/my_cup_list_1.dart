import 'package:first_app/Screens/product_add.dart';
import 'package:first_app/constants/appcolors.dart';
import 'package:first_app/Screens/add_product.dart';
import 'package:flutter/material.dart';
import 'package:first_app/buttons/form_field.dart';
import 'package:first_app/buttons/state_icon_button.dart';
import 'package:first_app/buttons/list_item.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:first_app/dialogs/general_dialog.dart';
import 'package:first_app/Screens/number_picker.dart';
import 'package:first_app/Screens/product_edit.dart';
import 'package:first_app/data_classes.dart';
import 'package:first_app/api/notification_api.dart';
import 'package:first_app/Screens/product_edit.dart';
import 'package:intl/intl.dart';
import 'package:first_app/Screens/welcome_page.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';

class my_cup_list extends StatefulWidget {
  final bool FromFavList;
  const my_cup_list({Key? key, this.FromFavList = false}) : super(key: key);

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
  //bool isSelectionMode = false;
  bool isSelectionMode = MyData.isSelectionMode;
  Map<int, bool> selectedFlag = {};
  final _products = MyData.products;
  final _favorites = MyData.favorites;
  bool FromFavList = false;

  @override
  void initState() {
    super.initState();
    FromFavList = widget.FromFavList;
    isSelectionMode = FromFavList;
    MyData.globally_selected = false;
    print(MyData.globally_selected);

    NotificationApi.init();
    //listenNotifications();
  }

  void listenNotifications() {
    NotificationApi.onNotifications.stream.listen(onClickedNotification);
  }

  void onClickedNotification(String? payload) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => WelcomeScreen()));

  void _addNewEntry() async {
    final ProductItem? _newEntry = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => product_add_page()));

    if (_newEntry != null) {
      await playLocalAsset1();
      _products.add(ProductItem(
        expired: _newEntry.expired,
        brand: _newEntry.brand,
        type: _newEntry.type,
        quantity: _newEntry.quantity,
        name: _newEntry.name,
        isFav: _newEntry.isFav,
        // has_expired:
        //     DateTime.parse(_newEntry.expired).isBefore(DateTime.now())
      ));

      if (_newEntry.isFav == true) {
        _favorites.add(FavoriteItem(
            name: _newEntry.name,
            brand: _newEntry.brand,
            type: _newEntry.type));
      }

      NotificationApi.showScheduledNotification(
        id: 0,
        title: '${_newEntry.name} (${_newEntry.brand}) has expired',
        body:
            'Expired products appear grey in my cupboards list\n Remember to throw them away!',
        payload: (_products.length - 1).toString(),
        scheduledDate: DateTime.now().add(Duration(seconds: 2)),

        //DateTime.parse(_newEntry.expired),
      );
    }
    setState(() {});
  }

  void _editEntry(index) async {
    final ProductItem? _newEntry =
        await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => product_edit_page(
                  index: index,
                )));
    if (_newEntry != null) {
      if (_newEntry.isFav == false) {
        _favorites.removeWhere((element) =>
            (element.name == _products[index].name &&
                element.brand == _products[index].brand));
      } else {
        int findex = _favorites.indexWhere((element) =>
            (element.name == _products[index].name &&
                element.brand == _products[index].brand));
        if (findex > 0) {
          _favorites[findex].brand = _newEntry.brand;
          _favorites[findex].type = _newEntry.type;
          _favorites[findex].name = _newEntry.name;
        } else {
          _favorites.add(FavoriteItem(
            brand: _newEntry.brand,
            type: _newEntry.type,
            name: _newEntry.name,
            //selected: _newEntry.selected
          ));
        }
      }
      _products[index].expired = _newEntry.expired;
      _products[index].brand = _newEntry.brand;
      _products[index].type = _newEntry.type;
      _products[index].quantity = _newEntry.quantity;
      _products[index].name = _newEntry.name;
      _products[index].isFav = _newEntry.isFav;
    }
    MyData.globally_selected = false;
    setState(() {});
  }

  Widget _buildProductList() {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(),
      padding: const EdgeInsets.all(16.0),
      itemCount: _products.length,
      itemBuilder: (context, index) {
        selectedFlag[index] = selectedFlag[index] ?? false;
        //bool isSelected = selectedFlag[index] ?? false;
        bool isSelected = _products[index].selected;
        bool isExpired = (_products[index].expired)
                .compareTo(DateFormat("dd-MM-yyyy").format(DateTime.now())) ==
            -1;
        return Slidable(
            startActionPane:
                ActionPane(motion: const ScrollMotion(), children: [
              SlidableAction(
                  onPressed: (BuildContext context) {
                    _products[index].isFav = !_products[index].isFav;
                  },
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
                  tileColor: isSelected
                      ? AppColors.VERY_LIGHT_BLUE
                      : (isExpired ? AppColors.GREY : AppColors.BLUE),
                  onLongPress: () => onLongPress(isSelected, index),
                  onTap: () => onTap(isSelected, index),
                  title: Text(_products[index].name),
                  subtitle: Text(_products[index].brand +
                      ", " +
                      _products[index].type +
                      ", " +
                      _products[index].expired),
                  leading: _buildSelectIcon(
                      isSelected, _products[index].quantity, isExpired),
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
      isSelectionMode = false;
      _products.forEach((f) => f.selected = false);
      playLocalAsset2();
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
        if (FromFavList == false)
          isSelectionMode = selectedFlag.containsValue(true);
        print(_products.length);
      });
    } else {
      // // Open Detail Page
      // Navigator.of(
      //   context,
      // ).push(MaterialPageRoute(
      //     builder: (
      //   context,
      // ) =>
      //         product_edit_page(index: index)));
      _editEntry(index);
    }
  }

  void onLongPress(bool isSelected, int index) {
    print("here");
    setState(() {
      selectedFlag[index] = false;

      // isSelectionMode = selectedFlag.containsValue(true);
      isSelectionMode = true;
      //if (_products.length == 1) isSelectionMode = true;
    });
  }

  Widget _buildSelectIcon(bool isSelected, String quant, bool isExpired) {
    if (isSelectionMode) {
      return Icon(isSelected ? Icons.check_box : Icons.check_box_outline_blank,
          //color: Theme.of(context).primaryColor,
          color: isSelected ? AppColors.PURPLE : Colors.white);
    } else {
      return CircleAvatar(
          radius: 16,
          backgroundColor: AppColors.LIGHT_BLUE,
          child: CircleAvatar(
              child: Text(quant),
              radius: 14,
              backgroundColor: isExpired ? AppColors.GREY : AppColors.BLUE));
    }
  }

  Widget _buildSelectAllButton() {
    bool isFalseAvailable = selectedFlag.containsValue(false);
    if (isSelectionMode) {
      return FloatingActionButton.extended(
          heroTag: "btn2",
          label: Text(isFalseAvailable ? "Select All" : "Cancel"),
          backgroundColor: isFalseAvailable ? AppColors.PURPLE : AppColors.PINK,
          onPressed: isFalseAvailable
              ? _selectAll
              : () {
                  _products.forEach((f) => f.selected = false);
                  Navigator.pop(context);
                });
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
                  title: Text('By product name'
                      //, style: TextStyle(fontSize: 8)
                      ))),
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
    _products.forEach((f) => f.selected = true);
    selectedFlag.updateAll((key, value) => isFalseAvailable);
    setState(() {
      isSelectionMode = selectedFlag.containsValue(true);
    });
  }

  void _addToFavs() async {
    bool? _delEntry = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) => GenDisplay(
              maintitle: "Add all selected items to list? ",
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
      List<FavoriteItem> temp = <FavoriteItem>[];
      for (ProductItem i in _products) {
        if (i.selected) {
          print('eeeee');
          temp.add(FavoriteItem(brand: i.brand, name: i.name, type: i.type));
        }
      }
      final prod_entry = temp;

      print("lengrh");
      print(_favorites.length == 0);
      isSelectionMode = false;
      _products.forEach((f) => f.selected = false);
      setState(() {});
      Navigator.pop(context, prod_entry);
    }
  }

  Widget _buildDeleteButton() {
    bool isFalseAvailable = selectedFlag.containsValue(false);
    if (FromFavList) {
      return FloatingActionButton(
        heroTag: "btn1",
        child: const Icon(Icons.check),
        onPressed: _addToFavs,
        backgroundColor: AppColors.PURPLE,
        tooltip: 'add selected products',
        elevation: 20.0,
      );
    } else if (isSelectionMode) {
      return FloatingActionButton(
        heroTag: "btn1",
        child: const Icon(Icons.delete),
        onPressed: _deleteTask,
        backgroundColor: AppColors.PURPLE,
        tooltip: 'delete',
        elevation: 20.0,
      );
    } else {
      return FloatingActionButton(
        heroTag: "btn1",
        child: const Icon(Icons.add),
        onPressed:
            //() {
            //   NotificationApi.showScheduledNotification(
            //     title: ' has expired',
            //     body: 'Click to remove it',
            //     scheduledDate: DateTime.now().add(Duration(seconds: 5)),
            //     //DateTime.parse(_newEntry.expired),
            //   );
            //   final snackBar = SnackBar(content: Text('heeeee'));
            //   ScaffoldMessenger.of(context)..showSnackBar(snackBar);
            // },
            _addNewEntry,
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

  Future<AudioPlayer> playLocalAsset1() async {
    AudioCache cache = new AudioCache();
    print("okkkkkk");
    return await cache
        .play("audio/mixkit-quick-win-video-game-notification-269.wav");
  }

  Future<AudioPlayer> playLocalAsset2() async {
    AudioCache cache = new AudioCache();
    print("okkkkkk");
    return await cache
        .play("audio/mixkit-negative-tone-interface-tap-2569.wav");
  }
}
