import 'dart:async';
import 'package:alhamwi_test/module_offline_mode/service/drift_service.dart';
import 'package:alhamwi_test/module_product/model/product_model.dart';
import 'package:alhamwi_test/module_product/repository/product_repository.dart';
import 'package:alhamwi_test/module_product/requests/add_product_request.dart';
import 'package:rxdart/rxdart.dart';

class ProductService {
  final DriftService database;
  ProductService(this.database) {
    _productRepository = ProductRepository(database);
    productsPublishSubject = PublishSubject();
  }
  late final ProductRepository _productRepository;

  /// Streams
  late final PublishSubject<List<ProductModel>?> productsPublishSubject;

  Future<void> getproducts() async {
    try {
    
      var response =  await _productRepository.getAllProductsFromLocalServer();
      var productsList = <ProductModel>[];
      response.forEach((element) {
        print(element);
        productsList.add(ProductModel(
            id: element.id,
            name: element.name,
            description: element.description!,
            price: element.price!.toDouble(),
            image: element.image.toString()));
      });
      productsPublishSubject.add(productsList);
    } catch (e) {
      productsPublishSubject.add(null);
    }
  }

  Future<bool> addProduct(AddProductRequest request) async {
    try {

      // Here, when editing comments, the image will be copied into the server (the project),
      // but permissions must be given to the application to access the files
      //
      //
      // final String images_path = DriftService.DATABASE_IMAGES;
      // File file = File(images_path);
      // File _image = File(request.image);
      // await file.writeAsBytes(_image.readAsBytesSync(), mode: FileMode.write);

      ProductModel model = ProductModel(
          id: -1,
          name: request.name,
          price: request.price,
          description: request.description,
          image: request.image);
      await _productRepository.addProductToLocalServer(model);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> updateProduct(AddProductRequest request) async {
    try {
      
      // Here, when editing comments, the image will be copied into the server (the project),
      // but permissions must be given to the application to access the files
      //
      //
      // final String images_path = DriftService.DATABASE_IMAGES;
      // File file = File(images_path);
      // File _image = File(request.image);
      // await file.writeAsBytes(_image.readAsBytesSync(), mode: FileMode.write);
      ProductModel model = ProductModel(
          id: request.id,
          name: request.name,
          price: request.price,
          description: request.description,
          image: request.image);
      await _productRepository.updateProductInLocalServer(model);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<ProductModel?> getProductById(int id) async {
    try {
      var res = await _productRepository.getProductFromLocalServer(id);
      return ProductModel(
          id: res.id,
          name: res.name,
          price: res.price!.toDouble(),
          description: res.description!,
          image: res.image!);
    } catch (e) {
      return null;
    }
  }

  Future<bool> deleteProductById(int id) async {
    try {
      await _productRepository.deleteProductFromLocalServer(id);
      return true;
    } catch (e) {
      return false;
    }
  }

  closeStreams() {}
}
