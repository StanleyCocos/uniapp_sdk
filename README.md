# UniApp SDK Flutter Plugin

一个用于在Flutter应用中集成UniApp小程序的插件，支持iOS和Android平台。

## 功能特性

- ✅ **iOS端完整实现** - 基于DCloud官方SDK，支持所有UniApp功能
- ✅ **Android端框架完成** - 代码框架已实现，支持模拟测试
- 🔄 **统一API接口** - iOS和Android使用相同的Dart API
- 📱 **完整生命周期管理** - 支持小程序的安装、启动、关闭等操作
- 🔄 **双向通信** - 支持Flutter与UniApp之间的事件通信

## 平台支持

| 平台 | 状态 | 说明 |
|------|------|------|
| iOS | ✅ 完全支持 | 基于DCloud官方SDK实现 |
| Android | ⚠️ 框架完成 | 需要添加实际SDK文件 |

## 快速开始

### 1. 添加依赖

在 `pubspec.yaml` 中添加：

```yaml
dependencies:
  uniapp_sdk: ^1.0.1
```

### 2. iOS配置

iOS端已完全实现，请参考iOS端的配置文档。

### 3. Android配置

Android端需要额外的配置步骤，请参考 [Android集成指南](ANDROID_INTEGRATION.md)。

## API使用

### 安装小程序

```dart
await UniappSdk().install(
  appId, 
  path: '/path/to/your/app.wgt',
  password: 'optional_password'
);
```

### 启动小程序

```dart
await UniappSdk().open(
  appId,
  config: UniAppConfiguration(
    path: 'pages/index/index',
    extraData: {'key': 'value'},
    openMode: UniAPPOpenMode.present,
    enableBackground: true,
  ),
  onClosed: (id) {
    print('小程序关闭: $id');
  },
  onReceive: (data) {
    print('接收到小程序事件: $data');
  },
);
```

### 检查小程序是否存在

```dart
bool exists = await UniappSdk().isExist(appId);
```

### 获取版本信息

```dart
var versionInfo = await UniappSdk().getVersionInfo(appId);
```

### 发送事件到小程序

```dart
await UniappSdk().sendEvent(
  event: 'customEvent',
  data: {'message': 'Hello from Flutter'}
);
```

## 配置选项

### UniAppConfiguration

```dart
UniAppConfiguration({
  Map<String, dynamic>? extraData,     // 传递给小程序的数据
  String? fromAppId,                   // 来源小程序ID
  String? path,                        // 打开的页面路径
  bool enableBackground = false,       // 是否支持后台运行
  bool showAnimated = true,           // 显示动画
  bool hideAnimated = true,           // 隐藏动画
  UniAPPOpenMode openMode = UniAPPOpenMode.present, // 打开方式
  bool enableGestureClose = false,    // 手势关闭
})
```

## 文档

- [Android集成指南](ANDROID_INTEGRATION.md) - Android端详细集成步骤
- [REAL_SDK_IMPLEMENTATION.kt](REAL_SDK_IMPLEMENTATION.kt) - Android端真实SDK实现参考

## 示例

查看 `example/` 目录中的完整示例应用。

## 开发状态

### 已完成
- [x] iOS端完整实现
- [x] Android端代码框架
- [x] 统一的Dart API接口
- [x] 示例应用
- [x] 文档和集成指南

### 待完成
- [ ] Android端真实SDK集成测试
- [ ] 更多配置选项支持
- [ ] 错误处理优化

## 贡献

欢迎提交Issue和Pull Request来帮助改进这个插件。

## 许可证

本项目采用MIT许可证。

