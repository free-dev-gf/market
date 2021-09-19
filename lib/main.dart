import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:market/redux.dart';
import 'package:redux/redux.dart';
import 'package:market/home.dart';

void main() {
  final store = Store<List<ListItem>>(cartReducer, initialState: []);

  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.store}) : super(key: key);
  final Store<List<ListItem>> store;

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: MaterialApp(
          title: 'Market',
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          home: Home(),
        ));
  }
}
