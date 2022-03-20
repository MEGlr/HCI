import 'package:first_app/Screens/fav_add.dart';
import 'package:first_app/constants/appcolors.dart';
//import 'package:first_app/Screens/welcome_page.dart';
import 'package:first_app/Screens/add_product.dart';
import 'package:flutter/material.dart';
import 'package:first_app/buttons/form_field.dart';
import 'package:first_app/buttons/state_icon_button.dart';
import 'package:first_app/buttons/list_item.dart';
import 'package:first_app/Screens/list_item_add.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:first_app/dialogs/general_dialog.dart';
import 'package:first_app/Screens/number_picker.dart';
import 'package:first_app/Screens/fav_edit.dart';
import 'package:first_app/data_classes.dart';
import 'package:first_app/Screens/my_cup_list_1.dart';
import 'package:first_app/api/notification_api.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';

class fav_list extends StatefulWidget {
  final bool FromFavList;
  const fav_list({Key? key, this.FromFavList = false}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _fav_list_state();
}

class _fav_list_state extends State<fav_list> {
  bool isSelectionMode = false;
  Map<int, bool> selectedFlag = {};
  final _favorites = MyData.favorites;
  final _grocery_lists = MyData.grocery_lists;
  bool FromFavList = false;
  @override
  initState() {
    FromFavList = widget.FromFavList;
    isSelectionMode = FromFavList;
  }

  void _addNewEntry() async {
    final FavoriteItem? _newEntry = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => fav_add_page()));
    if (_newEntry != null) {
      await playLocalAsset1();
      _favorites.add(FavoriteItem(
        brand: _newEntry.brand,
        type: _newEntry.type,
        name: _newEntry.name,
        notify: _newEntry.notify,
        //selected: _newEntry.selected
      ));
      print(_newEntry.notify);
      //if (_newEntry.notify) {
      NotificationApi.showWeeklyNotification(
        id: (_favorites.length - 1),
        title:
            'Make sure you have (${_newEntry.name} (${_newEntry.brand}) in your Cupboards!',
        body: 'It is one of your favourite products!',
        payload: (_favorites.length - 1).toString(),
      );
      //}
      Navigator.pop(context);
    }

    setState(() {});
  }

  void _addFromCup() async {
    final List<FavoriteItem>? _newEntry =
        await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => my_cup_list(
                  FromFavList: true,
                )));
    if (_newEntry != null) {
      for (FavoriteItem i in _newEntry) _favorites.add(i);
    }
    Navigator.pop(context);
    await playLocalAsset1();
    setState(() {});
  }

  void _editEntry(index) async {
    bool was_notified = _favorites[index].notify;
    final FavoriteItem? _newEntry =
        await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => fav_edit_page(
                  index: index,
                )));
    if (_newEntry != null) {
      if (_newEntry.notify && !was_notified) {
        NotificationApi.showWeeklyNotification(
          id: index,
          title:
              'Make sure you have (${_newEntry.name} (${_newEntry.brand}) in your Cupboards!',
          body: 'It is one of your favourite products!',
          payload: (_favorites.length - 1).toString(),
        );
      } else if (was_notified && !_newEntry.notify) {
        NotificationApi.removeNotification(index);
      }
      _favorites[index].brand = _newEntry.brand;
      _favorites[index].type = _newEntry.type;
      _favorites[index].name = _newEntry.name;
      _favorites[index].notify = _newEntry.notify;
    }
    MyData.globally_selected = false;
    setState(() {});
  }

  Widget _buildProductList() {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(),
      padding: const EdgeInsets.all(16.0),
      itemCount: _favorites.length,
      itemBuilder: (context, index) {
        selectedFlag[index] = selectedFlag[index] ?? false;
        //bool isSelected = selectedFlag[index] ?? false;
        bool isSelected = _favorites[index].selected;

        return Slidable(
            startActionPane:
                ActionPane(motion: const ScrollMotion(), children: [
              SlidableAction(
                  onPressed: (BuildContext context) {
                    _favorites[index].notify = !_favorites[index].notify;
                  },
                  backgroundColor: AppColors.PINK,
                  foregroundColor: Colors.white,
                  icon: Icons.notification_important,
                  label: 'Notification')
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
                  title: Text(_favorites[index].name),
                  subtitle: Text(
                      _favorites[index].brand + ", " + _favorites[index].type),
                  leading: _buildSelectIcon(isSelected),
                )));
      },
    );
  }

  final _formKey = GlobalKey<FormState>();
  DateTime? _dateTime;
  final _nameController = TextEditingController();

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
      for (FavoriteItem i in _favorites) {
        int index = _favorites.indexWhere((element) => element == i);
        if (i.selected) NotificationApi.removeNotification(index);
      }
      _favorites.removeWhere((element) => element.selected == true);
      isSelectionMode = false;
      _favorites.forEach((f) => f.selected = false);
      await playLocalAsset2();
      setState(() {});
    }
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
      List<ListItem> temp = <ListItem>[];
      for (FavoriteItem i in _favorites) {
        if (i.selected) {
          //print('eeeee');
          temp.add(ListItem(
              brand: i.brand, name: i.name, type: i.type, quantity: '1'));
        }
      }
      final prod_entry = temp;

      print("lengrh");
      print(_favorites.length == 0);
      isSelectionMode = false;
      _favorites.forEach((f) => f.selected = false);

      setState(() {});
      Navigator.pop(context, prod_entry);
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
            }
            // context,
            // (route) =>
            //     route.settings.name ==
            //     '/cupList') //Navigator.of(context).push(MaterialPageRoute(builder: (context) => ).then((_){setState(() {

            ));
  }

  Widget add_to_list() {
    return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        backgroundColor: AppColors.PURPLE,
        title: const Text('Add a product to favorites',
            style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: _addFromCup,
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
              child: const Text('Load from Cupboards'),
            ),
            Padding(
                padding: EdgeInsets.only(top: 8),
                child: TextButton(
                  onPressed: _addNewEntry,
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
                  child: const Text('Create new'),
                )),
          ],
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
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: const Text('Favorite Products',
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
        _favorites[index].selected = !isSelected;
        if (FromFavList == false)
          isSelectionMode = selectedFlag.containsValue(true);
        print(_favorites.length);
        print(_favorites[index].selected);
      });
    } else {
      // Open Detail Page
      _editEntry(index);
    }
  }

  void onLongPress(bool isSelected, int index) {
    setState(() {
      selectedFlag[index] = false;
      isSelectionMode = selectedFlag.containsValue(true);
      // if (_favorites.length == 1) {
      //   isSelectionMode = true;
      // }
      isSelectionMode = true;
    });
  }

  Widget _buildSelectIcon(bool isSelected) {
    if (isSelectionMode) {
      return Icon(isSelected ? Icons.check_box : Icons.check_box_outline_blank,
          //color: Theme.of(context).primaryColor,
          color: isSelected ? AppColors.PURPLE : Colors.white);
    } else {
      return Icon(null);
    }
  }

  Widget _buildSelectAllButton() {
    bool isFalseAvailable = selectedFlag.containsValue(false);
    //bool isFalseAvailable = (_grocery_lists.where((element) => element.selected == false)).isEmpty;

    if (isSelectionMode) {
      return FloatingActionButton.extended(
          heroTag: "btn1",
          label: Text(isFalseAvailable ? "Select All" : "Cancel"),
          backgroundColor: isFalseAvailable ? AppColors.PURPLE : AppColors.PINK,
          onPressed: isFalseAvailable
              ? _selectAll
              : () {
                  _favorites.forEach((f) => f.selected = false);
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
            _favorites.sort((a, b) => a.name.compareTo(b.name));
          }
          if (value == 2) {
            _favorites.sort((a, b) => a.type.compareTo(b.type));
          }
          if (value == 3) {
            _favorites.sort((a, b) => a.brand.compareTo(b.brand));
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
    _favorites.forEach((f) => f.selected = true);

    setState(() {
      isSelectionMode = selectedFlag.containsValue(true);
    });
  }

  Widget _buildDeleteButton() {
    bool isFalseAvailable = selectedFlag.containsValue(false);
    if (FromFavList) {
      return FloatingActionButton(
        heroTag: "btn2",
        child: const Icon(Icons.check),
        onPressed: _addToFavs,
        backgroundColor: AppColors.PURPLE,
        tooltip: 'add selected products',
        elevation: 20.0,
      );
    } else if (isSelectionMode) {
      return FloatingActionButton(
        heroTag: "btn2",
        child: const Icon(Icons.delete),
        onPressed: _deleteTask,
        backgroundColor: AppColors.PURPLE,
        tooltip: 'delete',
        elevation: 20.0,
      );
    } else {
      return FloatingActionButton(
        heroTag: "btn2",
        child: const Icon(Icons.add),
        onPressed: () => showDialog<String>(
            context: context, builder: (BuildContext context) => add_to_list()),
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
