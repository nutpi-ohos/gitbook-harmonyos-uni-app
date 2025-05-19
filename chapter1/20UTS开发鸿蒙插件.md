## 了解 UTS 插件是什么

UTS 插件是 uni-app 扩展API的标准插件形式 [详情](https://doc.dcloud.net.cn/uni-app-x/plugin/uts-plugin.html)

uts插件在编译到harmonyOS端时会被编译成ArkTS代码。因此编写代码时应注意遵循 `uts规范` 和 `ets规范`。

### 类型差异

#### any类型

ArkTS内不能使用any类型，但是uts内any用处比较多，因此在编译为ArkTS时，any类型被转为了Object类型。

#### 对象字面量

ArkTS不允许无类型的对象字面量，编写代码时应注意在需要类型时为对象字面量指定类型。如未指定类型，uts会将此对象字面量编译成`as UTSJSONObject`的形式。

## 配置uts插件依赖

鸿蒙的库管理工具是ohpm。类似于js的npm，Android的仓储。

鸿蒙的三方sdk封装文件为`.har`，类似于Android的`.aar`

uts插件的`utssdk/app-harmony/config.json`文件内可以配置依赖使用鸿蒙的三方库，配置方式如下：

```js
{
  "dependencies": {
    "@cashier_alipay/cashiersdk": "15.8.26", // ohpm依赖
    "local-deps": "./libs/local-deps.har" // 本地依赖
  }
}
```

