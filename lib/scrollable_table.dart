// ignore_for_file: avoid_print
import 'package:timetable_horizontal_vertical/model/time_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:flutter/widgets.dart';

import 'model/schedule.dart';
import 'model/schedule_database.dart';

class ScrollableTable extends StatefulWidget {
  final DataRows? dataRows;

  const ScrollableTable({Key? key, this.dataRows}) : super(key: key);
  @override
  State<ScrollableTable> createState() => _ScrollableTableState();
}

class _ScrollableTableState extends State<ScrollableTable> {
  final _formKey = GlobalKey<FormState>();

  late String entry;
  bool isLoading = false;
  late List<DataRows> dataRow = [];
  late List<DataRow> dataRowsList = [];

  @override
  void initState() {
    super.initState();

    entry = widget.dataRows?.entry ?? '';

    refreshDataRow();
  }

  @override
  void dispose() {
    DataRowDatabase.instance.close();
    super.dispose();
  }

  Future refreshDataRow() async {
    setState(() => isLoading = true);
    this.dataRow = await DataRowDatabase.instance.readAllDataRows();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              TextButton(
                  onPressed: () async {
                    print('Add was tapped');
                    print('${dataRowsList.length}');
                    setState(() {
                      dataRowsList.add(buildDataRow(dataRowsList.length));
                    });
                  },
                  child: Text(
                    'ADD',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  )),
              Spacer(),
              buildButton(),
              Spacer(),
              TextButton(
                  onPressed: () async {
                    setState(() {
                      print('${dataRowsList.length}');
                      print('minus was tapped');
                      dataRowsList.removeLast();
                    });
                  },
                  child: Text(
                    'MINUS',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  )),
            ],
          ),
        ),
        body: InteractiveViewer(
          constrained: false,
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.black),
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: DataTable(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                columns: [
                  DataColumn(
                      label: kColumnHeader(
                    header: 'Times',
                  )),
                  DataColumn(label: verticalDivider),
                  DataColumn(
                      label: kColumnHeader(
                    header: 'Monday',
                  )),
                  DataColumn(label: verticalDivider),
                  DataColumn(
                      label: kColumnHeader(
                    header: 'Tuesday',
                  )),
                  DataColumn(label: verticalDivider),
                  DataColumn(
                      label: kColumnHeader(
                    header: 'Wednesday',
                  )),
                  DataColumn(label: verticalDivider),
                  DataColumn(
                      label: kColumnHeader(
                    header: 'Thursday',
                  )),
                  DataColumn(label: verticalDivider),
                  DataColumn(
                      label: kColumnHeader(
                    header: 'Friday',
                  )),
                  DataColumn(label: verticalDivider),
                  DataColumn(
                      label: kColumnHeader(
                    header: 'Saturday',
                  )),
                  DataColumn(label: verticalDivider),
                  DataColumn(
                      label: Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: kColumnHeader(
                      header: 'Sunday',
                    ),
                  )),
                ],
                rows: List.generate(dataRowsList.length,
                    (index) => buildDataRow(dataRow[index])),
              ),
            ),
          ),
        ),
      ),
    );
  }

  DataRow buildDataRow(dataRow) => DataRow(
          cells: [
        DataCell(
          TimeTextField(
            entry: entry,
            onChangedEntry: (entry) => setState(() => this.entry = entry),
          ),
        ),
        DataCell(verticalDivider),
        DataCell(
          TimeTextField(
            entry: entry,
            onChangedEntry: (entry) => setState(() => this.entry = entry),
          ),
        ),
        DataCell(verticalDivider),
        DataCell(
          TimeTextField(
            entry: entry,
            onChangedEntry: (entry) => setState(() => this.entry = entry),
          ),
        ),
        DataCell(verticalDivider),
        DataCell(
          TimeTextField(
            entry: entry,
            onChangedEntry: (entry) => setState(() => this.entry = entry),
          ),
        ),
        DataCell(verticalDivider),
        DataCell(
          TimeTextField(
            entry: entry,
            onChangedEntry: (entry) => setState(() => this.entry = entry),
          ),
        ),
        DataCell(verticalDivider),
        DataCell(
          TimeTextField(
            entry: entry,
            onChangedEntry: (entry) => setState(() => this.entry = entry),
          ),
        ),
        DataCell(verticalDivider),
        DataCell(
          TimeTextField(
            entry: entry,
            onChangedEntry: (entry) => setState(() => this.entry = entry),
          ),
        ),
        DataCell(verticalDivider),
        DataCell(
          TimeTextField(
            entry: entry,
            onChangedEntry: (entry) => setState(() => this.entry = entry),
          ),
        ),
      ].toList());

  Widget buildButton() {
    // final isFormValid = entry?.isNotEmpty;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
        ),
        onPressed: () {
          addNote();
        },
        child: Text('Save'),
      ),
    );
  }

  // void addOrUpdateNote() async {
  //   final isValid = _formKey.currentState!.validate();
  //
  //   if (isValid) {
  //     final isUpdating = widget.dataRow != null;
  //     if (isUpdating) {
  //       await updateNote();
  //     } else {
  //       await addNote();
  //     }
  //
  //   }
  // }

  Future updateNote() async {
    final dataRows = widget.dataRows!.copy(
      entry: entry,
    );

    await DataRowDatabase.instance.update(dataRows);
  }

  Future addNote() async {
    final dataRows = DataRows(entry: entry);

    await DataRowDatabase.instance.create(dataRows);
  }
}
