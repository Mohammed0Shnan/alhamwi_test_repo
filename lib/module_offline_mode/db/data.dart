import 'dart:io';

import 'package:alhamwi_test/module_offline_mode/tables/products_table.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
part 'data.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'products_database.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Products])
class Db extends _$Db {
  Db() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  Future<List<Product>> getProducts() async {
    return await select(products).get();
  }

  Future<Product> getProduct(int id) async {
    return await (select(products)..where((tbl) => tbl.id.equals(id)))
        .getSingle();
  }

  Future<bool> updateProduct(ProductsCompanion entity) async {
    return await update(products).replace(entity);
  }

  Future<int> insertProduct(ProductsCompanion entity) async {
    return await into(products).insert(entity);
  }

  Future<int> deleteProduct(int id) async {
    return await (delete(products)..where((tbl) => tbl.id.equals(id))).go();
  }
}
