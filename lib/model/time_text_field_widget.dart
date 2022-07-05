import 'package:flutter/material.dart';
import 'package:timetable_horizontal_vertical/model/schedule.dart';

class TimeTextField extends StatelessWidget {
  final String? entry;

  final ValueChanged<String> onChangedEntry;

  const TimeTextField({
    Key? key,
    this.entry,
    required this.onChangedEntry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: TextFormField(
        initialValue: entry,
        onChanged: onChangedEntry,
        maxLines: 1,
        style: TextStyle(fontSize: 20, color: Colors.black),
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
        validator: (entry) =>
            entry != null && entry.isEmpty ? 'The time cannot be empty' : null,
      ),
    );
  }
}
