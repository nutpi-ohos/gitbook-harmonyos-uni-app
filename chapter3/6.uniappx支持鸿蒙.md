## uni-app x 支持鸿蒙

国产替代浪潮奔涌，鸿蒙适配已成为一个必答题，这里面跨端框架是破局多 OS 割裂的最优解。比如 uniapp x，之前有很多 app 可能是用 uniappx 做的，那么如何支持鸿蒙呢？



uni-app x 从4.61+起支持纯血鸿蒙，即Harmony NEXT。

uni-app x的鸿蒙版虽然是刚发布，但组件、API、CSS基本拉齐了Android和iOS。甚至还有扫码、拨打电话、剪贴板等超出Android/iOS的功能。



## 效果预览

![image-20250414223020914](https://nutpi-e41b.obs.cn-north-4.myhuaweicloud.com/image-20250414223020914.png)

![image-20250414223043171](https://nutpi-e41b.obs.cn-north-4.myhuaweicloud.com/image-20250414223043171.png)

## 开发环境要求

- HBuilderX 4.61+，[下载地址](https://www.dcloud.io/hbuilderx.html)
- 鸿蒙电脑端开发工具DevEco Studio BuildVersion 5.0.11.100, 
- 鸿蒙手机系统 API版本 14+，我这里是16.

## 运行和发行注意

uni-app x编译到鸿蒙是ArkTS语言，ArkTS在鸿蒙的ide deveco中没有热刷新。**每次改动代码，需要重新build包、签名、安装新包到手机**。

uni-app x在鸿蒙模拟器运行不受限制。

HBuilderX自身提供了运行、日志、debug、发行、调试证书申请等全套功能，开发者安装deveco后，可以做到不启动deveco，在HBuilderX中完成所有开发。

从 HBuilderX 4.61+ 开始支持通过配置指定使用特定的目录作为鸿蒙工程目录，这样就可以避免上述对于 uni-app 项目路径的额外限制了。 方法是在项目根目录下的 `.hbuilderx/launch.json` 中添加如下内容（如果该文件不存在则手动创建）：

```json
{
    "version" : "1.0",
    "configurations" : [
        {
            "type" : "uni-app:app-harmony",
            "distPathDev" : "D:/harmony-project-dev",
            "distPathBuild" : "D:/harmony-project-build"
        }
    ]
}
```

其中 `distPathDev` 用于指定调试运行的时候使用的鸿蒙工程目录，`distPathBuild` 用于指定发行打包的时候使用的鸿蒙工程目录。

指定的目录不必已经存在，HBuilderX 会创建所需的目录，如果目录已经存在的话 HBuilderX 还可能根据需要尝试删除然后重建。

HBuilderX 4.61+ 开始支持针对 uni-app x 项目的调试功能，支持断点调试，可以在控制台里面点击调试按钮开启。



## 证书签名配置指南

数字签名证书的配置最终需要落在鸿蒙工程根目录中的 `build-profile.json5` 文件中起作用。

从 HBuilderX 4.61+ 开始支持以交互方式配置相关信息（且支持自动申请调试证书），这些信息在构建阶段会被覆盖填写到鸿蒙工程的 `build-profile.json5` 文件中。 

## 在 HBuilderX 里面直接配置证书签名

从 HBuilderX 4.61+ 开始支持这种配置方式。在【运行到鸿蒙】操作的【选择运行设备】对话框中，点击【配置调试证书】按钮，打开配置对话框

![image-20250414221936170](https://nutpi-e41b.obs.cn-north-4.myhuaweicloud.com/image-20250414221936170.png)

在 `manifest.json` 的编辑页面中，【鸿蒙App配置】里面也有打开配置对话框的按钮，分别用于配置调试证书和发布证书：

![image-20250414222017753](https://nutpi-e41b.obs.cn-north-4.myhuaweicloud.com/image-20250414222017753.png)



## 参考

[HarmonyOS Uts调试](https://uniapp.dcloud.net.cn/tutorial/debug/uni-uts-debug-harmony.html)

[uniappx for HarmonyOS](https://doc.dcloud.net.cn/uni-app-x/app-harmony/)

[uniapp for HarmonyOS](https://uniapp.dcloud.net.cn/tutorial/harmony/intro.html)

## **坚果派**

坚果派由坚果等人创建，团队拥有若干华为 HDE，以及若干其他领域的三十余位万粉博主运营。专注于分享的技术包括 HarmonyOS/OpenHarmony，ArkUI-X，元服务，服务卡片，华为自研语言，BlueOS 操作系统、团队成员聚集在北京、上海、广州、深圳、南京、杭州、苏州、宁夏等地。 聚焦“鸿蒙原生应用”、“智能物联”和“AI 赋能”、“人工智能”四大业务领域，依托华为开发者专家等强大的技术团队，以及涵盖需求、开发、测试、运维于一体的综合服务体系，赋能文旅、媒体、社交、家居、消费电子等行业客户，满足社区客户数字化升级转型的需求，帮助客户实现价值提升。 目前上架鸿蒙原生应用 18 款，三方库 72 个。欢迎大家加微信联系。

地址：https://atomgit.com/nutpi

https://gitcode.com/nutpi

