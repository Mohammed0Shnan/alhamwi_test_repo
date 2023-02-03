import 'dart:io';

import 'package:alhamwi_test/module_product/requests/add_product_request.dart';
import 'package:alhamwi_test/module_product/state_manager/product_state_managments.dart';
import 'package:alhamwi_test/module_upload/upload_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddProductsScreen extends StatefulWidget {
  final ProductsStateManagments statemanagmet;
  final UploadBloc _uploadBloc;
  const AddProductsScreen(this.statemanagmet, this._uploadBloc, {Key? key})
      : super(key: key);

  @override
  State<AddProductsScreen> createState() => _AddProductsScreenState();
}

class _AddProductsScreenState extends State<AddProductsScreen> {
  final TextEditingController _nameProductController = TextEditingController();
  final TextEditingController _desProductController = TextEditingController();
  final TextEditingController _priceProductController = TextEditingController();
  @override
  void initState() {
    _imageProduct = null;
    widget._uploadBloc.initState();
    _nameProductController.clear();
    _desProductController.clear();
    _priceProductController.clear();
    super.initState();
  }

  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formState = GlobalKey<FormState>();

// Product Parameters
  String? _imageProduct = null;

  late double price;
  bool isRecommended = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black87),
        title: Text(
          'Add Product',
             style: TextStyle(
              fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        elevation: 0,
        centerTitle: false,
        // automaticallyImplyLeading: false,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: size.width * 0.15),
        child: Form(
          key: _formState,
          child: Row(
            children: [
              Flexible(
                flex: 4,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text('Product Name',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Container(
                          child: ListTile(
                              subtitle: Container(
                            height: 50,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 8,
                                      offset: Offset(0, 3))
                                ]),
                            child: TextFormField(
                              controller: _nameProductController,
                              decoration: InputDecoration(
                                  errorStyle: TextStyle(
                                    color: Colors.red.shade700,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  prefixIcon: Icon(Icons.store),
                                  border: InputBorder.none,
                                  hintText: 'product name .',
                                  hintStyle: TextStyle(
                                      color: Colors.black26,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 13)

                                  //S.of(context).name,
                                  ),
                              // Move focus to next
                              validator: (result) {
                                if (result!.isEmpty) {
                                  return 'product Name is Required';
                                }
                                return null;
                              },
                            ),
                          )),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text('Product Description',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Container(
                          child: ListTile(
                              subtitle: Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 8,
                                      offset: Offset(0, 3))
                                ]),
                            child: TextFormField(
                              controller: _desProductController,
                              maxLines: 5,
                              decoration: InputDecoration(
                                  errorStyle: TextStyle(
                                    color: Colors.red.shade700,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  prefixIcon: Icon(Icons.store),
                                  border: InputBorder.none,
                                  hintText: 'Product description .',
                                  hintStyle: TextStyle(
                                      color: Colors.black26,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 13)

                                  //S.of(context).name,
                                  ),
                              // Move focus to next
                              validator: (result) {
                                if (result!.isEmpty) {
                                  return 'Product description is Required';
                                }
                                return null;
                              },
                            ),
                          )),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text('Product Price',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Container(
                          child: ListTile(
                              subtitle: Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 8,
                                      offset: Offset(0, 3))
                                ]),
                            child: TextFormField(
                              controller: _priceProductController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  errorStyle: TextStyle(
                                    color: Colors.red.shade700,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  prefixIcon: Icon(Icons.store),
                                  border: InputBorder.none,
                                  hintText: 'Price .',
                                  hintStyle: TextStyle(
                                      color: Colors.black26,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 13)

                                  //S.of(context).name,
                                  ),
                              // Move focus to next
                              validator: (result) {
                                if (result!.isEmpty) {
                                  return 'Product Price is Required';
                                }
                                if (!_isNumeric(result))
                                  return 'The value must be a number';
                                return null;
                              },
                            ),
                          )),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Obx(() {
                        
                          if (widget.statemanagmet.add_product_loading.value) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return AnimatedContainer(
                                duration: Duration(milliseconds: 200),
                                clipBehavior: Clip.antiAlias,
                                height: 40,
                                width: widget
                                        .statemanagmet.add_product_loading.value
                                    ? 60
                                    : 180,
                                padding: EdgeInsets.all(widget
                                        .statemanagmet.add_product_loading.value
                                    ? 8
                                    : 0),
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(10)),
                                child: widget
                                        .statemanagmet.add_product_loading.value
                                    ? Center(
                                        child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ))
                                    : MaterialButton(
                                        onPressed: () {
                                          if (_formState.currentState!
                                                  .validate() &&
                                              _imageProduct != null) {
                                            String productName =
                                                _nameProductController.text
                                                    .trim();
                                            String productDes =
                                                _desProductController.text
                                                    .trim();
                                            double price = double.parse(
                                                _priceProductController.text
                                                    .trim());

                                            AddProductRequest productRequest =
                                                AddProductRequest(
                                              name: productName,
                                              description: productDes,
                                              image: _imageProduct!,
                                              price: price,
                                            );
                                            widget.statemanagmet
                                                .addProduct(productRequest).then((value){
                                                      if (value) {
                                                  ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text('Success')));
                                                Navigator.pop(context);
                                              } else {
                                                    ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text('Error')));
                                              }
                                                });
                                          } else if (_imageProduct == null) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Image Is Required')));
                                          }
                                        },
                                        child: Text('Add Product'),
                                      ));
                         
                          }
                        }),
                      ),
                  
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Product Image',
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    Container(
                      height: size.height * 0.4,
                      margin: EdgeInsets.all(16),
                      child: BlocConsumer<UploadBloc, UploadStates>(
                          bloc: widget._uploadBloc,
                          listener: (context, state) {
                            if (state is UploadSuccessState) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Product image successful uploaded')));
                            }
                          },
                          builder: (context, state) {
                            if (state is UploadSuccessState) {
                              _imageProduct = state.image;
                            }
                            return Container(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  state is UploadSuccessState
                                      ? Container(
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            color: Colors.black12,
                                          ),
                                          child: _imageProduct == null
                                              ? Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey
                                                 
                                                      ),
                                                )
                                              : Image.file(
                                                  File(_imageProduct!)))
                                      : Container(
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                              color: Colors.grey,
                                              shape: BoxShape.rectangle
                                              // image: DecorationImage(
                                              //   image: new ExactAssetImage('assets/logo3.png'),
                                              //   fit: BoxFit.cover,
                                              // ),
                                              ),
                                        ),
                                  Positioned(
                                      bottom: 0,
                                      left: 0,
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.blue,
                                        ),
                                        child: IconButton(
                                          onPressed: () async {
                                            widget._uploadBloc
                                                .pickFile(ImageSource.gallery);
                                          },
                                          icon: Icon(
                                            Icons.camera,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ))
                                ],
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
   bool _isNumeric(String str) {
    if(str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }
}
