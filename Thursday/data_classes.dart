class ProductItem {
  String name;
  String brand;
  String quantity;
  String type;
  bool selected;
  bool isFav;
  String expired;
  ProductItem({
    required this.name,
    required this.brand,
    required this.quantity,
    required this.type,
    this.selected = false,
    required this.isFav,
    required this.expired,
  });
}

class ListItem {
  String name;
  String brand;
  String quantity;
  String type;
  bool selected;

  ListItem({
    required this.name,
    required this.brand,
    required this.quantity,
    required this.type,
    this.selected = false,
  });
}

class FavoriteItem {
  String name;
  String brand;
  String type;
  bool selected;
  FavoriteItem({
    required this.name,
    required this.brand,
    required this.type,
    this.selected = false,
  });
}

class GroceryList {
  String name;
  List<ListItem> products;
  bool selected;
  GroceryList({
    required this.name,
    this.products = const <ListItem>[],
    this.selected = false,
  });
}

class MyData {
  static List<ProductItem> products = <ProductItem>[];
  static List<FavoriteItem> favorites = <FavoriteItem>[];
  static List<GroceryList> grocery_lists = <GroceryList>[];
  static List<ListItem> shopping = <ListItem>[];
  static bool globally_selected = false;
  static bool isSelectionMode = false;
}
