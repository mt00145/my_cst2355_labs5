import 'package:floor/floor.dart';
import 'items.dart';

@dao
abstract class ItemsDao {
  @Query('SELECT * FROM Items')
  Future<List<Items>> findAllItems();

  @insert
  Future<void> insertItem(Items item);

  @delete
  Future<void> deleteItem(Items item);
}