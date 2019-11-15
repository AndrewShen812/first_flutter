import 'package:flutter/material.dart';

class NaviPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NaviPageState();
  }
  
}

class _NaviPageState extends State<NaviPage> with SingleTickerProviderStateMixin {

  int _bottomNaviIndex = 0;
  List<String> _tabs = ["公众号", "每日一问", "项目", "TODO"];
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (ctx) {
          return IconButton(
              icon: Icon(Icons.dashboard, color: Colors.white),
              onPressed: () {
                Scaffold.of(ctx).openDrawer();
              });
        }),
        title: Text("Navi demo"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.share, color: Colors.white,),
              onPressed: () {

              })
        ],
        bottom: TabBar(
          tabs: _tabs.map((e) => Tab(text: e)).toList(),
          controller: _tabController
        ),
      ),
      // 左侧抽屉
      drawer: _LeftDrawer(),
      // 右侧抽屉
//      endDrawer: ,
      // 配合 TabBar 使用的组件
      body: TabBarView(
        controller: _tabController,
        physics: NeverScrollableScrollPhysics(),
        children: _tabs.map((e) {
          if (e == "公众号") {
            return GridView(
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 110.0,
                  childAspectRatio: 1.0 //宽高比为2
              ),
              children: <Widget>[
                Icon(Icons.ac_unit),
                Icon(Icons.airport_shuttle),
                Icon(Icons.all_inclusive),
                Icon(Icons.beach_access),
                Icon(Icons.cake),
                Icon(Icons.free_breakfast),
              ],
            );
          } else if ("每日一问" == e) {
            return CustomScrollViewTestRoute();
          } else {
            return Container(
              alignment: Alignment.center,
              child: Text(e, textScaleFactor: 4),
            );
          }
        }).toList()
      ),
      // 底部导航栏
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem> [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
          BottomNavigationBarItem(icon: Icon(Icons.business), title: Text("Company"))
        ],
        currentIndex: _bottomNaviIndex,
        onTap: (index) {
          setState(() {
            _bottomNaviIndex = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {

          }),
    );
  }

}

class CustomScrollViewTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //因为本路由没有使用Scaffold，为了让子级Widget(如Text)使用
    //Material Design 默认的样式风格,我们使用Material作为本路由的根。
    return Material(
      child: CustomScrollView(
        slivers: <Widget>[
          //AppBar，包含一个导航栏
          SliverAppBar(
            pinned: true,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Demo'),
              background: Image.asset(
                "./images/avatar.png", fit: BoxFit.cover,),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: new SliverGrid( //Grid
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, //Grid按两列显示
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 4.0,
              ),
              delegate: new SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  //创建子widget
                  return new Container(
                    alignment: Alignment.center,
                    color: Colors.cyan[100 * (index % 9)],
                    child: new Text('grid item $index'),
                  );
                },
                childCount: 20,
              ),
            ),
          ),
          //List
          new SliverFixedExtentList(
            itemExtent: 50.0,
            delegate: new SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  //创建列表项
                  return new Container(
                    alignment: Alignment.center,
                    color: Colors.lightBlue[100 * (index % 9)],
                    child: new Text('list item $index'),
                  );
                },
                childCount: 50 //50个列表项
            ),
          ),
        ],
      ),
    );
  }
}

class _LeftDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.person),
            title: Text("登录"),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("设置"),
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text("关于"),
          )
        ],
      ),
    );
  }

}