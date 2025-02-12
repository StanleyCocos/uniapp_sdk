import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_uniapp_sdk/flutter_uniapp_sdk.dart';
import 'package:path_provider/path_provider.dart';

const String appId = '__UNI__611D597';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _flutterUniappSdkPlugin = FlutterUniappSdk();

  String _appPath = '';

  @override
  void initState() {
    init();
    super.initState();
  }

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
                  // init();
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

  void init() async {
    _appPath = await copyAssetToRealPath();
    _flutterUniappSdkPlugin.install(id: appId, path: _appPath);
  }

  Future<String> copyAssetToRealPath() async {
    // 获取应用的文档目录路径
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;

    // 获取assets中的文件内容
    final ByteData data = await rootBundle.load('assets/${appId}.wgt');
    final List<int> bytes = data.buffer.asUint8List();

    // 将文件写入到设备的文档目录中
    final file = File('$path/$appId.wgt');
    await file.writeAsBytes(bytes);
    print('File copied to: ${file.path}');
    return file.path;
  }
}
