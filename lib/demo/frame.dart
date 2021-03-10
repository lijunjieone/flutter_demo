import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/strings.dart';
import 'package:get/get.dart';



class SmallFrame extends StatefulWidget {
  @override
  SmallFrameState createState() => new SmallFrameState();
}

class SmallFrameState extends State<SmallFrame> {
  var card = SizedBox(
    //限定高度
    height: 250.0,
    //添加Card组件
    child: Card(
      //垂直布局
      child: Column(
        children: <Widget>[
          ListTile(
            //标题
            title: Text(
              '深圳市南山区深南大道',
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
            //子标题
            subtitle: Text('XX有限公司'),
            //左侧图标
            leading: Icon(
              Icons.home,
              color: Colors.lightBlue,
            ),
          ),
          //分隔线
          Divider(),
          ListTile(
            title: Text(
              '深圳市罗湖区沿海大道',
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
            subtitle: Text('XX培训机构'),
            leading: Icon(
              Icons.school,
              color: Colors.lightBlue,
            ),
          ),
          Divider(),
        ],
      ),
    ),
  );

  var flat = Container(
    height: 30,
    child: Center(
      child: FlatButton(
        onPressed: () {
          // Scaffold.of(context).showSnackBar(SnackBar(
          //   content: Text("你点击了FloatingActionButton"),
          // ));
        },
        child: Text(
          'FlatButton',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    ),
  );

  String _selectedValue;

  PopupMenuButton _popMenu() {
    return PopupMenuButton<String>(
      itemBuilder: (context) => _getPopupMenu(context),
      onSelected: (String value) {
        print('onSelected');
        _selectValueChange(value);
      },
      onCanceled: () {
        print('onCanceled');
      },
//      child: RaisedButton(onPressed: (){},child: Text('选择'),),
      icon: Icon(Icons.shopping_basket),
    );
  }

  _selectValueChange(String value) {
    setState(() {
      _selectedValue = value;
    });
  }

  _showMenu(BuildContext context) {
    final RenderBox button = context.findRenderObject();
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset(0, 0), ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
    var pop = _popMenu();
    showMenu<String>(
      context: context,
      items: pop.itemBuilder(context),
      position: position,
    ).then<void>((String newValue) {
      if (!mounted) return null;
      if (newValue == null) {
        if (pop.onCanceled != null) pop.onCanceled();
        return null;
      }
      if (pop.onSelected != null) pop.onSelected(newValue);
    });
  }

  _getPopupMenu(BuildContext context) {
    return <PopupMenuEntry<String>>[
      PopupMenuItem<String>(
        value: '语文',
        child: Text('语文'),
      ),
      PopupMenuItem<String>(
        value: '数学',
        child: Text('数学'),
      ),
      PopupMenuItem<String>(
        value: '英语',
        child: Text('英语'),
      ),
      PopupMenuItem<String>(
        value: '生物',
        child: Text('生物'),
      ),
      PopupMenuItem<String>(
        value: '化学',
        child: Text('化学'),
      ),
    ];
  }

  final List<Tab> myTabs = <Tab>[
    Tab(text: '选项卡一'),
    Tab(text: '选项卡二'),
  ];

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
                // Scaffold.of(context).showSnackBar(SnackBar(
                //   content: Text("你点击了FloatingActionButton"),
                // ));
                _showMenu(context);
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
              child: card,
            ),
            flat,
            Container(
              height: 40,
              child: Center(
                  child: IconButton(
                    icon: Icon(Icons.label, size: 48),
                    onPressed: () {
                      print("show Menu");
                      _showMenu(context);
                    },
                  )),
            ),
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
