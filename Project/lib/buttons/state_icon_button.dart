import 'package:flutter/material.dart';
//import 'package:first_app';
import 'package:first_app/constants/appcolors.dart';

class state_icon_button extends StatefulWidget {
  final String image_on;
  final String image_off;
  final Color color;
  final Color color_back;
  final String data;
  state_icon_button(
      {Key? key,
      required this.image_on,
      required this.image_off,
      required this.color,
      this.data = '',
      required this.color_back})
      : super(key: key); //Ti einai to key

  @override
  _state_icon_buttonState createState() => _state_icon_buttonState();
}

class _state_icon_buttonState extends State<state_icon_button> {
  bool isSelected = false;
  String image_on = '';
  String image_off = '';
  Color color = AppColors.PURPLE;
  Color color_back = Colors.black;
  String data = '';
  @override
  void initState() {
    color = widget.color;
    image_on = widget.image_on;
    image_off = widget.image_off;
    color_back = widget.color_back;
    data = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    // bool newSelected = isSelected; //dk why needed
    return CircleAvatar(
        backgroundColor: color_back,
        child: IconButton(
          tooltip: data,
          icon: Image.asset(isSelected ? image_off : image_on,
              color: isSelected ? color : Colors.white),
          onPressed: () => onPress(isSelected),
        ));
  }

  void onPress(bool giveSelected) {
    setState(() {
      isSelected = !giveSelected;
    });
  }
}
