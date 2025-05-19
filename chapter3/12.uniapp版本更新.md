## HBuilder4.62发布，修复多个鸿蒙bug



大家在之前的文章应该看到了，关于HBuilder4.61版本的一些bug，新的版本目前已经解决这个问题

本次修改在鸿蒙上的体现主要有：

### uni-app

- App-Harmony平台 新增 defineNativeEmbed 接口，用于定义原生嵌入组件 [详情](https://uniapp.dcloud.net.cn/tutorial/harmony/native-component.html)
- App-Harmony平台 修复 getStorage 接口返回的对象内的数组调用 push 方法无效的Bug [详情](https://ask.dcloud.net.cn/question/207828)
- App-Harmony平台 修复 uts 插件内打印日志无法在 HBuilderX 控制台查看的Bug

### uni-app x

- App-Harmony平台 新增 运行调试 支持运行到 x64 平台的鸿蒙模拟器 [详情](https://issues.dcloud.net.cn/pages/issues/detail?id=17036)

### uts插件

- App-Harmony平台 修复 UTSHarmony 在较早时机无法调用 getUIAbilityContext 的 Bug [详情](https://issues.dcloud.net.cn/pages/issues/detail?id=17019)

其他的更新可以查看具体的更新日志。