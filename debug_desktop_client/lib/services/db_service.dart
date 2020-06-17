// import 'dart:async';
// import 'dart:io';

// import 'package:flutter/services.dart' show rootBundle;
// import 'package:path/path.dart';
// // import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';

// import 'logger_service.dart';

// class DbService {
//   DbService({
//     this.name,
//     this.schemaName,
//     this.loggerService,
//   }) {
//     loggerService..d('DBService.name: $name')..d('DBService.schemaName: $schemaName');
//   }

//   final String schemaName;
//   final String name;
//   final LoggerService loggerService;

//   static Database _database;

//   Future<Database> get database async {
//     _database ??= await open();

//     return _database;
//   }

//   Future<void> close() async {
//     loggerService.d('DATABASE. close');
//     if (_database != null) {
//       await _database.close();
//     }
//   }

//   Future<Database> open() async {
//     Directory documentsDirectory; //(await getApplicationDocumentsDirectory());
//     final String path = join(documentsDirectory.path, name);
//     loggerService..d('db.open.path = $path')..d('DATABASE. open');

//     try {
//       final Database db = await openDatabase(path,
//           version: 1,
//           onCreate: _onCreate,
//           onOpen: _onOpen,
//           onUpgrade: _onUpgrade,
//           onConfigure: _onConfigure,
//           onDowngrade: _onDowngrade);

//       loggerService.d('db.open.isOpen = ${db.isOpen}');

//       return db;
//     } catch (exc) {
//       loggerService.d('create db exception: $exc');
//     }

//     return null;
//   }

//   Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
//     loggerService.d('DATABASE. onUpgrade. newV: $newVersion, oldV: $oldVersion');

//     if (newVersion > oldVersion) {
//       //schema tune
//       await db.execute(
//         '''
//         drop index profile_uk_is_current;
//         ''',
//       );
//     }
//   }

//   Future<void> _onCreate(Database db, int version) async {
//     loggerService.d('DATABASE.onCreate.schemaName = $schemaName');

//     final String schema = await rootBundle.loadString(schemaName);

//     schema.split(';').forEach((String p) async {
//       final String sql = p + ';';
//       await db.execute(sql);
//     });
//   }

//   Future<void> _onOpen(Database db) async {
//     loggerService.d('DATABASE. onOpen');
//   }

//   Future<void> _onDowngrade(Database db, int oldVersion, int newVersion) async {
//     loggerService.d('DATABASE. onDowngrade');
//   }

//   Future<void> _onConfigure(Database db) async {
//     loggerService.d('DATABASE. onConfigure');
//   }
// }
