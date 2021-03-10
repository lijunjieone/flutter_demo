
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/strings.dart';
import 'package:get/get.dart';

class TriangleCliper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    //移动至起始点(50.0,50.0)
    path.moveTo(50.0, 50.0);
    //开始画线 起始点(50.0,50.0) 终止点(50.0,10.0)
    path.lineTo(50.0, 10.0);
    //开始画线 起始点(50.0,10.0) 终止点(100.0,50.0)
    path.lineTo(100.0, 50.0);
    path.close(); //使这些点构成三角形
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    throw true;
  }
}

class RectClipper extends CustomClipper<Rect> {
  //重写获取剪裁范围
  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(100.0, 100.0, size.width - 100.0, size.height - 100.0);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return true;
  }
}

class LinePainter extends CustomPainter {
  //定义画笔
  Paint _paint = Paint()
    ..color = Colors.grey
    ..strokeCap = StrokeCap.square
    ..isAntiAlias = true
    ..strokeWidth = 3.0
    ..style = PaintingStyle
        .stroke; //画笔样式有填充PaintingStyle.fill及没有填充PaintingStyle.stroke两种

  //重写绘制内容方法
  @override
  void paint(Canvas canvas, Size size) {
    //绘制圆 参数为中心点，半径，画笔
    canvas.drawCircle(Offset(0, 0), 25.0, _paint);
    drawArc(canvas, size);
    drawRRect(canvas, size);
    drawPoint(canvas, size);
    drawDRRect(canvas, size);
    drawOval(canvas, size);
    canvas.drawLine(Offset(20.0, 20.0), Offset(150.0, 80.0), _paint);
    drawPath(canvas, size);
  }

  void drawPath(Canvas canvas, Size size) {
    //新建一个path移动到一个位置，然后画各种线
    Path path = Path()..moveTo(0.0, 0.0);
    path.lineTo(20.0, 30.0);
    path.lineTo(100.0, 100.0);
    path.lineTo(150.0, 150.0);
    path.lineTo(150.0, 100.0);
    canvas.drawPath(path, _paint);
  }

  void drawOval(Canvas canvas, Size size) {
    //绘制椭圆
    //使用一个矩形来确定绘制的范围,椭圆是在这个矩形之中内切的,第一个参数为左上角坐标,第二个参数为右下角坐标
    Rect rect = Rect.fromPoints(Offset(0.0, 0.0), Offset(150.0, 80.0));
    canvas.drawOval(rect, _paint);
  }

  void drawDRRect(Canvas canvas, Size size) {
    //初始化两个矩形
    Rect rect1 = Rect.fromCircle(center: Offset(50.0, 50.0), radius: 80.0);
    Rect rect2 = Rect.fromCircle(center: Offset(50.0, 50.0), radius: 70.0);
    //再把这两个矩形转化成圆角矩形
    RRect outer = RRect.fromRectAndRadius(rect1, Radius.circular(20.0));
    RRect inner = RRect.fromRectAndRadius(rect2, Radius.circular(10.0));
    canvas.drawDRRect(outer, inner, _paint);
  }

  void drawPoint(Canvas canvas, Size size) {
    //绘制点
    canvas.drawPoints(

      //PointMode的枚举类型有三个，points点，lines隔点连接线，polygon相邻连接线
        PointMode.points,
        [
          Offset(50.0, 60.0),
          Offset(0.0, 0.0),
          Offset(-20.0, 0.0),
          Offset(40.0, 90.0),
          Offset(100.0, 100.0),
          // Offset(300.0, 350.0),
          // Offset(400.0, 80.0),
          // Offset(200.0, 200.0),
        ],
        _paint..color = Colors.red);
  }

  void drawArc(Canvas canvas, Size size) {
    //绘制圆弧
    const PI = 3.1415926;
    //定义矩形
    Rect rect1 = Rect.fromCircle(center: Offset(50.0, 0.0), radius: 100.0);
    //画1/2PI弧度的圆弧
    canvas.drawArc(rect1, 0.0, PI / 2, true, _paint);
    //画PI弧度的圆弧
    Rect rect2 = Rect.fromCircle(center: Offset(50.0, 50.0), radius: 100.0);
    canvas.drawArc(rect2, 0.0, PI, true, _paint);
  }

  void drawRRect(Canvas canvas, Size size) {
    //中心点坐标为200,200 边长为100
    Rect rect = Rect.fromCircle(center: Offset(10.0, 20.0), radius: 100.0);
    //根据矩形创建一个角度为10的圆角矩形
    RRect rrect = RRect.fromRectAndRadius(rect, Radius.circular(20.0));
    //开始绘制圆角矩形
    canvas.drawRRect(rrect, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}



class UiDemo extends StatefulWidget {
  @override
  UiDemoState createState() => new UiDemoState();
}

class UiDemoState extends State<UiDemo> {

  List<Container> _buildGridTitleList(int count) {
    //index为列表项索引
    return List<Container>.generate(
      count,
          (int index) => Container(
        //根据索引添加图片路径
        child: Image.asset('images/${index + 1}.jpeg'),
      ),
    );
  }


  //渲染GridView
  Widget buildGrid() {
    return GridView.extent(
      maxCrossAxisExtent: 150.0,
      //次轴的宽度
      padding: const EdgeInsets.all(4.0),
      //上下左右内边距
      mainAxisSpacing: 4.0,
      //主轴元素间距
      crossAxisSpacing: 4.0,
      //次轴元素间距
      children: _buildGridTitleList(9), //添加9个元素
    );
  }

  Widget buildIndexStack(int index) {
    var stack = IndexedStack(
      index: index, //设置索引为1就只显示文本内容了
      alignment: const FractionalOffset(0.2, 0.2),
      children: <Widget>[
        //索引为0
        CircleAvatar(
          backgroundImage: new AssetImage('images/1.jpeg'),
          radius: 100.0,
        ),
        //索引为1
        Container(
          decoration: BoxDecoration(
            color: Colors.black38,
          ),
          child: Text(
            '我是超级飞侠',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );

    return stack;
  }

  var alignmentStack = Stack(
    //子组件左上角对齐
    alignment: Alignment.center,
    children: <Widget>[
      //底部添加一个头像
      CircleAvatar(
        backgroundImage: AssetImage('images/1.jpeg'),
        radius: 100.0,
      ),
      //上面加一个容器 容器里再放一个文本
      Container(
        decoration: BoxDecoration(
          color: Colors.black38,
        ),
        child: Text(
          '我是超级飞侠',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    ],
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        color: Colors.amber,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Container(
              height: 20,
              decoration: BoxDecoration(
                //上下左右边框设置为宽度10.0 颜色为蓝灰色
                border: Border.all(width: 10.0, color: Colors.blueGrey),
                //上下左右边框弧度设置为8.0
                borderRadius:
                const BorderRadius.all(const Radius.circular(8.0)),
              ),
              margin: const EdgeInsets.all(8.0),
              child: Image.asset('images/1.jpeg'),
            ),
            Container(
              height: 100,
              child: Stack(
                children: <Widget>[
                  //添加网络图片
                  Image.network(
                    'https://flutter.dev/assets/404/dash_nest-c64796b59b65042a2b40fae5764c13b7477a592db79eaf04c86298dcb75b78ea.png',
                    fit: BoxFit.fitHeight,
                  ),
                  //设置定位布局
                  Positioned(
                      bottom: 50.0,
                      right: 50.0,
                      child: new Text(
                        'hi flutter',
                        style: TextStyle(
                          fontSize: 36.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'serif',
                          color: Colors.white,
                        ),
                      )),
                ],
              ),
            ),
            Container(
              height: 50,
              child: alignmentStack,
            ),
            SizedBox(
              //固定宽为200.0 高为300.0
              width: 10.0,
              height: 50.0,
              child: const Card(
                child: Text(
                  'SizedBox',
                  style: TextStyle(
                    fontSize: 36.0,
                  ),
                ),
              ),
            ),

            Container(
              height: 140,
              child: Center(
                child: new Text(
                  '你好 flutter',
                  style: new TextStyle(fontFamily: 'myfont', fontSize: 36.0),
                ),
              ),
            ),
            Container(
              height: 100,
              child: Center(
                //圆形剪裁
                child: ClipOval(
                  //固定大小
                  child: SizedBox(
                    width: 80.0,
                    height: 80.0,
                    //添加图片
                    child: Image.asset(
                      "images/4.jpeg",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 100,
              child: Center(
                child: ClipPath(
                  clipper: TriangleCliper(), //指定自定义三角形Clipper
                  child: SizedBox(
                    width: 100.0,
                    height: 100.0,
                    child: Image.asset(
                      "images/8.jpeg",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 300,
              color: Colors.cyanAccent,
              child: ClipRect(
                //指定自定义Clipper
                clipper: RectClipper(),
                child: SizedBox(
                  width: 300.0,
                  height: 200.0,
                  child: Image.asset(
                    "images/8.jpeg",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Container(
              height: 80,
              child: Center(
                //圆角矩形
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    //圆角弧度，值越大弧度越大
                      Radius.circular(10.0)),
                  //固定大小
                  child: SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: Image.asset(
                      "images/8.jpeg",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: RotatedBox(
                quarterTurns: 2, //旋转次数，一次为90度
                child: Text(
                  'RotatedBox旋转盒子',
                  style: TextStyle(fontSize: 28.0),
                ),
              ),
            ),
            Center(
              child: Opacity(
                opacity: 0.3, //不透明度设置为0.3
                child: Container(
                  width: 250.0,
                  height: 50.0,
                  //添加装饰器
                  decoration: BoxDecoration(
                    color: Colors.black, //背景色设置为纯黑
                  ),
                  child: Text(
                    '不透明度为0.3',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                width: 100.0,
                height: 100.0,
                margin: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  //边框阴影效果 可添加多个BoxShadow 是一种组合效果
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey, //阴影颜色
                      blurRadius: 8.0, //模糊值
                      spreadRadius: 8.0, //扩展阴影半径
                      offset: Offset(-1.0, 1.0), //x/y方向偏移量
                    ),
                  ],
                ),
                child: Text(
                  'BoxShadow阴影效果',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28.0,
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                width: 260.0,
                height: 260.0,
                //装饰器
                decoration: BoxDecoration(
                  //背景色
                  color: Colors.white,
                  //添加所有的边框,颜色为灰色，宽度为4.0
                  border: Border.all(color: Colors.grey, width: 4.0),
                  //添加边框弧度，这样会有一个圆角效果
                  borderRadius: BorderRadius.circular(36.0),
                  //添加背景图片
                  image: DecorationImage(
                    image: ExactAssetImage('images/1.jpeg'), //添加image属性
                    fit: BoxFit.cover, //填充类型
                  ),
                ),
              ),
            ),
            Container(
              height: 200,
              child: Center(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    //环形渐变

                    gradient: RadialGradient(
                      //中心点偏移量,x和y均为0.0表示在正中心位置
                      center: const Alignment(-0.0, -0.0),
                      //圆形半径
                      radius: 0.50,
                      //渐变颜色数据集
                      colors: <Color>[
                        Colors.red,
                        Colors.green,
                        Colors.blue,
                        Colors.grey,
                      ],
                    ),
                  ),
                  child: Container(
                    width: 280.0,
                    height: 280.0,
                    child: new Center(
                      child: Text(
                        'RadialGradient环形渐变效果',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 28.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 200,
              child: Center(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    //线性渐变
                    gradient: LinearGradient(
                      begin: const FractionalOffset(0.5, 0.0), //起始偏移量
                      end: const FractionalOffset(1.0, 1.0), //终止偏移量
                      //渐变颜色数据集
                      colors: <Color>[
                        Colors.red,
                        Colors.green,
                        Colors.blue,
                        Colors.grey,
                      ],
                    ),
                  ),
                  child: Container(
                    width: 180.0,
                    height: 180.0,
                    child: Center(
                      child: Text(
                        'LinearGradient线性渐变效果',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 28.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: 150.0,
              height: 150,
              color: Colors.amber,
              child: Center(
                  child: SizedBox(
                    width: 150.0,
                    height: 150.0,
                    child: Container(
                      color: Colors.deepPurple,
                      child: CustomPaint(
                        painter: LinePainter(),
                        child: Center(
                          child: Text(
                            '绘制圆',
                            style: const TextStyle(
                              fontSize: 3.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
            ),
            Offstage(
              offstage: true,
              child: LimitedBox(
                maxHeight: 40,
                maxWidth: 10.0, //设置最大宽度 限定child在此范围内
                child: Container(
                  height: 50,
                  color: Colors.red,
                  width: 20.0,
                ),
              ),
            ),
            Container(
              width: 100.0,
              height: 100.0,
              //容器内边距上下左右设置为60.0
              padding: EdgeInsets.all(6.0),
              //添加边框
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.green,
                  width: 8.0,
                ),
              ),
              //添加容器 内框
              child: Container(
                width: 200.0,
                height: 200.0,
                //添加边框
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.blue,
                    width: 8.0,
                  ),
                ),
                //添加图标
                child: FlutterLogo(),
              ),
            ),
            Container(
              color: Colors.deepPurple,
              height: 100,
              child: Wrap(
                spacing: 8.0, // Chip之间的间距大小
                runSpacing: 4.0, // 行之间的间距大小
                children: <Widget>[
                  Container(
                    //添加圆形头像
                    child: CircleAvatar(
                        backgroundColor: Colors.lightGreen.shade800,
                        child: Text(
                          '西门',
                          style: TextStyle(fontSize: 10.0),
                        )),
                  ),
                  Container(
                    child: CircleAvatar(
                        backgroundColor: Colors.lightBlue.shade700,
                        child: Text(
                          '司空',
                          style: TextStyle(fontSize: 10.0),
                        )),
                  ),
                  Container(
                    child: CircleAvatar(
                        backgroundColor: Colors.orange.shade800,
                        child: Text(
                          '婉清',
                          style: TextStyle(fontSize: 10.0),
                        )),
                  ),
                  Container(
                    child: CircleAvatar(
                        backgroundColor: Colors.blue.shade900,
                        child: Text(
                          '一郎',
                          style: TextStyle(fontSize: 10.0),
                        )),
                  ),
                ],
              ),
            ),
            Container(
              height: 400,
              child: Center(
                //添加表格
                child: Table(
                  //设置表格有多少列,并且指定列宽
                  columnWidths: const <int, TableColumnWidth>{
                    //指定索引及固定列宽
                    0: FixedColumnWidth(100.0),
                    1: FixedColumnWidth(60.0),
                    2: FixedColumnWidth(80.0),
                    3: FixedColumnWidth(100.0),
                  },
                  //设置表格边框样式
                  border: TableBorder.all(
                      color: Colors.black38,
                      width: 2.0,
                      style: BorderStyle.solid),
                  children: const <TableRow>[
                    //添加第一行数据
                    TableRow(
                      children: <Widget>[
                        Text('姓名'),
                        Text('性别'),
                        Text('年龄'),
                        Text('身高'),
                      ],
                    ),
                    //添加第二行数据
                    TableRow(
                      children: <Widget>[
                        Text('张三'),
                        Text('男'),
                        Text('26'),
                        Text('172'),
                      ],
                    ),
                    //添加第三行数据
                    TableRow(
                      children: <Widget>[
                        Text('李四'),
                        Text('男'),
                        Text('28'),
                        Text('178'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 400,
              child: Center(
                //父容器 作为背景
                child: Container(
                  //背景颜色
                  color: Colors.grey,
                  //矩阵转换
                  child: Transform(
                    //对齐方式
                    alignment: Alignment.topRight,
                    //设置旋转值
                    transform: Matrix4.rotationZ(0.3),
                    //被旋转容器
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      color: const Color(0xFFE8581C),
                      child: const Text('Transform矩阵转换'),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.green,
              width: 200.0,
              height: 200.0,
              padding: const EdgeInsets.all(50.0),
              child: OverflowBox(
                alignment: Alignment.topLeft,
                maxWidth: 400.0,
                maxHeight: 400.0,
                child: Container(
                  color: Colors.red,
                  width: 300.0,
                  height: 210.0,
                ),
              ),
            ),
            Container(
              height: 50,
              child: buildIndexStack(0),
            ),
            Container(
              height: 50,
              child: buildIndexStack(1),
            ),
            Container(
              height: 100,
              child: buildGrid(),
            ),
            Container(
              color: Colors.grey,
              width: 50.0,
              height: 50.0,
              //缩放布局
              child: FittedBox(
                //宽高等比填充
                fit: BoxFit.contain,
                //对齐属性 左上角对齐
                alignment: Alignment.center,
                //内部容器
                child: Container(
                  color: Colors.deepOrange,
                  child: Text("缩放布局"),
                ),
              ),
            ),
            Container(
              color: Colors.blueGrey,
              height: 200.0,
              width: 150.0,
              child: FractionallySizedBox(
                alignment: Alignment.topRight, //元素左上角对齐
                widthFactor: 0.8, //宽度因子
                heightFactor: 0.8, //高度因子
                child: Container(
                  color: Colors.redAccent,
                ),
              ),
            ),
            ConstrainedBox(
              //设置限定值
              constraints: const BoxConstraints(
                minWidth: 20.0,
                minHeight: 20.0,
                maxWidth: 50.0,
                maxHeight: 50.0,
              ),
              //子容器
              child: Container(
                width: 800.0,
                height: 800.0,
                color: Colors.green,
              ),
            ),
            Container(
              height: 140,
              color: Colors.cyanAccent,
              child: Row(
                //水平等间距排列子组件
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  //设置基准线
                  Baseline(
                    baseline: 20.0,
                    //对齐字符底部水平线
                    baselineType: TextBaseline.alphabetic,
                    child: Text(
                      'AaBbCc',
                      style: TextStyle(
                        fontSize: 18.0,
                        textBaseline: TextBaseline.alphabetic,
                      ),
                    ),
                  ),
                  Baseline(
                    baseline: 80.0,
                    baselineType: TextBaseline.alphabetic,
                    child: Container(
                      width: 40.0,
                      height: 40.0,
                      color: Colors.green,
                    ),
                  ),
                  Baseline(
                    baseline: 80.0,
                    baselineType: TextBaseline.alphabetic,
                    child: Text(
                      'DdEeFf',
                      style: TextStyle(
                        fontSize: 26.0,
                        textBaseline: TextBaseline.alphabetic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 200,
              child: Column(
                children: <Widget>[
                  Text('Flutter'),
                  Text('垂直布局'),
                  //添加图标
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: const FlutterLogo(),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 500,
              child: Stack(children: <Widget>[
                //左上角
                Align(
                  //对齐属性 确定位置
                  alignment: FractionalOffset(0.0, 0.0),
                  //添加图片
                  child: Image.asset(
                    'images/1.jpeg',
                    width: 128.0,
                    height: 128.0,
                  ),
                ),
                //右上角
                Align(
                  alignment: FractionalOffset(1.0, 0.0),
                  child: Image.asset(
                    'images/1.jpeg',
                    width: 128.0,
                    height: 128.0,
                  ),
                ),
                //水平垂直方向居中
                Align(
                  alignment: FractionalOffset.center,
                  child: Image.asset(
                    'images/3.jpeg',
                    width: 128.0,
                    height: 128.0,
                  ),
                ),
                //左下角
                Align(
                  alignment: FractionalOffset.bottomLeft,
                  child: Image.asset(
                    'images/2.jpeg',
                    width: 128.0,
                    height: 128.0,
                  ),
                ),
                //右下角
                Align(
                  alignment: FractionalOffset.bottomRight,
                  child: Image.asset(
                    'images/2.jpeg',
                    width: 128.0,
                    height: 128.0,
                  ),
                ),
              ]),
            ),
            Container(height: 20, color: Colors.red),
            Container(
              height: 200.0,
              child: AspectRatio(
                aspectRatio: 2.5, //比例可以调整
                child: Container(
                  color: Colors.green,
                ),
              ),
            ),
            Container(
              width: 160.0,
              height: 50.0,
              color: Colors.lightBlue,
              child: Center(
                child: Text("test"),
              ),
            ),
            Container(
              width: 120.0,
              height: 100.0,
              color: Colors.red,
              child: Center(
                child: IconButton(
                  icon: Icon(
                    Icons.volume_down,
                    size: 48.0,
                  ),
                ),
              ),
            ),
            Container(
              width: 120.0,
              height: 50.0,
              child: Center(
                child: Image.network(
                  'https://flutter.dev/assets/404/dash_nest-c64796b59b65042a2b40fae5764c13b7477a592db79eaf04c86298dcb75b78ea.png',
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Phone'),
            ),
            Center(
              //添加容器
              child: Container(
                width: 200.0,
                height: 50.0,
                //添加边框装饰效果
                decoration: BoxDecoration(
                  color: Colors.red,
                  //设置上下左右四个边框样式
                  border: new Border.all(
                    color: Colors.grey, //边框颜色
                    width: 8.0, //边框粗细
                  ),
                  borderRadius: const BorderRadius.all(
                      const Radius.circular(8.0)), //边框的弧度
                ),
                child: Text(
                  'Flutter',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28.0),
                ),
              ),
            ),
            Text(
              '红色字体+黑色删除线+18号+斜体+粗体',
              //文本样式
              style: TextStyle(
                //字体颜色
                color: const Color(0xffff0000),
                //文本装饰器(删除线)
                decoration: TextDecoration.lineThrough,
                //文本装饰器颜色(删除线颜色)
                decorationColor: const Color(0xff000000),
                //字体大小
                fontSize: 18.0,
                //字体样式 是否斜体
                fontStyle: FontStyle.italic,
                //字体粗细
                fontWeight: FontWeight.bold,
                //文字间距
                letterSpacing: 2.0,
              ),
            ),
            Text(
              '橙色+下划线+24号',
              style: TextStyle(
                color: const Color(0xffff9900),
                decoration: TextDecoration.underline,
                fontSize: 24.0,
              ),
            ),
            Text(
              '上划线+虚线+23号',
              style: TextStyle(
                decoration: TextDecoration.overline,
                decorationStyle: TextDecorationStyle.dashed,
                fontSize: 23.0,
                //字体样式
                fontStyle: FontStyle.normal,
              ),
            ),
            Text(
              '23号+斜体+加粗+字间距6',
              style: TextStyle(
                fontSize: 23.0,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                letterSpacing: 6.0,
              ),
            ),
            Container(
              //顶部外边距为20
              margin: EdgeInsets.symmetric(vertical: 20.0),
              //设定容器高度
              height: 200.0,
              child: ListView(
                //设置水平方向排列
                scrollDirection: Axis.horizontal,
                //添加子元素
                children: <Widget>[
                  //每个Container即为一个列表项
                  Container(
                    width: 160.0,
                    color: Colors.lightBlue,
                  ),
                  Container(
                    width: 160.0,
                    color: Colors.amber,
                  ),
                  //此容器里"水平"及"列表"文字为垂直布局
                  Container(
                    width: 160.0,
                    color: Colors.green,
                    //垂直布局
                    child: Column(
                      children: <Widget>[
                        Text(
                          '水平',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 36.0,
                          ),
                        ),
                        Text(
                          '列表',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 36.0,
                          ),
                        ),
                        Icon(Icons.list),
                      ],
                    ),
                  ),
                  Container(
                    width: 160.0,
                    color: Colors.deepPurpleAccent,
                  ),
                  Container(
                    width: 160.0,
                    color: Colors.black,
                  ),
                  Container(
                    width: 160.0,
                    color: Colors.pinkAccent,
                  ),
                ],
              ),
            ),
            Container(
              //添加内边距
              padding: const EdgeInsets.all(16.0),
              //添加Form表单
              child: Form(
                child: Column(
                  children: <Widget>[
                    //文本输入框表单组件
                    TextFormField(
                      //装饰器
                      decoration: InputDecoration(
                        //提示文本
                        labelText: '请输入用户名',
                      ),
                      //接收输入值
                      onSaved: (value) {
                        // userName = value;
                      },
                      onFieldSubmitted: (value) {},
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: '请输入密码',
                      ),
                      obscureText: true,
                      //验证表单方法
                      validator: (value) {
                        return value.length < 6 ? "密码长度不够6位" : null;
                      },
                      onSaved: (value) {
                        // password = value;
                      },
                    ),
                  ],
                ),
              ),
            ),
            //限定容器大小
            SizedBox(
              width: 340.0,
              height: 42.0,

              //添加登录按钮
              child: RaisedButton(
                onPressed: () {
                  // showAlertDialog(context);
                },
                child: Text(
                  '点我弹窗',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

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
  void didUpdateWidget(UiDemo oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}