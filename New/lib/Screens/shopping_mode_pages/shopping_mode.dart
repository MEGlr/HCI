import 'package:first_app/constants/appcolors.dart';
import 'package:first_app/Screens/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:first_app/Screens/shopping_mode_pages/my_shopping_cart.dart';
import 'package:first_app/buttons/cam_mic.dart';

class shopping_mode extends StatefulWidget {
  const shopping_mode({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _shopping_mode_state();
}

class _shopping_mode_state extends State<shopping_mode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => shopping_cart()));
                },
              )
            ],
            backgroundColor: AppColors.LIGHT_BLUE),
        body: Container(
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
                              onPressed: () => showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      cam_and_mic()),
                              child: Text('Load Grocery List',
                                  style: TextStyle(
                                      color: Color.fromRGBO(233, 233, 233, 1))),
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
                            ))
                      ],
                    )))),
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
          'images/shopping_mode_on.png',
          height: 130,
          alignment: Alignment.bottomRight,
        )),
        onTap: null);
  }

  Widget CameraButton() {
    return SizedBox(
        height: 90.0,
        width: 90.0,
        child: FittedBox(
            child: FloatingActionButton(
                backgroundColor: AppColors.PINK,
                onPressed: null,
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
              onPressed: () {},
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
                  onPressed: () {},
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

  /*Widget cam_or_mic() {
    return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        //title: const Text('Add a product to your list',
        //    style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
                padding: EdgeInsets.only(left: 80),
                child: MaterialButton(
                  onPressed: () {},
                  color: AppColors.PURPLE,
                  textColor: Colors.white,
                  child: Icon(
                    Icons.mic,
                    size: 80,
                  ),
                  padding: EdgeInsets.all(16),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                )),
            Padding(
                padding: EdgeInsets.only(top: 30, right: 80),
                child: MaterialButton(
                  onPressed: () {},
                  color: AppColors.PURPLE,
                  textColor: Colors.white,
                  child: Icon(
                    Icons.camera,
                    size: 80,
                  ),
                  padding: EdgeInsets.all(16),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                )),
          ],
        ));
  }*/
}
