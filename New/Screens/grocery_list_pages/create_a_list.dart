import 'package:first_app/constants/appcolors.dart';
import 'package:first_app/Screens/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:first_app/dashed_line.dart';
import 'package:first_app/Screens/grocery_list_pages/prod_to_list.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:first_app/buttons/form_field.dart';
import 'package:first_app/Screens/add_product.dart';

class create_list extends StatefulWidget {
  const create_list({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _create_list_state();
}

class _create_list_state extends State<create_list> {
  //bool isSelectionMode = false;
  Map<int, bool> selectedFlag = {};
  final _products = <ProductItem>[];
  final _listNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Create a List',
                textAlign: TextAlign.left,
                style: TextStyle(fontFamily: "Rationale")),
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                tooltip: 'back to main page',
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
                child: FloatingActionButton.extended(
                    icon: const Icon(Icons.download),
                    label: const Padding(
                      padding:
                          EdgeInsets.all(15), //apply padding to all four sides
                      child: Text("Load from\n Favourites"),
                    ),
                    onPressed: () {},
                    backgroundColor: AppColors.BLUE,
                    tooltip: 'load',
                    elevation: 20.0,
                    shape: StadiumBorder(
                        side: BorderSide(
                            color: AppColors.VERY_LIGHT_BLUE, width: 2)))),
            Container(
              //alignment: Alignment.bottomLeft,
              margin: EdgeInsets.all(17),
              child: Container(
                height: 80.0,
                width: 80.0,
                child: FittedBox(
                    child: FloatingActionButton(
                  child: const Icon(Icons.check),
                  onPressed: () {},
                  backgroundColor: AppColors.PINK,
                  tooltip: 'add product',
                  elevation: 20.0,
                )),
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        body: Center(
            child: Container(
                color: AppColors.VERY_LIGHT_BLUE,
                child: Column(children: <Widget>[
                  Form_Field(
                    color: AppColors.PURPLE,
                    maintitle: 'List Name',
                    edges: 10,
                    createPage: () => add_product(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'field required';
                      }
                      return null;
                    },
                  ),
                  Stack(children: <Widget>[
                    const MySeparator(color: Colors.white),
                    MaterialButton(
                      onPressed: _addNewEntry,
                      color: AppColors.LIGHT_PURPLE,
                      textColor: Colors.white,
                      child: Icon(
                        Icons.add,
                        size: 24,
                      ),
                      padding: EdgeInsets.all(16),
                      shape: CircleBorder(),
                    )
                  ]),
                  Expanded(child: _buildProductList())
                ]))));
  }

  void _addNewEntry() async {
    final ProductItem _newEntry = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => product_add_page()));
    print(_newEntry);
    if (_newEntry != null) {
      _products.add(ProductItem(
          brand: _newEntry.brand,
          type: _newEntry.type,
          quantity: _newEntry.quantity,
          name: _newEntry.name));
    }
    setState(() {});
  }

  Widget _buildProductList() {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(),
      padding: const EdgeInsets.all(16.0),
      itemCount: _products.length,
      itemBuilder: (context, index) {
        selectedFlag[index] = selectedFlag[index] ?? false;
        bool isSelected = selectedFlag[index] ?? false;

        return Dismissible(
            key: ValueKey<ProductItem>(_products[index]),
            background: Container(
              color: AppColors.PINK,
            ),
            onDismissed: (DismissDirection direction) {
              setState(() {
                _products.removeAt(index);
              });
            },
            child: Container(
                color: isSelected ? AppColors.MOODY_PINK : AppColors.LIGHT_BLUE,
                child: InkWell(
                    child: ListTile(
                  //onLongPress: () => onLongPress(isSelected, index),
                  onTap: () => onTap(isSelected, index),
                  leading: _buildSelectIcon(isSelected),

                  title: Text(_products[index].name),
                  subtitle: Text(
                      _products[index].brand + ", " + _products[index].type),
                ))));
      },
    );
  }

  void onTap(bool isSelected, int index) {
    setState(() {
      selectedFlag[index] = !isSelected;
      _products[index].selected = !isSelected;
      print(index);
      print(_products[index].selected);
      //isSelectionMode = selectedFlag.containsValue(true);
    });
  }

  Widget _buildSelectIcon(bool isSelected) {
    return Icon(isSelected ? Icons.check_box : Icons.check_box_outline_blank,
        //color: Theme.of(context).primaryColor,
        color: isSelected ? AppColors.PURPLE : Colors.white);
  }

  final _formKey = GlobalKey<FormState>();
  DateTime? _dateTime;
  final _nameController = TextEditingController();
  final _quantController = TextEditingController();
  final _brandController = TextEditingController();
  final _typeController = TextEditingController();
}

class GroceryList {
  String name;
  List<ProductItem> products = <ProductItem>[];
  GroceryList({
    required this.name,
    //required this.products,
  });
}
