import 'package:get/get_navigation/src/routes/get_route.dart';

import '../main.dart';

class RouteConfig {
  static final String main = "/";

  static final List<GetPage>  routes = [
    GetPage(name:main,page:()=> MainPage()),
  ];
}