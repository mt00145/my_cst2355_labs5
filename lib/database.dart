import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

//import your classes you wrote
import 'items_dao.dart';
import 'items.dart';

//This must match the filename of this file you are writing
part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Items])
abstract class AppDatabase extends FloorDatabase {
  ItemsDao get itemsDao;
}