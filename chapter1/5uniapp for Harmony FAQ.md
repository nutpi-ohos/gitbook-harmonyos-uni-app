我们在开发的过程中，或多或少会遇到一些开发方面的问题。

今天就来罗列一下

## 目录结构

一个uni-app工程，默认包含如下目录及文件：

```json

│─components            符合vue组件规范的uni-app组件目录
│  └─comp-a.vue         可复用的a组件
├─utssdk                存放uts文件
├─pages                 业务页面文件存放的目录
│  ├─index
│  │  └─index.vue       index页面
│  └─list
│     └─list.vue        list页面
├─static                存放应用引用的本地静态资源（如图片、视频等）的目录，注意：静态资源都应存放于此目录
├─uni_modules           存放uni_module 详见
├─platforms             存放各平台专用页面的目录，详见
├─nativeplugins         App原生语言插件 详见
├─nativeResources       App端原生资源目录
│  ├─android            Android原生资源目录 详见
|  └─ios                iOS原生资源目录 详见
├─hybrid                App端存放本地html文件的目录，详见
├─wxcomponents          存放小程序组件的目录，详见
├─unpackage             非工程代码，一般存放运行或发行的编译结果
├─main.js               Vue初始化入口文件
├─App.vue               应用配置，用来配置App全局样式以及监听 应用生命周期
├─pages.json            配置页面路由、导航条、选项卡等页面类信息，详见
├─manifest.json         配置应用名称、appid、logo、版本等打包信息，详见
├─AndroidManifest.xml   Android原生应用清单文件 详见
├─Info.plist            iOS原生应用配置文件 详见
└─uni.scss              内置的常用样式变量
	
```



## uts语言在uni-app和uni-app x下的编译关系

|             | uni-app        | uni-app x |                |         |
| ----------- | -------------- | --------- | -------------- | ------- |
|             | 普通页面和脚本 | uts插件   | 普通页面和脚本 | uts插件 |
| Web和小程序 | JS             | JS        | JS             | JS      |
| Android     | JS             | Kotlin    | Kotlin         | Kotlin  |
| iOS         | JS             | Swift     | JS(JS驱动时)   | Swift   |
| HarmonyNext | JS             | ArkTS     | x              | x       |

## 条件编译仅 APP-HARMONY、APP 可以命中鸿蒙平台

现阶段条件编译仅 APP-HARMONY、APP 可以命中鸿蒙平台

```js
// #ifdef APP-HARMONY
console.log("仅鸿蒙会编译")		
// #endif

// #ifndef APP-HARMONY
console.log("仅非鸿蒙会编译")								
// #endif

// #ifdef APP
console.log("安卓、苹果、鸿蒙会编译，小程序和Web不会编译")		
// #endif

// #ifndef APP
console.log("安卓、苹果、鸿蒙不会编译，小程序和Web会编译")		
// #endif

// #ifdef APP-PLUS
console.log("安卓、苹果会编译，鸿蒙不会编译，小程序和Web也不会编译")		
// #endif

// #ifndef APP-PLUS
console.log("安卓、苹果不会编译，鸿蒙会编译，小程序和Web也会编译")		
// #endif

```



## 如何修改应用包名

打开 `AppScope\app.json5` 修改 `bundleName`

![image-20240828074834925](https://luckly007.oss-cn-beijing.aliyuncs.com/uPic/image-20240828074834925.png)

## 如何修改应用名称

1. 打开 `AppScope\resources\base\element\string.json` 修改数组元素 name 值为 app_name 对应的 value 的值

   ![image-20240828075505558](https://luckly007.oss-cn-beijing.aliyuncs.com/uPic/image-20240828075505558.png)

2. 打开 `entry\src\main\resources\base\element\string.json` 修改数组元素 name 值为 EntryAbility_label 对应的 value 的值

3. 打开 `entry\src\main\resources\en_US\element\string.json` 修改数组元素 name 值为 EntryAbility_label 对应的 value 的值

4. 打开 `entry\src\main\resources\zh_CN\element\string.json` 修改数组元素 name 值为 EntryAbility_label 对应的 value 的值

   ![image-20240828075559891](https://luckly007.oss-cn-beijing.aliyuncs.com/uPic/image-20240828075559891.png)

## 如何修改应用图标

替换以下文件，注意文件不要改名

1. AppScope\resources\base\media\app_icon.png
2. entry\src\main\resources\base\media\foreground.png
3. entry\src\main\resources\base\media\startIcon.png

## 报启动鸿蒙失败，请手动启动鸿蒙

### Windows系统

1. 确保路径是正确的
2. 注意：复制后的 `\` 要改成 `/`
3. 如果步骤1操作完还是不行，请尝试

原路径后面添加 `/bin/devecostudio64.exe`，然后重启 HBuilderX

### Mac系统

1. 确保路径是正确的（Mac系统快速复制路径方法按住option键）
2. 如果步骤1操作完还是不行，请尝试原路径后面添加 `/Contents/MacOS/devecostudio`，然后重启 HBuilderX

### 通过 app-plus:titleNView 配置页面右上角按钮未生效

当前导航栏未支持，可以尝试关闭原生导航栏，使用自己的自定义导航栏组件实现。



## 注意事项

1. 移植已有的 uni-app 项目源码时，如有其他 npm 依赖，请自行安装
2. 现阶段条件编译仅 APP-HARMONY、APP 可以命中鸿蒙平台
3. 每次HBuilderX改动源码后，DevEco-Studio 内需要点重新运行才能生效
4. 如果模拟器白屏了，尝试重启软件 DevEco-Studio，再重启项目
5. 如果模拟器无法连接了，尝试重启电脑
6. 在HBuilderX里运行后，需要再去鸿蒙 DevEco Studio里运行
7. 在HBuilderX里修改代码后，需要去鸿蒙 DevEco Studio里重新运行
8. 如果有多个uni-app项目要编译到鸿蒙，那么鸿蒙离线sdk需要放置多份，每个uni-app的manifest中配置不同的离线sdk地址，否则会冲突，鸿蒙设备上目前没有基座概念。

以上开发问题参考：https://uniapp.dcloud.net.cn/tutorial/harmony/dev.html




