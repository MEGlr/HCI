import 'package:flutter/material.dart';
import 'package:first_app/buttons/general_button.dart';
import 'package:first_app/constants/appcolors.dart';
import 'package:first_app/Screens/my_cup_list_1.dart';
import 'package:first_app/Screens/my_grocery_lists.dart';
import 'package:first_app/Screens/fav_list.dart';
import 'package:first_app/add_form.dart';
import 'package:first_app/Screens/shopping_mode.dart';
import 'package:first_app/data_classes.dart';

class WelcomeScreen extends StatefulWidget {
  final bool Updates;
  const WelcomeScreen({Key? key, this.Updates = false}) : super(key: key);
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool Updates = false;
  @override
  initState() {
    Updates = widget.Updates;
    setState(() {});
    print(MyData.globally_selected);
  }

  @override
  void callback() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.VERY_LIGHT_BLUE,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: const Text('SMART\n CUPBOARDS',
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: "Rationale")),
          centerTitle: true,
          backgroundColor: AppColors.BLUE),
      body: Center(
          child: Flexible(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
            SizedBox(height: 80),
            Visibility(
                visible: MyData.globally_selected,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Image.asset(
                    'images/Exclamation.png',
                    color: AppColors.BLUE,
                  ),
                  SizedBox(width: 5),
                  Text(
                    'changes to cupboards',
                    style: TextStyle(
                        color: AppColors.BLUE, fontFamily: 'Rationale'),
                  )
                ])),
            RaisedButton(
              child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Text("My Cupboards",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontFamily: "Rationale"))),
              color: AppColors.PINK,
              onPressed: () {
                Navigator.of(context)
                    .push(
                        MaterialPageRoute(builder: (context) => my_cup_list()))
                    .then((_) => setState(() {}));
              },
            ),
            RaisedButton(
              child: Padding(
                  padding: const EdgeInsets.all(33),
                  child: Text("My Favourite\n Products",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontFamily: "Rationale"))),
              color: AppColors.BLUE,
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => fav_list()))
                    .then((_) => setState(() {}));
              },
            ),
            RaisedButton(
              child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Text("My Grocery Lists",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontFamily: "Rationale"))),
              color: AppColors.LIGHT_BLUE,
              onPressed: () {
                Navigator.of(context)
                    .push(
                        MaterialPageRoute(builder: (context) => my_groceries()))
                    .then((_) => setState(() {}));
              },
            ),
            // buttonWidget(
            //     context, "My Favourite\n Products", AppColors.BLUE, fav_list()),
            // buttonWidget(context, "My Grocery Lists", AppColors.LIGHT_BLUE,
            //     my_groceries()),
            SizedBox(height: 80)
          ]))),

      bottomNavigationBar: BottomAppBar(
          child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                bluetoothButton(),
                ShoppingModeButton(context)
              ]),
          color: AppColors.VERY_LIGHT_BLUE,
          elevation: 0),
      //floatingActionButton: ShoppingModeButton(context),
      //floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  Widget buttonWidget(context, String label, colorSTR, route) {
    return ButtonTheme(
      minWidth: 200.0,
      height: 80,
      child: RaisedButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => route));
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          color: colorSTR,
          elevation: 20.0,
          //padding: EdgeInsets.all(25),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style:
                const TextStyle(color: Colors.white, fontFamily: 'MyRationale'),
          )),
    );
  }

  Widget ShoppingModeButton(context) {
    return InkWell(
      child: Container(
          child: Image.asset(
        'images/Button.png',
        height: 80,
        alignment: Alignment.bottomRight,
      )),
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => shopping_mode()))
            .then((_) => setState(() {}));
      },
    );
  }

  Widget bluetoothButton() {
    return MaterialButton(
      onPressed: () {},
      color: AppColors.LIGHT_PURPLE,
      textColor: Colors.white,
      child: Icon(
        Icons.bluetooth,
        size: 24,
      ),
      padding: EdgeInsets.all(16),
      shape: CircleBorder(),
    );
  }
}
