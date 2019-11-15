import 'package:flutter/material.dart';

import 'matadata/Todo.dart';

@Todo("sy", "dev functions")
class TestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new TestRouteState();
}

class TestRouteState extends State<TestRoute> {
  bool _switchSelected = true; //维护单选开关状态
  bool _checkboxSelected = true; //维护复选框状态
  FocusNode focusNode = new FocusNode();
  @override
  Widget build(BuildContext context) {
//    var a = 10;
//    var b = 0;
//    a = a ~/ b;
    //获取路由参数
//    var time = ModalRoute.of(context).settings.arguments as int;

    return Scaffold(
      appBar: AppBar(
        title: Text("Test Route Page"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Wrap(
              children: <Widget>[
                Text("Hello, world!" * 5),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.accessible,
                  color: Colors.blue,
                ),
                Icon(
                  Icons.error,
                  color: Colors.blue,
                ),
                Icon(
                  Icons.fingerprint,
                  color: Colors.blue,
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Switch(
                  value: _switchSelected, //当前状态
                  onChanged: (value) {
                    //重新构建页面
                    setState(() => _switchSelected = value);
                  },
                ),
                Checkbox(
                  value: _checkboxSelected,
                  activeColor: Colors.red, //选中时的颜色
                  onChanged: (value) {
                    setState(() {
                      _checkboxSelected = value;
                    });
                  },
                ),
              ],
            ),
  //          FormTest(),
//            LinearProgressIndicator(
//              value: 0.4,
//              backgroundColor: Colors.grey[200],
//              valueColor: AlwaysStoppedAnimation(Colors.blue),
//            ),
//            ProgressRoute(),
            CircularProgressIndicator(
              value: 0.6,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation(Colors.blue),
            ),
            Container(
              width: 80,
              height: 80,
              color: Colors.blue[50],
              child: Align(
                alignment: Alignment.center,
                child: FlutterLogo(
                  size: 40,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              constraints: BoxConstraints.tightFor(width: 100.0, height: 75.0), //卡片大小
              decoration: BoxDecoration(//背景装饰
                  gradient: RadialGradient( //背景径向渐变
                      colors: [Colors.red, Colors.orange],
                      center: Alignment.topLeft,
                      radius: .98
                  ),
                  boxShadow: [ //卡片阴影
                    BoxShadow(
                        color: Colors.black54,
                        offset: Offset(2.0, 2.0),
                        blurRadius: 4.0
                    )
                  ]
              ),
//              transform: Matrix4.rotationZ(.2), //卡片倾斜变换
              alignment: Alignment.center, //卡片内文字居中
              child: Text( //卡片文字
                "5.20", style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            )
          ],
        )
      ),
    );
  }
}

class FormTest extends StatefulWidget {
  @override
  _FormTestRouteState createState() => new _FormTestRouteState();
}

class ProgressRoute extends StatefulWidget {
  @override
  _ProgressRouteState createState() => _ProgressRouteState();
}

class _ProgressRouteState extends State<ProgressRoute>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    //动画执行时间3秒
    _animationController =
    new AnimationController(vsync: this, duration: Duration(seconds: 3));
    _animationController.forward();
    _animationController.addListener(() => setState(() => {}));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(16),
          child: LinearProgressIndicator(
            backgroundColor: Colors.grey[200],
            valueColor: ColorTween(begin: Colors.grey, end: Colors.blue)
                .animate(_animationController), // 从灰色变成蓝色
            value: _animationController.value,
          ),
        )
      ],
    );
  }
}

class _FormTestRouteState extends State<FormTest> {
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  GlobalKey _formKey= new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey, //设置globalKey，用于后面获取FormState
//      autovalidate: true, //开启自动校验
      child: Column(
        children: <Widget>[
          TextFormField(
              autofocus: true,
              controller: _unameController,
              decoration: InputDecoration(
                  labelText: "用户名",
                  hintText: "用户名或邮箱",
                  icon: Icon(Icons.person)
              ),
              // 校验用户名
              validator: (v) {
                return v
                    .trim()
                    .length > 0 ? null : "用户名不能为空";
              }

          ),
          TextFormField(
              controller: _pwdController,
              decoration: InputDecoration(
                  labelText: "密码",
                  hintText: "您的登录密码",
                  icon: Icon(Icons.lock)
              ),
              obscureText: true,
              //校验密码
              validator: (v) {
                return v
                    .trim()
                    .length > 5 ? null : "密码不能少于6位";
              }
          ),
          // 登录按钮
          Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    padding: EdgeInsets.all(15.0),
                    child: Text("登录"),
                    color: Theme
                        .of(context)
                        .primaryColor,
                    textColor: Colors.white,
                    onPressed: () {
                      //在这里不能通过此方式获取FormState，context不对
                      //print(Form.of(context));

                      // 通过_formKey.currentState 获取FormState后，
                      // 调用validate()方法校验用户名密码是否合法，校验
                      // 通过后再提交数据。
                      if((_formKey.currentState as FormState).validate()){
                        //验证通过提交数据
                      }
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
