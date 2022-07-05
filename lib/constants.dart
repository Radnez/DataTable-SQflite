import 'package:flutter/material.dart';

// ignore: camel_case_types
class kColumnHeader extends StatelessWidget {
  const kColumnHeader({Key? key, required this.header}) : super(key: key);
  final String header;

  @override
  Widget build(BuildContext context) {
    return Text(
      header,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }
}

//Vertical Divider for Columns in Datatable
Widget verticalDivider = const VerticalDivider(
  thickness: 1,
);
