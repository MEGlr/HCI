import 'package:flutter/material.dart';
import 'package:first_app/buttons/general_button.dart';
import 'package:first_app/constants/appcolors.dart';
import 'package:first_app/Screens/my_cup_list.dart';

class AddItem extends StatefulWidget {
  const AddItem({Key? key}) : super(key: key);
  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
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
  Future<void> OpenForm() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: SingleChildScrollView(
                  child: ListBody(
                children: <Widget>[
                  GenButton(
                      maintitle: 'My Cupboards',
                      color: AppColors.PINK,
                      font: "Rational",
                      edges: 0,
                      createPage: () => my_cup_list())
                ],
              )),
              actions: <Widget>[
                FlatButton(child: Text('hello'), onPressed: () {})
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
