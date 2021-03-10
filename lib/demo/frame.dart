import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/strings.dart';
import 'package:get/get.dart';



class SmallFrame extends StatefulWidget {
  @override
  SmallFrameState createState() => new SmallFrameState();
}

class SmallFrameState extends State<SmallFrame> {




  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    controller.addListener(() {
      print('你输入的内容为: ${controller.text}');
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('组件例子'),
      ),
      floatingActionButton: Builder(builder: (BuildContext context) {
        return FloatingActionButton(
          child: const Icon(Icons.add),
          //提示信息
          tooltip: "请点击FloatingActionButton",
          //前景色为白色
          foregroundColor: Colors.white,
          //背景色为蓝色
          backgroundColor: Colors.blue,
          //未点击阴影值
          elevation: 7.0,
          //点击阴影值
          highlightElevation: 14.0,
          onPressed: () {
            //点击回调事件 弹出一句提示语句
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("你点击了FloatingActionButton"),
            ));
          },
          mini: false,
          //圆形边
          shape: CircleBorder(),
          isExtended: false,
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      //居中放置 位置可以设置成左中右
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            //设置用户信息 头像、用户名、Email等
            UserAccountsDrawerHeader(
              accountName: new Text(
                "玄微子",
              ),
              accountEmail: new Text(
                "xuanweizi@163.com",
              ),
              //设置当前用户头像
              currentAccountPicture: new CircleAvatar(
                backgroundImage: AssetImage("images/2.jpeg"),
              ),
              onDetailsPressed: () {},
              //属性本来是用来设置当前用户的其他账号的头像 这里用来当QQ二维码图片展示
              otherAccountsPictures: <Widget>[
                new Container(
                  child: Image.asset('images/code.jpeg'),
                ),
              ],
            ),
            ListTile(
              leading: new CircleAvatar(child: Icon(Icons.color_lens)), //导航栏菜单
              title: Text('个性装扮'),
            ),
            ListTile(
              leading: new CircleAvatar(child: Icon(Icons.photo)),
              title: Text('我的相册'),
            ),
            ListTile(
              leading: new CircleAvatar(child: Icon(Icons.wifi)),
              title: Text('免流量特权'),
              onTap: () {
              },
            ),
          ],
        ),
      ),
      body: Container(
        child: ListView(
          children: [


            Container(
                color: Colors.amber,
                margin: EdgeInsets.symmetric(vertical: 20.0),
                height: 40,
                child: Center(
                  child: _widgetOptions.elementAt(_selectedIndex), //居中显示某一个文本
                )),

            Container(
              height: 40,
              child: Center(
                child: CupertinoActivityIndicator(
                  radius: 10.0, //值越大加载的图形越大
                ),
              ),
            ),
            Container(
              height: 50,
              child: Center(
                //Cupertino风格按钮
                child: CupertinoButton(
                  child: Text(
                    //按钮label
                    'CupertinoButton',
                  ),
                  color: Colors.blue, //按钮颜色
                  onPressed: () {}, //按下事件回调
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          //底部导航按钮项 包含图标及文本
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: '信息'),
          BottomNavigationBarItem(icon: Icon(Icons.contacts), label: '通讯录'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: '发现'),
        ],
        currentIndex: _selectedIndex, //当前选中项的索引
        fixedColor: Colors.deepPurple, //选项中项的颜色
        onTap: _onItemTapped, //选择按下处理
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //当前选中项的索引
  int _selectedIndex = 1;

  //导航栏按钮选中对应数据
  final _widgetOptions = [
    Text('Index 0: 信息'),
    Text('Index 1: 通讯录'),
    Text('Index 2: 发现'),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
