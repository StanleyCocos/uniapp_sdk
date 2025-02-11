import 'package:flutter/material.dart';
import 'package:flutter_uniapp_sdk/flutter_uniapp_sdk.dart';

const String appId = 'Flutter Uniapp SDK Example';


void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _flutterUniappSdkPlugin = FlutterUniappSdk();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              TextButton(
                onPressed: () {
                  _flutterUniappSdkPlugin.install(
                    id: appId,
                    path: 'https://www.51h5.com/demo.zip',
                  );
                },
                child: const Text('部署小程序'),
              ),

              TextButton(
                onPressed: () {
                  _flutterUniappSdkPlugin.open(appId);
                },
                child: const Text('启动小程序'),
              ),


              TextButton(
                onPressed: () {
                  _flutterUniappSdkPlugin.preload(appId);
                },
                child: const Text('预加载小程序'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
