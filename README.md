# flutter_uniapp_sdk
flutter uniapp sdk

# 引入
```
flutter_uniapp_sdk:
  git:
    url: https://github.com/StanleyCocos/flutter_uniapp_sdk
```

# Android Gradle 配置指南

## 根目录配置
打开 `android/build.gradle` 文件，在 `repositories` 代码块中添加：

```groovy
allprojects {
    repositories {
        // 添加以下 maven 仓库配置
        maven {
            url "${project(':flutter_uniapp_sdk').projectDir}/repo"
        }
        // ... 其他已有仓库
    }
}
```

## app目录配置
打开 `android/app/build.gradle` 文件，在 `defaultConfig` 代码块中添加：

```groovy
android {
    defaultConfig {
        // 添加 manifest 占位符配置
        manifestPlaceholders = ["apk.applicationId" : "你的应用包名"]  // 替换为实际包名如 com.example.app
        // ... 其他已有配置
    }
}
```
