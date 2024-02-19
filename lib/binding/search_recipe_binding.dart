import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchRecipeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchController());
  }
}
