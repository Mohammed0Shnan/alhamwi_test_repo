import 'package:alhamwi_test/module_network/http_client/http_client.dart';
import 'package:alhamwi_test/module_offline_mode/db/data.dart';
import 'package:alhamwi_test/module_offline_mode/service/drift_service.dart';
import 'package:alhamwi_test/module_product/model/product_model.dart';

class ProductRepository {
  //This is when dealing with an API
  final client = ApiClient();

  final DriftService database;
  ProductRepository(this.database);

  /// Here An example of dealing with an external server

  // Future<Type> methodeName() async {
  //   var result = await client.get(Urls.APi, queryParams: {});
  //   if (result == null) {
  //     return null;
  //   } else {
  //     return fromJson(result);
  //   }
  // }

  getAllProductsFromLocalServer() async {
    return await database.getProducts();
  }

  Future<Product> getProductFromLocalServer(int id) async {
    return await database.getProduct(id);
  }

  addProductToLocalServer(ProductModel productModel) async {
    await database.createProduct(productModel);
  }

  updateProductInLocalServer(ProductModel productModel) async {
    await database.updateProduct(productModel);
  }

  deleteProductFromLocalServer(int id) async {
    await database.deleteProduct(id);
  }
}
