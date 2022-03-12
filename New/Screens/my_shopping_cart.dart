import 'package:first_app/constants/appcolors.dart';
import 'package:first_app/Screens/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class shopping_cart extends StatefulWidget {
  const shopping_cart({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _shopping_cart_state();
}

class _shopping_cart_state extends State<shopping_cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('My Shopping Cart',
                textAlign: TextAlign.left,
                style: TextStyle(fontFamily: "Rationale")),
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                tooltip: 'back main page',
                onPressed: () {
                  Navigator.pop(context);
                }),
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
                child: ShoppingModeButton(context)),
            Container(
                //alignment: Alignment.bottomLeft,
                margin: EdgeInsets.all(10),
                child: AddtoCupboardsButton()),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked);
  }

  Widget ShoppingModeButton(context) {
    return InkWell(
        child: Container(
            child: Image.asset(
          'images/shopping_mode_on_rev.png',
          height: 90,
          alignment: Alignment.bottomLeft,
        )),
        onTap: null);
  }

  Widget AddtoCupboardsButton() {
    return FloatingActionButton.extended(
      icon: const Icon(Icons.shopping_bag),
      label: const Text('Add to cupboards'),
      onPressed: () {},
      backgroundColor: AppColors.PINK,
      tooltip: 'Add to cupboards',
      elevation: 20.0,
    );
  }
}
