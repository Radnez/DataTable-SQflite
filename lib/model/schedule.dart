import 'package:flutter/material.dart';

class DataRowFields {
  static final List<String> values = [
    id,
    entry,
  ];
  static const String id = '_id';
  static const String entry = 'entry';
}

class DataRows {
  final int? id;
  final String entry;


  const DataRows({
    this.id,
    required this.entry,
  });

  DataRows copy({
    int? id,
    String? entry,
  }) =>
      DataRows(
        id: id ?? this.id,
        entry: entry ?? this.entry,
      );

  static DataRows fromJson(Map<String, Object?> json) => DataRows(
        id: json[DataRowFields.id] as int?,
        entry: json[DataRowFields.entry] as String,
      );

  Map<String, Object?> toJson() => {
        DataRowFields.id: id,
        DataRowFields.entry: entry,
      };
}
