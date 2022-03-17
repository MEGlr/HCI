import 'package:first_app/constants/appcolors.dart';
import 'package:first_app/Screens/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:first_app/data_classes.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class shopping_cart extends StatefulWidget {
  const shopping_cart({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _shopping_cart_state();
}

class _shopping_cart_state extends State<shopping_cart> {
  final _shopping = MyData.shopping;
  Map<int, bool> selectedFlag = {};

  Widget _buildProductList() {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(),
      padding: const EdgeInsets.all(16.0),
      itemCount: _shopping.length,
      itemBuilder: (context, index) {
        selectedFlag[index] = selectedFlag[index] ?? false;
        //bool isSelected = selectedFlag[index] ?? false;
        bool isSelected = _shopping[index].selected;

        return Slidable(
            startActionPane:
                ActionPane(motion: const ScrollMotion(), children: [
              SlidableAction(
                  onPressed: (BuildContext context) {},
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
                  //onLongPress: () => onLongPress(isSelected, index),
                  //onTap: () => onTap(isSelected, index),
                  title: Text(_shopping[index].name),
                  subtitle: Text(
                      _shopping[index].brand + ", " + _shopping[index].type),
                  //leading: _buildSelectIcon(isSelected),
                )));
      },
    );
  }

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
        body: _buildProductList(),
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
      onPressed: () {
        // for(G)
        // MyData.products.add(i);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => WelcomeScreen(
                  Updates: true,
                )));
      },
      backgroundColor: AppColors.PINK,
      tooltip: 'Add to cupboards',
      elevation: 20.0,
    );
  }
}
