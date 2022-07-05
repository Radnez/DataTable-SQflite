import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:timetable_horizontal_vertical/model/schedule.dart';

class DataRowDatabase {
  static final DataRowDatabase instance = DataRowDatabase._init();

  static Database? _database;

  DataRowDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('datarow.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE datarows( 
  ${DataRowFields.id} $idType, 
  ${DataRowFields.entry} $textType)
  ''');
  }

  Future<DataRows> create(DataRows datarow) async {
    final db = await instance.database;
    final id = await db.insert('datarows', datarow.toJson());
    return datarow.copy(id: id);
  }

  Future<DataRows> readDataRow(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      'datarows',
      columns: DataRowFields.values,
      where: '${DataRowFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return DataRows.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<DataRows>> readAllDataRows() async {
    final db = await instance.database;
    final result = await db.query('datarows');
    return result.map((json) => DataRows.fromJson(json)).toList();
  }

  Future<int> update(DataRows datarow) async {
    final db = await instance.database;

    return db.update(
      'datarows',
      datarow.toJson(),
      where: '${DataRowFields.id} = ?',
      whereArgs: [datarow.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      'datarows',
      where: '${DataRowFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    // _database = null;
    return db.close();
  }
}
