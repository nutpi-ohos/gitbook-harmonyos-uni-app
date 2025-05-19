真的昨天写完相关的文章以后，也是没想到，热度这么高，接下



## uts for HarmonyOS

鸿蒙系统有很多原生API，这些API通过ArkTS来调用。

由于uts可以编译为ArkTS，所以uts可以调用鸿蒙的所有原生API。

如需在uni-app中使用，就需要把鸿蒙的原生API封装为uts插件，然后在uni-app中使用。

这些uts插件，是同时兼容uni-app和uni-app x的。

但目前仅uni-app支持鸿蒙next，uni-app x还需过段时间。

uni-app中开发者的逻辑是编译为js，js无法直接调用鸿蒙原生API。而uts插件是编译为ets文件，所以可以调用鸿蒙原生API。（ArkTS的文件后缀为.ets）



## 什么是uts语言

uts，全称 uni type script，统一、强类型、脚本语言。

它可以被编译为不同平台的编程语言，如：

- web平台，编译为JavaScript
- Android平台，编译为Kotlin
- iOS平台，编译为Swift（HX 3.6.7+ 版本支持）
- HarmonyOS平台，编译为ArkTS（HX 4.22+ 版本支持）在现有架构下，ArkTS和JS在同一环境下执行，不涉及通讯等问题。

uts 采用了与 ts 基本一致的语法规范，支持绝大部分 ES6 API。

## 什么是uts插件

uts插件，指利用uts语法，操作原生的API（包括手机os的api或三方sdk），并封装成一个[uni_modules](https://uniapp.dcloud.net.cn/plugin/uni_modules.html)插件，供前端调用。

- uni-app中，是js来调用uts插件。（HBuilderX 3.6支持vue3编译器，3.6.8支持vue2编译器）

![uts插件结构](https://luckly007.oss-cn-beijing.aliyuncs.com/uPic/UTS%E7%BB%93%E6%9E%84%E7%A4%BA%E6%84%8F%E5%9B%BE1.png)









## 1 了解 UTS 插件是什么

UTS 插件是 uni-app 扩展API的标准插件形式 

uts插件在编译到HarmonyOS端时会被编译成ArkTS代码。因此编写代码时应注意遵循 `uts规范` 和 `ets规范`。

## 2 掌握UTS语法及ArkTS语法

无论是uts还是ArkTS都是在ts的语法基础上进行扩展来的。建议先阅读如下文档

- [typescript官方文档](https://www.typescriptlang.org/zh/docs/)
- [uts语法](https://doc.dcloud.net.cn/uni-app-x/uts/)
- [ArkTS约束](https://developer.huawei.com/consumer/cn/doc/HarmonyOS-guides/typescript-to-ArkTS-migration-guide-0000001820879565)

## 3 HarmonyOS 原生环境配置

参考：[uni-app 开发鸿蒙应用](https://uniapp.dcloud.net.cn/tutorial/harmony/dev.html)

## 4 ArkTS 与 UTS 差异重点介绍 (持续更新)

### 类型差异

#### any类型

ArkTS内不能使用any类型，但是uts内any用处比较多，因此在编译为ArkTS时，any类型被转为了Object类型。

#### 对象字面量

ArkTS不允许无类型的对象字面量，编写代码时应注意在需要类型时为对象字面量指定类型。如未指定类型，uts会将此对象字面量编译成`as UTSJSONObject`的形式。

```ts
// 源码
const obj = {
  a: 1
}

// 编译结果
const obj = {
  a: 1
} as UTSJSONObject
```



```ts
// 源码
interface Obj {
  a: number
}
const obj: Obj = {
  a: 1
}
//或
const obj = {
  a: 1
} as Obj

// 编译结果
class Obj { ... }
const obj: Obj = {
  a: 1
}
//或
const obj = {
  a: 1
} as Obj
```



## 5 常见问题

### context的获取

很多HarmonyOS原生接口需要传入context作为参数。多数情况下可以直接调用HarmonyOS全局方法`getContext()`获取。例如：

```ts
import settings from '@ohos.settings';
const context: Context =  getContext();
settings.getValue(context, settings.display.SCREEN_BRIGHTNESS_STATUS, (err, value) => {
  if (err) {
    console.error(`Failed to get the setting. ${err.message} `);
    return;
  }
  console.log(`SCREEN_BRIGHTNESS_STATUS: ${JSON.stringify(value)}`)
});
```





UTS 插件是 uni-app 扩展API的标准插件形式 [详情](https://doc.dcloud.net.cn/uni-app-x/plugin/uts-plugin.html)

- 另见[uts语法介绍](https://doc.dcloud.net.cn/uni-app-x/uts/)
- [uts插件介绍](https://doc.dcloud.net.cn/uni-app-x/plugin/uts-plugin.html)
- [uts插件鸿蒙开发专题](https://doc.dcloud.net.cn/uni-app-x/plugin/uts-for-harmony.html)