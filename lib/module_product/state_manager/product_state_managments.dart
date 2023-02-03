import 'package:alhamwi_test/module_offline_mode/service/drift_service.dart';
import 'package:alhamwi_test/module_product/model/product_model.dart';
import 'package:alhamwi_test/module_product/requests/add_product_request.dart';
import 'package:alhamwi_test/module_product/service/product_service.dart';
import 'package:get/get.dart';

class ProductsStateManagments extends GetxController {
  RxList<ProductModel> products = <ProductModel>[].obs;
  var product = <ProductModel>[].obs;

  RxBool products_loading = false.obs;
  RxBool add_product_loading = false.obs;
  RxBool get_product_loading = true.obs;
  RxBool update_product_loading = false.obs;
  

  final DriftService database;
  late final ProductService _service;
  ProductsStateManagments(this.database) {
    _service = ProductService(database);
  }

  void getProducts() {
    products_loading.value = true;
    _service.productsPublishSubject.listen((value) {
      if (value != null) {
        products.value = value.toList();
      } else {
        /// Here for dynamic messages when dealing with the Internet
      }
      products_loading.value = false;
    });
    _service.getproducts();
  }

  Future<bool> addProduct(AddProductRequest request) async {
    add_product_loading.value = true;
    return await _service.addProduct(request).then((value) {
      if (value) {
        getProducts();
      } else {
        /// Here for dynamic messages when dealing with the Internet
      }
      add_product_loading.value = false;
      return value;
    });
  }

  getProductDetails(int id) {
    get_product_loading.value = true;
    _service.getProductById(id).then((value) {
      if (value != null) {
        product.value = [value];
      } else {
         /// Here for dynamic messages when dealing with the Internet
      }
      get_product_loading.value = false;
    });
  }

  Future<bool> updateProduct(AddProductRequest request) async {
    update_product_loading.value = true;

    return await _service.updateProduct(request).then((value) {
      if (value) {
        getProducts();
      } else {
         /// Here for dynamic messages when dealing with the Internet
      }
      update_product_loading.value = false;
      return value;
    });
  }

  Future<bool> deleteProduct(int id) async {
    update_product_loading.value = true;
    return await _service.deleteProductById(id).then((value) {
      if (value) {
          getProducts();
      } else {
         /// Here for dynamic messages when dealing with the Internet
      }
      update_product_loading.value = false;
      return value;
    });
  }
}
