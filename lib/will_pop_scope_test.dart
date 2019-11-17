import 'package:flutter/material.dart';

class WillPopScopeRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new WillPopScopeState();
  }
  
}

class WillPopScopeState extends State<WillPopScopeRoute> {
  DateTime _lastClickTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Center(
        child: Text("Double click in 1 second to exit."),
      ),
      onWillPop: () async {
        var now = DateTime.now();
        if (_lastClickTime == null || now.difference(_lastClickTime).inMilliseconds > 1000) {
          _lastClickTime = now;
          return false;
        }
        return true;
      },
    );
  }

}