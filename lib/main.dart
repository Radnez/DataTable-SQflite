import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timetable_horizontal_vertical/scrollable_table.dart';
import 'package:flutter/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ScrollableTable(),
    );
  }
}
