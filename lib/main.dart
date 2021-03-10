import 'package:flutter/material.dart';
import 'package:flutter_demo/strings.dart';
import 'package:get/get.dart';

import 'config/routes.dart';
import 'demo/ui_demo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: RouteConfig.main,
      getPages: RouteConfig.routes,
      home:MainPage(),
      translations: Messages(), // 你的翻译
      locale: Locale('zh', 'CN'), // 将会按照此处指定的语言翻译
      fallbackLocale: Locale('en', 'US'), // 添加一个回调语言选项，以
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  MainPageState createState() => new MainPageState();
}

class MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body:ListView(
        children: [
          Container(
            height: 50,
            child: Center(
                child: ElevatedButton(
                    child: Text("基础例子"),
                    onPressed: () {
                      Get.to(UiDemo());
                    })),
          ),
          Container(
            height: 50,
            child: Center(
                child: ElevatedButton(
                    child: Text("UI框架"),
                    onPressed: () {
                      Get.toNamed(RouteConfig.frame);
                    })),
          ),
        ],
      )
    );
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(MainPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
