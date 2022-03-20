import 'package:flutter/material.dart';
//import 'package:first_app';
import 'package:first_app/constants/appcolors.dart';
import 'package:first_app/Screens/my_cup_list.dart';

class Product extends StatefulWidget {
  final String maintitle;
  final String subtitle;

  Product({Key? key, required this.maintitle, required this.subtitle})
      : super(key: key);

  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  bool isSelectionMode = false;
  bool isSelected = false;
  Map<String, String> data = {"maintitle": "", "subtitle": ""};

  @override
  void initState() {
    data = {"maintitle": widget.maintitle, "subtitle": widget.subtitle};
  }

  @override
  Widget build(BuildContext context) {
    // bool newSelected = isSelected; //dk why needed
    return ListTile(
      tileColor: isSelected ? AppColors.GREY : AppColors.BLUE,
      onLongPress: () => onLongPress(),
      onTap: () => onTap(isSelected),
      title: Text("${data["maintitle"]}"),
      subtitle: Text("${data['subtitle']}"),
      leading: _buildSelectIcon(isSelected, data),
    );
  }

  void onLongPress() {
    setState(() {
      isSelectionMode = true;
    });
  }

  Widget _buildSelectIcon(bool isSelected, Map data) {
    if (isSelectionMode) {
      return Icon(
        isSelected ? Icons.check_box : Icons.check_box_outline_blank,
        color: Colors.white,
      );
    } else {
      return const Icon(null);
    }
  }

  void onTap(bool giveSelected) {
    print(isSelectionMode);
    if (isSelectionMode) {
      setState(() {
        isSelected = !giveSelected;
      });
      // _products[]
    } else {
      print("Hehe");
    }
  }
}
