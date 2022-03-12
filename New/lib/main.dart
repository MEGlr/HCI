import 'package:first_app/Screens/add_product.dart';
import 'package:first_app/Screens/lists_list.dart';
import 'package:flutter/material.dart';
import 'package:first_app/Screens/welcome_page.dart';
import 'package:first_app/constants/appcolors.dart';
//import 'package:first_app/buttons/list_item.dart';
import 'package:first_app/buttons/bar_buttons.dart';
import 'package:first_app/buttons/general_button.dart';
import 'package:first_app/dialogs/general_dialog.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => WelcomeScreen(),
        '/cupList': (context) => my_cup_list()
      },
      debugShowCheckedModeBanner: false,
      title: 'Smart Cupboards',
      //    home: WelcomeScreen(), changed home to initial route
      // home: Scaffold(
      //     body: Center(
      //         child: Product(
      //             maintitle: "foof",
      //             color: AppColors.PINK,
      //             createPage: () => add_product(),
      //             image: 'images/Button.png',
      //             edges:'round')))
      // home: Scaffold(
      //     body: Center(
      //         child: GenDisplay(
      //   maintitle:
      //       "You added to your cart a\n product you already seem to \n have in your Cupboards! \n Are you sure you want to\n proceed with buying it?",
      //   color: AppColors.PURPLE,
      //   left: "No, go back",
      //   right: "Yes, I'm sure",
      //   edges: 5,
      //   createPageL: () => add_product(),
      //   createPageR: () => add_product(),
      // )))
    );
  }
}

// class Product extends StatefulWidget {
//   const Product({Key? key}) : super(key: key);

//   @override
//   State<Product> createState() => _ProductState();
// }

// class _ProductState extends State<Product> {
//   bool _LongPressed = false;
//   bool _toDelete = false;

//   @override
//   Widget build(BuildContext context){

//   return GestureDetector(
//           onLongPress: (){
//             setState(() {
//               _LongPressed = true;
//             });
//           },
//           child:  Container(
//             padding: const EdgeInsets.all(0),
//             color: _LongPressed? AppColors.BLUE: AppColors.GREY,
//             child: ListTile(
//                title:const Text('Product Name'),
//                subtitle:const Text('Product Brand'),
//                trailing: _LongPressed? Checkbox(value:false) : null,
//             ),

//           )
//         ); //Gesture Detector
//   } //Widget
// } //_ProductState class

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: new MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _selectedIndex = 0;

//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: AppBar(
//         title: Text("StackoverFlow"),
//       ),
//       body: Container(),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           await _dialogCall(context);
//         },
//       ),
//     );
//   }

//   Future<void> _dialogCall(BuildContext context) {
//     return showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return MyDialog();
//         });
//   }
// }

// class MyDialog extends StatefulWidget {
//   @override
//   _MyDialogState createState() => new _MyDialogState();
// }

// class _MyDialogState extends State<MyDialog> {
//   String name = "";
//   bool button = false;
//   DateTime when = DateTime.now();

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text("Save Event"),
//       content: new Column(
//         children: <Widget>[
//           new Expanded(
//             child: new TextField(
//               autofocus: true,
//               decoration: new InputDecoration(labelText: "Event Name"),
//               onChanged: (value) {
//                 name = value;
//               },
//               onSubmitted: (value) {},
//             ),
//           ),
//           new Expanded(
//               child: new Row(
//             children: <Widget>[
//               new Text("Date of Event "),
//               new RaisedButton(
//                   child: Text(DateFormat("dd/MM/yyyy").format(when)),
//                   onPressed: () async {
//                     DateTime? picked = await showDatePicker(
//                       context: context,
//                       initialDate: when,
//                       firstDate: DateTime(2015, 8),
//                       lastDate: DateTime(2101),
//                     );
//                     setState(() {
//                       when = picked!;
//                     });
//                   }),
//             ],
//           ))
//         ],
//       ),
//       actions: <Widget>[
//         new FlatButton(
//             child: const Text('OK'),
//             onPressed: () {
//               Navigator.of(context).pop(true);
//             }),
//         new FlatButton(
//             child: const Text("CANCEL"),
//             onPressed: () {
//               Navigator.of(context).pop(false);
//             }),
//       ],
//     );
//   }

//   Future<bool?> getNameDate(BuildContext context) async {
//     return showDialog<bool>(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Save Event"),
//           content: new Column(
//             children: <Widget>[
//               new Expanded(
//                 child: new TextField(
//                   autofocus: true,
//                   decoration: new InputDecoration(labelText: "Event Name"),
//                   onChanged: (value) {
//                     name = value;
//                   },
//                   onSubmitted: (value) {},
//                 ),
//               ),
//               new Expanded(
//                   child: new Row(
//                 children: <Widget>[
//                   new Text("Date of Event "),
//                   new RaisedButton(
//                       child: Text(DateFormat("dd/MM/yyyy").format(when)),
//                       onPressed: () async {
//                         DateTime? picked = await showDatePicker(
//                           context: context,
//                           initialDate: when,
//                           firstDate: DateTime(2015, 8),
//                           lastDate: DateTime(2101),
//                         );
//                         setState(() {
//                           when = picked!;
//                         });
//                       }),
//                 ],
//               ))
//             ],
//           ),
//           actions: <Widget>[
//             new FlatButton(
//                 child: const Text('OK'),
//                 onPressed: () {
//                   Navigator.of(context).pop(true);
//                 }),
//             new FlatButton(
//                 child: const Text("CANCEL"),
//                 onPressed: () {
//                   Navigator.of(context).pop(false);
//                 }),
//           ],
//         );
//       },
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:numberpicker/numberpicker.dart';

// void main() {
//   runApp(new MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'NumberPicker Example',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => new _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           bottom: TabBar(
//             tabs: [
//               Tab(text: 'Integer'),
//               Tab(text: 'Decimal'),
//             ],
//           ),
//           title: Text('Numberpicker example'),
//         ),
//         body: TabBarView(
//           children: [
//             _IntegerExample(),
//             _DecimalExample(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _IntegerExample extends StatefulWidget {
//   @override
//   __IntegerExampleState createState() => __IntegerExampleState();
// }

// class __IntegerExampleState extends State<_IntegerExample> {
//   int _currentIntValue = 10;
//   int _currentHorizontalIntValue = 10;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         SizedBox(height: 16),
//         Text('Default', style: Theme.of(context).textTheme.headline6),
//         NumberPicker(
//           value: _currentIntValue,
//           minValue: 0,
//           maxValue: 100,
//           step: 10,
//           haptics: true,
//           onChanged: (value) => setState(() => _currentIntValue = value),
//         ),
//         SizedBox(height: 32),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             IconButton(
//               icon: Icon(Icons.remove),
//               onPressed: () => setState(() {
//                 final newValue = _currentIntValue - 10;
//                 _currentIntValue = newValue.clamp(0, 100);
//               }),
//             ),
//             Text('Current int value: $_currentIntValue'),
//             IconButton(
//               icon: Icon(Icons.add),
//               onPressed: () => setState(() {
//                 final newValue = _currentIntValue + 20;
//                 _currentIntValue = newValue.clamp(0, 100);
//               }),
//             ),
//           ],
//         ),
//         Divider(color: Colors.grey, height: 32),
//         SizedBox(height: 16),
//         Text('Horizontal', style: Theme.of(context).textTheme.headline6),
//         NumberPicker(
//           value: _currentHorizontalIntValue,
//           minValue: 0,
//           maxValue: 100,
//           step: 10,
//           itemHeight: 100,
//           axis: Axis.horizontal,
//           onChanged: (value) =>
//               setState(() => _currentHorizontalIntValue = value),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(16),
//             border: Border.all(color: Colors.black26),
//           ),
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             IconButton(
//               icon: Icon(Icons.remove),
//               onPressed: () => setState(() {
//                 final newValue = _currentHorizontalIntValue - 10;
//                 _currentHorizontalIntValue = newValue.clamp(0, 100);
//               }),
//             ),
//             Text('Current horizontal int value: $_currentHorizontalIntValue'),
//             IconButton(
//               icon: Icon(Icons.add),
//               onPressed: () => setState(() {
//                 final newValue = _currentHorizontalIntValue + 20;
//                 _currentHorizontalIntValue = newValue.clamp(0, 100);
//               }),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

// class _DecimalExample extends StatefulWidget {
//   @override
//   __DecimalExampleState createState() => __DecimalExampleState();
// }

// class __DecimalExampleState extends State<_DecimalExample> {
//   double _currentDoubleValue = 3.0;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         SizedBox(height: 16),
//         Text('Decimal', style: Theme.of(context).textTheme.headline6),
//         DecimalNumberPicker(
//           value: _currentDoubleValue,
//           minValue: 0,
//           maxValue: 10,
//           decimalPlaces: 2,
//           onChanged: (value) => setState(() => _currentDoubleValue = value),
//         ),
//         SizedBox(height: 32),
//       ],
//     );
//   }
// }
