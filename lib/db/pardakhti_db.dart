import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';
import '../model/model_chek.dart';

class BankDataBase {
  BankDataBase._init();
  static final BankDataBase instance = BankDataBase._init();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('Cheque_db.db');
    return _database!;
  }

  Future<Database> _initDB(String databasename) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, databasename);
    return await openDatabase(path, version: 2, onCreate: _creatDB);
  }

  Future _creatDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY';
    const textType = 'TEXT NOT NULL';

    await db.execute('''CREATE TABLE $tableName (
    serial $idType,
    mablagh $textType,
    bankname $textType,
    pardakhtkonande $textType,
    phonenumber $textType,
    type $textType,
    tarikh $textType,
    tozihat $textType,
    ispaid $textType
  )
''');
  }

  Future<Cheque> create(Cheque cheque) async {
    final db = await instance.database;
    final id = await db.insert(tableName, cheque.toJson());
    return cheque.copy(serial: id);
  }

  Future<Cheque> readCheque(int? id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableName,
      columns: ChequeFields.values,
      where: 'serial = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Cheque.fromJson(maps.first);
    } else {
      throw Exception('serial $id not found');
    }
  }

  Future<List<Cheque>> readAllCheque() async {
    final db = await instance.database;
    final result = await db.query(tableName, orderBy: 'tarikh');
    return result.map((json) => Cheque.fromJson(json)).toList();
  }

  Future<int> updateCheque(Cheque cheque) async {
    final db = await instance.database;
    return db.update(
      tableName,
      cheque.toJson(),
      where: 'serial = ?',
      whereArgs: [cheque.serial],
    );
  }

  Future<int> deleteCheque(int? id) async {
    final db = await instance.database;
    return await db.delete(
      tableName,
      where: 'serial = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAllCheque() async {
    final db = await instance.database;
    return await db.delete(tableName);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
