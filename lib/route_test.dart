import 'package:flutter/material.dart';

import 'matadata/Todo.dart';


@Todo("sy", "dev functions")
class TestRoute extends StatelessWidget {

  Function makeAdder(num addBy) {
    return (num i) => addBy + i;
  }

// Initial, broken implementation.
  int sort(Object a, Object b) => 0;

  @override
  Widget build(BuildContext context) {
    var a = 10;
    var b = 0;
    a = a ~/ b;
    //获取路由参数
//    var time = ModalRoute.of(context).settings.arguments as int;
    var time = DateTime.now().millisecondsSinceEpoch;
    var timeText = DateTime.fromMicrosecondsSinceEpoch(time);
    return Scaffold(
      appBar: AppBar(
        title: Text("Test Route Page"),
      ),
      body: Center(
        child: Text("now: $timeText"),
      ),
    );
  }
}