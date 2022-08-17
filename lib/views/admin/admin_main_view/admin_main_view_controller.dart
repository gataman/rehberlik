import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminMainViewController extends GetxController {
  var selectedMenuItemIndex = 0.obs;
  final GlobalKey<ScaffoldState> _scaffoldStateKey = GlobalKey<ScaffoldState>();

  //getters
  GlobalKey<ScaffoldState> get scaffoldStateKey => _scaffoldStateKey;

  //functions
  void selectMenuItem(int index) {
    selectedMenuItemIndex.value = index;
    update();
  }

  void controlMenu() {
    if (!_scaffoldStateKey.currentState!.isDrawerOpen) {
      _scaffoldStateKey.currentState!.openDrawer();
    }
  }
}
