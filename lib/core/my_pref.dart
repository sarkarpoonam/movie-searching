import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MyPref {
  static MyPref get to => Get.find<MyPref>();

  static GetStorage _box() {
    return GetStorage("newGetStorage");
  }

  GetStorage get box => _box();

  MyPref._internal() {
    _box();
  }

  static final MyPref _instance = MyPref._internal();
  static MyPref get instance => _instance;

  final selectedImdbID = ReadWriteValue('p_selectedImdbID', '', _box);

}