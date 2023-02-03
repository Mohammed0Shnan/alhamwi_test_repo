import 'package:drift/drift.dart';
class Products extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get image => text().nullable()();
  RealColumn get price => real().nullable()();

}

abstract class ProductsView extends View {
  Products get products;

  @override
  Query as() => select([
    products.name,
  ]).from(products);
}

  @override
  int get schemaVersion => 3;
