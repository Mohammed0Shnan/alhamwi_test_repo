
import 'package:alhamwi_test/module_home/navigator_routes.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {

  SplashScreen(
  );
 
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
       WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getNextRoute().then((route) async{
        Navigator.of(context).pushNamedAndRemoveUntil(route, (route) => false);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  Future<String> _getNextRoute() async {

        return NavigatorRoutes.NAVIGATOR_SCREEN;

  }
}


