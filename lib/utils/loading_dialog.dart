import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class LoadingDialog {
  static void hide() {
    Get.back();
  }

  static Future<void> show() async {
    const forceFullyBackEnable = kDebugMode;
    await Future.delayed(Duration.zero, () {
      Get.dialog(
        WillPopScope(
          onWillPop: () async => forceFullyBackEnable,
          child: GestureDetector(
            onTap: () {
              if (kDebugMode) {
                Get.back();
              }
            },
            child: const Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: SizedBox(
                  width: 180,
                  height: 280,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SpinKitFadingCircle(
                        color: Colors.blue,
                        duration: Duration(milliseconds: 1000),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        barrierColor: Colors.transparent,
        barrierDismissible: forceFullyBackEnable,
      );
    });
  }
}
