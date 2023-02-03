//
import 'package:alhamwi_test/abstracts/module/my_module.dart';
import 'package:alhamwi_test/module_product/product_routes.dart';
import 'package:alhamwi_test/module_product/ui/screens/add_product_screen.dart';
import 'package:alhamwi_test/module_product/ui/screens/products_screen.dart';
import 'package:alhamwi_test/module_product/ui/screens/update_product_screen.dart';
import 'package:flutter/material.dart';

class ProductModule extends MyModule {
  final ProductsScreen _productsScreen;
  final AddProductsScreen _addProductsScreen;
  final UpdateProductsScreen _updateProductsScreen;
  ProductModule(this._addProductsScreen, this._productsScreen,this._updateProductsScreen);

  Map<String, WidgetBuilder> getRoutes() {
    return {
      ProductRoutes.PRODUCTS_SCREEN: (context) => _productsScreen,
      ProductRoutes.ADD_PRODUCTS_SCREEN: (context) => _addProductsScreen,
            ProductRoutes.UPDATE_PRODUCTS_SCREEN: (context) => _updateProductsScreen,

      
    };
  }
}
