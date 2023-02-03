
import 'package:alhamwi_test/abstracts/module/my_module.dart';
import 'package:alhamwi_test/module_splash/screen/splash_screen.dart';
import 'package:alhamwi_test/module_splash/splash_routes.dart';
import 'package:flutter/material.dart';


class SplashModule extends MyModule {
  
  final SplashScreen _splashScreen;
  SplashModule(this._splashScreen ) ;

  @override
  Map<String, WidgetBuilder> getRoutes() {
  return {SplashRoutes.SPLASH_SCREEN : (context) => _splashScreen};
  }
}