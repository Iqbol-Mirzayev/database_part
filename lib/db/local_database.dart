import 'package:project1/db/cached_contact.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class LocalDatabase {
  static final LocalDatabase getInstance = LocalDatabase._init();
  static Database? _database;

  factory LocalDatabase() {
    return getInstance;
  }

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDB("contacts.db");
      return _database!;
    }
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = "TEXT NOT NULL";
    const intType = "INTEGER DEFAULT 0";
    const boolType = 'BOOLEAN NOT NULL';
//TODO 2 Create table
    // await db.execute('''
    // CREATE TABLE $userTable (
    // ${CachedUsersFields.id} $idType,
    // ${CachedUsersFields.userName} $textType,
    // ${CachedUsersFields.age} $intType
    // )
    // '''); ---> ok bro

    await db.execute('''
    CREATE TABLE $contactsTable (
      ${CachedContactsFields.id} $idType,
      ${CachedContactsFields.fullName} $textType,
      ${CachedContactsFields.phone} $textType
    )
    ''');
  }

  LocalDatabase._init();

//-------------------------------------------Cached Contacts Table------------------------------------

////////    insert data

  static Future<int> insertCachedContact(CachedContact cachedContact) async {
    final db = await getInstance.database;
    final id = await db.insert(contactsTable, cachedContact.toJson());
    return id;
  }

  ///// delete
  ///
  static Future<int> deleteById(int id) async {
    final db = await getInstance.database;
    final check = await db.delete(
      contactsTable,
      where: "${CachedContactsFields.id}=?",
      whereArgs: [id],
    );
    return check;
  }

  ////////  all clear
  ///
  static Future<int> deleteAllCachedUsers() async {
    final db = await getInstance.database;
    return await db.delete(contactsTable);
  }

  //// get all contacts
  ///

  static Future<List<CachedContact>> getAllContacts() async {
    final db = await getInstance.database;
    final contacts = await db.query(contactsTable);
    return contacts.map((json) => CachedContact.fromjson(json)).toList();
  }

  // update
  static Future<int> updateContact(CachedContact cachedContact) async {
    final db = await getInstance.database;
    Map<String, Object?> updatableContact = {
      CachedContactsFields.fullName: cachedContact.fullName,
      CachedContactsFields.phone: cachedContact.phone,
    };
    final id = db.update(
      contactsTable,
      updatableContact,
      where: "${CachedContactsFields.id}=?",
      whereArgs: [cachedContact.id],
    );
    return id;
  }
}
