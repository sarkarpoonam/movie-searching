import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:moviedata/theme/theme_colors.dart';
import 'package:moviedata/views/home_page.dart';

import 'core/my_pref.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.lazyPut<MyPref>(() => MyPref.instance);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Movies',
      theme: ThemeColor().themeData,
      home: const HomePage(),
    );
  }
}




