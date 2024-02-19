import 'package:flutter/material.dart';
import 'package:flutter_task/routes/app_routing.dart';
import 'package:flutter_task/routes/route_names.dart';
import 'package:flutter_task/view/splash_view.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: AppRouting().routingList,
      home: SplashView(),
    );
  }
}
