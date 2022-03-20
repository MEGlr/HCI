import 'package:flutter/material.dart';
import 'package:first_app/buttons/general_button.dart';
import 'package:first_app/constants/appcolors.dart';
import 'package:first_app/Screens/my_cup_list_1.dart';
import 'package:first_app/Screens/my_grocery_lists.dart';
import 'package:first_app/Screens/fav_list.dart';
import 'package:first_app/add_form.dart';
import 'package:first_app/Screens/shopping_mode.dart';
import 'package:first_app/data_classes.dart';
import 'package:first_app/api/notification_api.dart';

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
    super.initState();
    print(MyData.globally_selected);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.VERY_LIGHT_BLUE,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(null),
            onPressed: () => {},
          ),
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
                    'assets/images/Exclamation.png',
                    color: AppColors.BLUE,
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Changes to cupboards!',
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
                // NotificationApi.showNotification(
                //   title: 'eee',
                //   body: 'aaaaaaa',
                // );
                // NotificationApi.showScheduledNotification(
                //   title: ' has expired',
                //   body: 'Click to remove it',
                //   payload: 'sk',
                //   scheduledDate: DateTime.now().add(Duration(seconds: 2)),
                //   //DateTime.parse(_newEntry.expired),
                // );
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
        'assets/images/Button.png',
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
      onPressed: () => showDialog<String>(
          context: context, builder: (BuildContext context) => help_pop_up()),
      color: AppColors.LIGHT_PURPLE,
      textColor: Colors.white,
      child: Icon(
        Icons.help_outline,
        size: 24,
      ),
      padding: EdgeInsets.all(16),
      shape: CircleBorder(),
    );
  }

  Widget help_pop_up() {
    return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        backgroundColor: AppColors.PURPLE,
        title: const Text('SMART CUPBOARDS',
            textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
        content: SingleChildScrollView(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Help Page',
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
                  'Press the bottom right button to go to Shopping Mode, then press the Shopping Lady button on the bottom right of the page that opens to view shopping mode Help Page',
                  textAlign: TextAlign.center,
                ))),
            TextButton(
                onPressed: () {},
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(20)),
                    foregroundColor: MaterialStateProperty.all<Color>(
                        AppColors.VERY_LIGHT_BLUE),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(AppColors.PURPLE),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side:
                                BorderSide(color: AppColors.VERY_LIGHT_BLUE)))),
                child: Column(children: [
                  Text(
                    'Gestures:',
                    textAlign: TextAlign.center,
                  ),
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
                        'In My Cupboards: Long Press to enter Item Deletion Mode \nor Swipe Right and tap on the star to add item to your Faves!',
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
                        'In My Favourite Products: Long Press to enter item deletion mode or Swipe Right to enable Notifications',
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
                        'When editing or creating a list you can remove an item by Swiping Right',
                        textAlign: TextAlign.center,
                      )),
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
                  'Sounds:\nA discrete sound effect is played whenever you successfully add or when you delete a product from your Cupboards or Faves',
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
                        MaterialStateProperty.all<Color>(AppColors.PINK),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: AppColors.PINK)))),
                child: Expanded(
                    child: Text(
                  'Notifications:\nYou will be notified when a product in your cupboards expires!',
                  textAlign: TextAlign.center,
                ))),
          ],
        )));
  }
}
