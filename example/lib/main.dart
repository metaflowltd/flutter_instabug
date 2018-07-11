import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_instabug/flutter_instabug.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _initInstabugResponse = 'Unknown';

  String _identifyResponse = "";

  @override
  void initState() {
    super.initState();
    initInstabug();
  }

  Future<void> initInstabug() async {
    String initResponse;
    try {
      initResponse =
          await FlutterInstabug.startInstabug("<INSTABUG APP TOKEN>", invocationEvent: IBGInvocationEvent.screenshot);
    } on PlatformException {
      initResponse = 'Failed to init Instabug.';
    }

    if (!mounted) return;

    setState(() {
      _initInstabugResponse = initResponse;
    });
  }

  Future<void> identifyInstabugUser() async {
    String identifyResponse;
    try {
      identifyResponse = await FlutterInstabug.identifyUser("john.doe@example.com", userName: "John Doe");
    } on PlatformException {
      identifyResponse = 'Failed to identify user on Instabug.';
    }

    if (!mounted) return;

    setState(() {
      _identifyResponse = identifyResponse;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Instabug Plugin Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('$_initInstabugResponse'),
              RaisedButton(child: Text("Identify user on Instabug"), onPressed: identifyInstabugUser),
              Text('$_identifyResponse\n'),
            ],
          ),
        ),
      ),
    );
  }
}
