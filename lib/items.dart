import 'package:floor/floor.dart';

@entity
class Items {
  @primaryKey
  final String item;

  final String quantity;

  Items(this.item, this.quantity);
}