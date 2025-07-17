
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uniapp_sdk/uniapp_sdk.dart';

String appId = '__UNI__74D58BF';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _uniappSdkPlugin = UniappSdk();

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
              onPressed: () async {
                var result = await _uniappSdkPlugin.open(appId);
                print("open--> $result");
              },
              child: Text('启动'),
            ),

            TextButton(
              onPressed: () async {
                String path = await copyAssetToRealPath();
                var result = await _uniappSdkPlugin.install(appId, path: path);
                print("install--> $result");
              },
              child: Text('部署'),
            ),

            TextButton(
              onPressed: () async {
                var result = await _uniappSdkPlugin.isExist(appId);
                print("isExist--> $result");
              },
              child: Text('是否存在'),
            ),

            TextButton(
              onPressed: () async {
                var result = await _uniappSdkPlugin.getVersionInfo(appId);
                print("getVersionInfo--> $result");
              },
              child: Text('获取当前版本信息'),
            ),
          ],
        )),
      ),
    );
  }
}
