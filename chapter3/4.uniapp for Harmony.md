大家好，今天我们来到此系列的第四篇。



## uniapp for Harmony

## 使用uts调用鸿蒙原生API

uni-app在Android和iOS平台，支持uts插件和App原生语言插件。目前App原生语言插件已经停止维护。uts插件是主推的扩展方式。

鸿蒙系统有很多原生API，可以通过uts插件方式接入，被uni-app调用。

接下来我们一起来实践一下。

这里面我们分别从uts是什么开始讲起

## 什么是uts语言

uts，全称 uni type script，统一、强类型、脚本语言。

它可以被编译为不同平台的编程语言，如：

- web平台，编译为JavaScript
- Android平台，编译为Kotlin
- iOS平台，编译为Swift（HX 3.6.7+ 版本支持）
- HarmonyOS平台，编译为ArkTs（HX 4.22+ 版本支持）在现有架构下，ArkTs和JS在同一环境下执行，不涉及通讯等问题。

uts 采用了与 ts 基本一致的语法规范，支持绝大部分 ES6 API。

### uts语言

- 可以用来开发独立App，即[uni-app x](https://doc.dcloud.net.cn/uni-app-x/)；
- 也可以用来开发插件，即uts插件。

## 什么是uts插件

uts插件，指利用uts语法，操作原生的API（包括手机os的api或三方sdk），并封装成一个[uni_modules](https://uniapp.dcloud.net.cn/plugin/uni_modules.html)插件，供前端调用。

- uni-app中，是js来调用uts插件。 ![uts插件结构](https://luckly007.oss-cn-beijing.aliyuncs.com/uPic/UTS%E7%BB%93%E6%9E%84%E7%A4%BA%E6%84%8F%E5%9B%BE1.png)
- uni-app x中，是uts来调用uts插件。

也就是一个uts插件，可以同时支持uni-app和uni-app x。

为了兼容全端，uts插件可以分目录写所有平台代码，也就是一个uts插件除了支持App的扩展，还可以支持web、小程序。

比如这个uts插件，[电量](https://ext.dcloud.net.cn/plugin?id=9295)，其源码在https://gitcode.net/dcloud/uni-api/-/tree/master/uni_modules/uni-getbatteryinfo，内部有多个目录（app-android、app-ios、web、mp-weixin、mp-alipay...），在非App目录也可以写js。

这个电量插件在uni-app和uni-app x中均可以使用。

uts插件分api和组件。这和uni-app的组件、api的概念是一样的。

- api插件：uts插件扩展了api能力，在script里调用
- 组件插件：uts插件扩展了界面组件，在template里调用。它是要内嵌在页面中。

api插件也可以操作界面，但更多是独立的全屏窗口或弹出窗口。而不能嵌入在template中。

### uts插件与uni原生语言插件的区别

uts 插件编译到 app 平台时，在功能上相当于 uni-app 之前的 app 原生插件。都是给app扩展原生能力。

开发 uts 插件不需要熟悉 Kotlin 和 Swift 的语法，因为使用的是 uts语法。但需要熟悉 Android 和 iOS 的系统 API，至少需要知道什么原生能力在哪个API里。

在 HBuilderX 3.6 以前，uni-app 在 App 侧只有一种原生插件，即用 java 或 Objective-C 开发的插件。

在 uts 推出后，原来的 “App原生插件”，更名为 “App原生语言插件”。

不同的名字，代表它们需要开发者编写语言不同。但殊途同归，最后都编译为原生的二进制代码。

|              | 原生语言插件              | uts插件                                          |
| :----------- | :------------------------ | :----------------------------------------------- |
| 开发语言     | java/oc                   | uts                                              |
| 开发环境     | Android Studio/XCode      | HBuilderX                                        |
| 打包方式     | 外挂aar 等产出物          | 编译时生成原生代码                               |
| js层调用方式 | uni.requireNativePlugin() | 普通的js函数/对象，可以直接 import，支持摇树优化 |
| 支持项目类型 | uni-app                   | uni-app和uni-app x                               |

相对原生语言插件，uts插件的优势：

1. 统一了编程语言（uts），一种语言开发所有平台，真正大前端。而且uts插件还支持鸿蒙next。而App原生只支持Android和iOS。
2. 统一了开发工具（HBuilderX），免除搭建复杂的原生开发环境。
3. 插件封装中要理解的概念更少。 传统原生语言插件需要在js和原生层处理通信，使用各种特殊转换，使用特殊语法导入，注意事项很多。**uts统一为纯前端概念，简单清晰。**
4. uts 下前端和原生可以统一在 HBuilderX 中联调，可以一起联编运行，可以把原生层信息打log到hx的控制台。而传统原生语言插件需要在多个开发工具间切换，联调复杂。
5. 插件市场的uts插件支持下载后自己固定版本。而付费的原生语言插件只能使用最新版。
6. 插件市场的uts付费插件支持源码版销售和源码版权保护机制。而付费的原生语言插件不支持源码版销售。
7. uts插件可同时支持uni-app和uni-app x。

如果您是插件作者，可以了解更多uts插件和uni原生语言插件对插件作者的区别。[详见](https://uniapp.dcloud.net.cn/plugin/publish.html#utsdiff)

## 创建uts插件

> > 注意： 目前仅支持通过HBuilder X 创建和使用UTS插件，不支持通过cli的方式使用UTS插件

### HBuilderX项目中uts插件目录结构

在 uni-app / uni-app x 的项目工程下，提供了独立的目录 `utssdk`，来存放 uts 插件。

当然官方更推荐使用 [uni_modules](https://uniapp.dcloud.net.cn/plugin/uni_modules.html) 方式，这是更好的包管理方案。

首先确保项目根目录存在 uni_modules 文件夹，如果不存在，需要手动创建一个。

![image-20240827223602671](https://luckly007.oss-cn-beijing.aliyuncs.com/uPic/image-20240827223602671.png)

### 新建步骤拆解

右键点击`uni_modules`目录 -> 新建插件

![image-20240827223645339](https://luckly007.oss-cn-beijing.aliyuncs.com/uPic/image-20240827223645339.png)

选择类型 **uts插件**

![image-20240827223734987](https://luckly007.oss-cn-beijing.aliyuncs.com/uPic/image-20240827223734987.png)

**为了避免和插件市场的其他插件冲突，建议起一个自己的插件前缀名称。**

uts插件目录结构



### package.json

package.json 为 uni_modules 插件配置清单文件，负责描述插件的基本配置。

```
{
  "id": "uts-helloworld",
  "displayName": "uts插件示例",
  "version": "0.1",
  "description": "uts插件示例",
  "uni_modules": {

  }
}

```







1.插件名字 2. package.json  uni_modules加 "uni-ext-api": {
		"uni": {
		  "openAppProduct": {
			"name": "openAppProduct",
			"app": {
			  "js": false,
			  "kotlin": false,
			  "swift": false,
			  "arkts": true
			}
		  }
		}
	},  3. interface.uts 直接复制，4. utssdk  新建app-harmony/index.uts  修改包名   这个步骤有问题嘛？
