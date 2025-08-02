import 'package:floor/floor.dart';

@entity
class Items {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String item;
  final String quantity;

  Items(this.item, this.quantity, {this.id});
}
