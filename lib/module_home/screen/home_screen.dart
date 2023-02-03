//import 'package:alhamwi_test/module_question/ui/screens/questions_screen.dart';
import 'package:alhamwi_test/module_product/product_routes.dart';
import 'package:alhamwi_test/module_product/ui/screens/products_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final ProductsScreen productsScreen;
  const HomeScreen({required this.productsScreen, Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.productsScreen,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
                    Navigator.of(context).pushNamed(ProductRoutes.ADD_PRODUCTS_SCREEN);

        },
        child:  Icon(Icons.add)
    
      )
    );
  }
}
