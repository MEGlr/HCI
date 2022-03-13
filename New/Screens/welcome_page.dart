import 'package:flutter/material.dart';
import 'package:first_app/buttons/general_button.dart';
import 'package:first_app/constants/appcolors.dart';
import 'package:first_app/Screens/my_cupboards_pages/my_cup_list_1.dart';
import 'package:first_app/Screens/grocery_list_pages/create_a_list.dart';
import 'package:first_app/Screens/my_fave_products.dart';
import 'package:first_app/add_form.dart';
import 'package:first_app/Screens/shopping_mode_pages/shopping_mode.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('SMART\n CUPBOARDS',
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: "Rationale")),
          centerTitle: true,
          backgroundColor: AppColors.BLUE),
      body: Container(
          color: AppColors.VERY_LIGHT_BLUE,
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Flexible(fit: FlexFit.tight, child: SizedBox()),
                Container(
                  alignment: Alignment.center,
                  color: AppColors.VERY_LIGHT_BLUE,
                  child: Container(
                    height: 200.0,
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          buttonWidget(context, "My Cupboards", AppColors.PINK,
                              my_cup_list()),
                          buttonWidget(context, "My Favourite\n Products",
                              AppColors.BLUE, my_faves_list()),
                          buttonWidget(context, "My Grocery Lists",
                              AppColors.LIGHT_BLUE, create_list()),
                          // bluetoothButton()
                        ]),
                  ),
                ),
                const Flexible(fit: FlexFit.tight, child: SizedBox()),
              ])),
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
      height: 50.0,
      child: RaisedButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => route));
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          color: colorSTR,
          elevation: 20.0,
          padding: EdgeInsets.all(25),
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
        height: 90,
        alignment: Alignment.bottomRight,
      )),
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => shopping_mode()));
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
