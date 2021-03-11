
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  var count = 0.obs;

  increment() => count++;
}



class GetXDemo extends StatefulWidget {
  @override
  GetXDemoState createState() => new GetXDemoState();
}

class GetXDemoState extends State<GetXDemo> {
  @override
  Widget build(context) {
    // 使用Get.put()实例化你的类，使其对当下的所有子路由可用。
    final Controller c = Get.put(Controller());
    var innerCount = 0.obs;

    return Scaffold(
      // 使用Obx(()=>每当改变计数时，就更新Text()。
        appBar: AppBar(title: Obx(() => Text("Clicks: ${c.count}"))),

        // 用一个简单的Get.to()即可代替Navigator.push那8行，无需上下文！
        body: Column(
          children: [
            Center(
                child: ElevatedButton(
                    child: Text("Go to Other"),
                    onPressed: () {
                      // Get.snackbar("Hi","Message");
                      // Get.defaultDialog(title: "I am a dialog");
                      Get.to(Other());
                    })),
            Container(
              height: 50,
              child: Center(
                  child: ElevatedButton(
                      child: Text("SnackBar"),
                      onPressed: () {
                        Get.snackbar("Hi", "Message");
                        // Get.defaultDialog(title: "I am a dialog");
                        // Get.to(Other());
                      })),
            ),
            Container(
              height: 50,
              child: Center(
                  child: ElevatedButton(
                      child: Text("Dialog"),
                      onPressed: () {
                        // Get.snackbar("Hi","Message");
                        Get.defaultDialog(title: "I am a dialog");
                        // Get.to(Other());
                      })),
            ),
            Container(
              height: 50,
              child: Center(
                  child: ElevatedButton(
                      child: Obx(() => Text("Current: ${innerCount.string}")),
                      onPressed: () {
                        innerCount++;
                        c.increment();
                      })),
            ),
            Container(
              height: 50,
              child: Center(
                  child: ElevatedButton(
                      child: Text("hello".tr),
                      onPressed: () {
                        if (Get.locale.languageCode == "zh") {
                          var locale = Locale('de', 'DE');
                          Get.updateLocale(locale);
                        } else {
                          var locale = Locale('zh', 'CN');
                          Get.updateLocale(locale);
                        }
                        // innerCount++;
                        // c.increment();
                      })),
            ),
            Container(
              height: 50,
              child: Center(
                  child: ElevatedButton(
                      child: Text("主题"),
                      onPressed: () {
                        Get.changeTheme(Get.isDarkMode
                            ? ThemeData.light()
                            : ThemeData.dark());
                      })),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add), onPressed: c.increment));
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
  void didUpdateWidget(GetXDemo oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}


class Other extends StatelessWidget {
  // 你可以让Get找到一个正在被其他页面使用的Controller，并将它返回给你。
  final Controller c = Get.find();

  @override
  Widget build(context) {
    // 访问更新后的计数变量
    return Scaffold(body: Center(child: Text("${c.count}")));
  }
}

