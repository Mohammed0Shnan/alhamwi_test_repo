import 'dart:io';
import 'package:alhamwi_test/module_product/model/product_model.dart';
import 'package:alhamwi_test/module_product/product_routes.dart';
import 'package:alhamwi_test/module_product/state_manager/product_state_managments.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsScreen extends StatefulWidget {
  final ProductsStateManagments statemanagmet;
  ProductsScreen(this.statemanagmet);

  @override
  State<StatefulWidget> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    widget.statemanagmet.getProducts();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          'Products',
          style: TextStyle(
            fontFamily: 'Dubai',
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                widget.statemanagmet.getProducts();
              },
              icon: Icon(Icons.refresh_outlined))
        ],
        elevation: 0,
      ),
      body: SafeArea(
        child: getProducts(),
      ),
    );
  }

  Widget getProducts() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Obx(() {
        if (widget.statemanagmet.products_loading.value) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          List<ProductModel> products = widget.statemanagmet.products;
          if (products == null) {
            return Center(
                child: Text(
              'Error',
              style: TextStyle(fontFamily: 'Dubai'),
            ));
          } else if (products.isEmpty)
            return Center(
                child: Text('Empty', style: TextStyle(fontFamily: 'Dubai')));
          else
            return Scrollbar(
              child: ListView.separated(
                itemCount: products.length,
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 8,
                  );
                },
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, ProductRoutes.UPDATE_PRODUCTS_SCREEN,
                          arguments: products[index].id);
                    },
                    child: Container(
                      height: 130,
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 1,
                              spreadRadius: 1)
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                child: products[index].image == 'null'
                                    ? Container(
                                        color: Colors.grey,
                                        child: Center(
                                          child: Icon(Icons.error),
                                        ),
                                      )
                                    : Image.file(File(products[index].image)),
                                //  child: Icon(Products[index].is_answered?Icons.check:Icons.close , color: Products[index].is_answered?Colors.green:Colors.red,size: 24,) ,
                              ),
                              SizedBox(
                                width: 16.0,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      products[index].name,
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontFamily: 'Dubai',
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(products[index].description,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontFamily: 'Dubai',
                                            fontSize: 14.0)),
                                    Text(products[index].price.toString(),
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0)),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 4,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
        }
      }),
    );
  }
}
