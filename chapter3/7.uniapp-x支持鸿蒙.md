## uni-app x 从4.61+起支持Harmony NEXT

昨天的文章简单的带大家了解了一下uniapp支持鸿蒙

接下来一起看一下详细的介绍

## uni-app x 是什么？

uni-app x，是下一代 uni-app，是一个跨平台应用开发引擎。

uni-app x 是一个庞大的工程，它包括uts语言、uvue渲染引擎、uni的组件和API、以及扩展机制。

uts是一门类ts的、跨平台的、新语言。

uts在iOS平台编译为swift、在Android平台编译为kotlin、在Web和小程序平台编译为js、在Harmony NEXT平台上编译为ArkTS。

在Android平台，uni-app x 的工程被整体编译为kotlin代码，本质上是换了vue写法的原生kotlin应用，在性能上与原生kotlin一致。

##  uts语言

开发者在 uni-app x 中，需使用 uts 而不是js。尤其是 Android端不自带js引擎，无法运行js代码。

uts 全称 uni type script，是一门跨平台的、高性能的、强类型的现代编程语言。它在不同平台，会被编译为不同平台的native语言，如：

它可以被编译为不同平台的编程语言，如：

- web平台/小程序，编译为JavaScript
- Android平台，编译为Kotlin
- iOS平台，编译Swift
- 鸿蒙OS平台，编译为ArkTS（HBuilderX 4.22+）

ts 采用了与 ts 基本一致的语法规范，支持绝大部分 ES6 API。但为了跨端，uts进行了一些约束和特定平台的增补。

## uvue渲染引擎

uts替代的是js，而uvue替代的就是html和css。或者如果你了解flutter的话，也可以理解为uts类似dart，而uvue类似flutter。

uvue是一套基于uts的、兼容vue语法的、跨平台的、原生渲染引擎。

- Android版于3.99上线
- Web版于4.0上线
- iOS版于4.11上线
- harmonyOS版于4.61上线

uvue渲染引擎包括uts版的vue框架（组件、数据绑定...）、跨平台基础ui、css引擎。

有了uvue，开发者就可以使用vue语法、css来快速编写页面，编译为不同平台的、高性能的纯原生界面。

## uts和uvue

uts是一门语言。也仅是一门语言，不包含ui框架。

uvue是DCloud提供的跨平台的、基于uts的、使用vue方式的ui框架。

uts相当于js，uvue相当于html和css。它们类似于v8和webkit的关系，或者类似于dart和flutter的关系。

## uni的组件

uni-app x支持的组件包括：

- `内置基础组件`：如view、text、image、scroll-view、input...等，详见[组件清单](https://doc.dcloud.net.cn/uni-app-x/component/index.html)
- `自定义vue组件`：使用内置组件和vue组件技术进行封装的组件，支持easycom。
- `uts组件插件`：用于原生sdk的ui以组件的方式嵌入。

##  API

uni-app x支持的API包括：

1. uts的API [详见](https://doc.dcloud.net.cn/uni-app-x/uts/buildin-object-api/global.html)
2. 全局API，前面不需要加`uni.`。如[getApp](https://doc.dcloud.net.cn/uni-app-x/api/get-app.html)、[getCurrentPages](https://doc.dcloud.net.cn/uni-app-x/api/get-current-pages.html)
3. uni.xxx的内置API。数量较多，[详见](https://doc.dcloud.net.cn/uni-app-x/api/index.html)
4. uniCloud.xxx的内置API。[详见](https://doc.dcloud.net.cn/uni-app-x/api/unicloud/index.html)
5. dom的API [详见](https://doc.dcloud.net.cn/uni-app-x/dom/index.html)
6. 原生API





## 创建项目  

![image-20250415095411587](https://nutpi-e41b.obs.cn-north-4.myhuaweicloud.com/image-20250415095411587.png)

或者

![image-20250415103109084](https://nutpi-e41b.obs.cn-north-4.myhuaweicloud.com/image-20250415103109084.png)



## 运行效果

|                             组件                             |                             接口                             |                             css                              |                             模版                             |
| :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: |
| ![image-20250415103230600](https://nutpi-e41b.obs.cn-north-4.myhuaweicloud.com/image-20250415103230600.png) | ![image-20250415103255025](https://nutpi-e41b.obs.cn-north-4.myhuaweicloud.com/image-20250415103255025.png) | ![image-20250415103311362](https://nutpi-e41b.obs.cn-north-4.myhuaweicloud.com/image-20250415103311362.png) | ![image-20250415103324784](https://nutpi-e41b.obs.cn-north-4.myhuaweicloud.com/image-20250415103324784.png) |





## 注意事项

最新版本运行的时候，会有这个问题，遇到这个问题，在源码模式删除

unipush以及 "uni-verify": {},
"uni-facialVerify": {}

![img](https://nutpi-e41b.obs.cn-north-4.myhuaweicloud.com/174468325906633017500-7654-11eb-ac63-37648c6023a6..png)



## 题外话



不论鸿蒙还是开源鸿蒙目前整体处于发展的前期，能用，但是有坑，所以不能严格比照Android和iOS的验收标准要求鸿蒙。即便微信这样的应用，功能、质量也比不过Android/iOS版。

有空会继续更新关于uniapp for 鸿蒙的专栏，欢迎大家点赞，转发，谢谢大家。

## 参考

[HarmonyOS Uts调试](https://uniapp.dcloud.net.cn/tutorial/debug/uni-uts-debug-harmony.html)

[uniappx for HarmonyOS](https://doc.dcloud.net.cn/uni-app-x/app-harmony/)

[uniapp for HarmonyOS](https://uniapp.dcloud.net.cn/tutorial/harmony/intro.html)

## **坚果派**

坚果派由坚果等人创建，团队拥有若干华为 HDE，以及若干其他领域的三十余位万粉博主运营。专注于分享的技术包括 HarmonyOS/OpenHarmony，ArkUI-X，元服务，服务卡片，华为自研语言，BlueOS 操作系统、团队成员聚集在北京、上海、广州、深圳、南京、杭州、苏州、宁夏等地。 聚焦“鸿蒙原生应用”、“智能物联”和“AI 赋能”、“人工智能”四大业务领域，依托华为开发者专家等强大的技术团队，以及涵盖需求、开发、测试、运维于一体的综合服务体系，赋能文旅、媒体、社交、家居、消费电子等行业客户，满足社区客户数字化升级转型的需求，帮助客户实现价值提升。 目前上架鸿蒙原生应用 18 款，三方库 72 个。欢迎大家加微信联系。

地址：https://atomgit.com/nutpi

https://gitcode.com/nutpi

