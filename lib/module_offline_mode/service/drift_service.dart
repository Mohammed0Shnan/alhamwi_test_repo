import 'package:alhamwi_test/module_offline_mode/db/data.dart';
import 'package:alhamwi_test/module_product/model/product_model.dart';
import 'package:drift/drift.dart' as drift;

class DriftService {
  late final Db db;
  static String DATABASE_IMAGES = 'DatabaseImages/';

  DriftService() {
    db = Db();
  }

  Future<int> createProduct(ProductModel model) async {
    /// DTO
    final entity = ProductsCompanion(
        name: drift.Value(model.name),
        description: drift.Value(model.description),
        price: drift.Value(model.price),
        image: drift.Value(model.image)
        );
        
    return await db.insertProduct(entity);
  }
  
  Future<Product> getProduct(int id) async {
    return await db.getProduct(id);
  }
  

  Future<List<Product>> getProducts() async {
    return await db.getProducts();
  }

  Future<bool> updateProduct(ProductModel model) async {
    /// DTO
    final entity = ProductsCompanion(
        id:drift.Value(model.id),
        name: drift.Value(model.name),
        description: drift.Value(model.description),
         image: drift.Value(model.image),
        price: drift.Value(model.price));
    return await db.updateProduct(entity);
  }
  
  Future<int> deleteProduct(int id)  async {
    return await db.deleteProduct(id);
  }
}
