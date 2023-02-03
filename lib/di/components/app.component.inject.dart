import 'package:alhamwi_test/di/components/app.component.dart';
import 'package:alhamwi_test/main.dart';
import 'package:alhamwi_test/module_home/navigator_module.dart';
import 'package:alhamwi_test/module_home/screen/home_screen.dart';
import 'package:alhamwi_test/module_home/screen/navigator_screen.dart';
import 'package:alhamwi_test/module_offline_mode/bloc/connection_bloc.dart';
import 'package:alhamwi_test/module_offline_mode/service/drift_service.dart';
import 'package:alhamwi_test/module_product/product_module.dart';
import 'package:alhamwi_test/module_product/state_manager/product_state_managments.dart';
import 'package:alhamwi_test/module_product/ui/screens/add_product_screen.dart';
import 'package:alhamwi_test/module_product/ui/screens/products_screen.dart';
import 'package:alhamwi_test/module_product/ui/screens/update_product_screen.dart';
import 'package:alhamwi_test/module_splash/screen/splash_screen.dart';
import 'package:alhamwi_test/module_splash/splash_module.dart';
import 'package:alhamwi_test/module_upload/upload_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class AppComponentInjector implements AppComponent {
  AppComponentInjector._();

   /// SingleTone
   DriftService? _singletonDriftService;

  static Future<AppComponent> create() async {
    final injector = AppComponentInjector._();
    return injector;
  }

  MyApp _createApp() => MyApp(_createSplashModule(), _createNavigatorModule(),
      _createProductModule(), _createInternetService());

  SplashModule _createSplashModule() => SplashModule(SplashScreen());
  NavigatorModule _createNavigatorModule() {
    _singletonDriftService ??= DriftService();
    return NavigatorModule(
      NavigatorScreen(
        homeScreen: HomeScreen(
          productsScreen:
              ProductsScreen(Get.put(ProductsStateManagments(_singletonDriftService ??= DriftService()))),
        ),
      ),
    );
  }

  ProductModule _createProductModule() => ProductModule(
      AddProductsScreen(
        Get.put(ProductsStateManagments(_singletonDriftService ??= DriftService())),
        UploadBloc(),
        
      ),
    ProductsScreen(Get.put(ProductsStateManagments(_singletonDriftService ??= DriftService()))),
      UpdateProductsScreen(Get.put(ProductsStateManagments(_singletonDriftService ??= DriftService())),UploadBloc())
      );

  InternetService _createInternetService() => InternetService(Connectivity());

  MyApp get app {
    return _createApp();
  }
}
