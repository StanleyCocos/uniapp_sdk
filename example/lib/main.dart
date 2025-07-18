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
    final ByteData data = await rootBundle.load('assets/$appId.wgt');
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
                  var result = await _uniappSdkPlugin.open(
                    appId,
                    config: UniAppConfiguration(
                      extraData: {'key': 'value1'},
                      fromAppId: 'fromAppId11',
                      path: 'pages/component/view/view?a=1&b=2',
                      openMode: UniAPPOpenMode.push,
                      // 可选，默认是present
                      showAnimated: true,
                      hideAnimated: true,
                      enableBackground: true,
                      enableGestureClose: true,
                    ),
                    onClosed: (id) {
                      print("onClosed--> $id ");
                    },
                    onReceive: (data) {
                      print("接收来自uniapp 的事件: $data ");
                    },
                  );
                  print("open--> $result");
                },
                child: const Text('启动'),
              ),
              TextButton(
                onPressed: () async {
                  String path = await copyAssetToRealPath();
                  var result =
                      await _uniappSdkPlugin.install(appId, path: path);
                  print("install--> $result");
                },
                child: const Text('部署'),
              ),
              TextButton(
                onPressed: () async {
                  var result = await _uniappSdkPlugin.isExist(appId);
                  print("isExist--> $result");
                },
                child: const Text('是否存在'),
              ),
              TextButton(
                onPressed: () async {
                  var result = await _uniappSdkPlugin.getVersionInfo(appId);
                  print("getVersionInfo--> $result");
                },
                child: const Text('获取当前版本信息'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
