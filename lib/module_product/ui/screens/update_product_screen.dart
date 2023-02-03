import 'dart:io';
import 'package:alhamwi_test/module_product/model/product_model.dart';
import 'package:alhamwi_test/module_product/requests/add_product_request.dart';
import 'package:alhamwi_test/module_product/state_manager/product_state_managments.dart';
import 'package:alhamwi_test/module_upload/upload_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProductsScreen extends StatefulWidget {
  final ProductsStateManagments stateManagment;
  final UploadBloc _uploadBloc;
  const UpdateProductsScreen(this.stateManagment, this._uploadBloc, {Key? key})
      : super(key: key);

  @override
  State<UpdateProductsScreen> createState() => _UpdateProductsScreenState();
}

class _UpdateProductsScreenState extends State<UpdateProductsScreen> {
  final TextEditingController _nameProductController = TextEditingController();
  final TextEditingController _desProductController = TextEditingController();
  final TextEditingController _priceProductController = TextEditingController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      productId = ModalRoute.of(context)!.settings.arguments as int;
      widget.stateManagment.getProductDetails(productId);
    });
    super.initState();
  }

  late int productId;
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formState = GlobalKey<FormState>();

// Product Parameters
  String? _imageProduct = null;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        key: _scaffoldState,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black87),
          title: Text(
            'Update Product',
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
          child: Obx(() {
            if (widget.stateManagment.get_product_loading.value) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              // ignore: invalid_use_of_protected_member
              ProductModel product = widget.stateManagment.product.value.first;
           
                _nameProductController.text = product.name;
                _desProductController.text = product.description;
                _priceProductController.text = product.price.toString();
                _imageProduct = product.image;
                widget._uploadBloc
                    .add(UploadSuccessEvent(_imageProduct.toString()));
          

              return Form(
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
                            Obx(() {
                              return AnimatedContainer(
                                  duration: Duration(milliseconds: 200),
                                  clipBehavior: Clip.antiAlias,
                                  height: 50,
                                  width: 300,
                                  padding: EdgeInsets.all(widget.stateManagment
                                          .update_product_loading.value
                                      ? 8
                                      : 0),
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    children: [
                                      MaterialButton(
                                        color: Colors.amber,
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
                                            productRequest.id = productId;
                                            widget.stateManagment
                                                .updateProduct(productRequest)
                                                .then((value) {
                                              if (value) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content:
                                                            Text('Success !!!')));
                                                Navigator.pop(context);
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        content:
                                                            Text('Error !!!')));
                                              }
                                            });
                                          } else if (_imageProduct == null) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Image Is Required')));
                                          }
                                        },
                                        child: Text('Update Product'),
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      MaterialButton(
                                        color: Colors.red,
                                        onPressed: () {
                                          widget.stateManagment
                                              .deleteProduct(productId)
                                              .then((value) {
                                            if (value) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content:
                                                          Text('Success !!!')));
                                              Navigator.pop(context);
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text('Error !!!')));
                                            }
                                          });
                                        },
                                        child: Text(
                                          'Delete Product',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ));
                            })
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
                                listener: (context, state) {},
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
                                                            // image: DecorationImage(
                                                            //   image: new ExactAssetImage('assets/logo3.png'),
                                                            //   fit: BoxFit.cover,
                                                            // ),
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
                                                  widget._uploadBloc.pickFile(
                                                      ImageSource.gallery);
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
              );
            }
          }),
        ));
  }
     bool _isNumeric(String str) {
    if(str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }
}
