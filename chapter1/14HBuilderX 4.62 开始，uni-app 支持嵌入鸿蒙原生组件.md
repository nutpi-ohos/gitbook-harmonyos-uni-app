# HBuilderX 4.62 开始，uni-app 支持嵌入鸿蒙原生组件

uni-app 组件难以应对之处，鸿蒙原生组件方显其能。

从 uni-app 4.62 版本起，开发者可以通过 UTS 插件将鸿蒙原生组件嵌入到 uni-app 应用中，并且支持同层渲染。这一功能使得开发者能够充分利用鸿蒙系统的原生组件，提升应用的性能和用户体验。以下是具体介绍和实际案例。

## 嵌入鸿蒙原生组件

鸿蒙系统提供了丰富的原生组件，这些组件可以通过 UTS 插件注册为 WebView 支持的原生组件。目前，鸿蒙原生组件仅支持定义在 ETS 文件中，UTS 插件支持导入 ETS 文件，从而实现原生组件在 uni-app 中的嵌入。

例如，在页面中嵌入原生的 button、map 等组件，具体实现方式可参考[uni-app 官方文档](https://uniapp.dcloud.net.cn/tutorial/harmony/native-component.html)。

## 实际案例：使用华为花瓣地图

接下来，我们将通过一个实际案例，展示如何在 uni-app 中嵌入华为花瓣地图。

### 效果展示

![image-20250418181608436](https://nutpi-e41b.obs.cn-north-4.myhuaweicloud.com/image-20250418181608436.png)

### 代码实现

#### Template 部分

```vue
<template>
  <view class="container">
    <view class="map-container">
      <embed class="native-map" tag="map" :options="options" @markertap="onMarkerTap"></embed>
    </view>
  </view>
</template>
```

#### Script 部分

```javascript
<script>
import "@/uni_modules/native-harmony-map";
export default {
  data() {
    return {
      options: {
        latitude: 22.5431,
        longitude: 114.0579,
        scale: 12,
        circles: [
          {
            latitude: 22.5431,
            longitude: 114.0579,
            color: 0xffff0000, // 圆形边框颜色
            fillColor: 0xff00ffff, // 圆形填充颜色
            radius: 80, // 圆形半径，单位：米
            strokeWidth: 10, // 圆形边框宽度，单位：像素
          },
        ],
        markers: [
          {
            latitude: 22.5431,
            longitude: 114.0579,
          },
        ],
      },
    };
  },
  methods: {
    onMarkerTap(e) {
      console.log("onMarkerTap", e);
      uni.showToast({
        title: `点击了标记点 ${e.detail.markerId}`,
        icon: "none",
      });
    },
  },
};
</script>
```

#### Style 部分

```css
<style>
.container {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 100vh;
  padding: 20px;
  box-sizing: border-box;
}

.map-container {
  width: 100%;
  height: 70%;
  margin-bottom: 20px;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.native-map {
  width: 100%;
  height: 100%;
}
</style>
```

### 完整代码

```vue
<template>
  <view class="container">
    <view class="map-container">
      <embed class="native-map" tag="map" :options="options" @markertap="onMarkerTap"></embed>
    </view>
  </view>
</template>

<script>
import "@/uni_modules/native-harmony-map";
export default {
  data() {
    return {
      options: {
        latitude: 22.5431,
        longitude: 114.0579,
        scale: 12,
        circles: [
          {
            latitude: 22.5431,
            longitude: 114.0579,
            color: 0xffff0000,
            fillColor: 0xff00ffff,
            radius: 80,
            strokeWidth: 10,
          },
        ],
        markers: [
          {
            latitude: 22.5431,
            longitude: 114.0579,
          },
        ],
      },
    };
  },
  methods: {
    onMarkerTap(e) {
      console.log("onMarkerTap", e);
      uni.showToast({
        title: `点击了标记点 ${e.detail.markerId}`,
        icon: "none",
      });
    },
  },
};
</script>

<style>
.container {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 100vh;
  padding: 20px;
  box-sizing: border-box;
}

.map-container {
  width: 100%;
  height: 70%;
  margin-bottom: 20px;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.native-map {
  width: 100%;
  height: 100%;
}
</style>
```

## 优化与总结

### 优化建议

1. 性能优化 ：在使用原生组件时，注意组件的性能表现，避免过度使用复杂的原生组件导致应用性能下降。
2. 用户体验 ：确保原生组件与 uni-app 的其他部分在视觉和交互上的一致性，提供流畅的用户体验。
3. 兼容性测试 ：在不同设备和鸿蒙系统版本上进行充分的兼容性测试，确保应用的稳定性和功能完整性。
4. 代码复用 ：将常用的原生组件封装成可复用的模块或插件，提高开发效率。

### 总结

HBuilderX 4.62 开始，uni-app 对鸿蒙原生组件的支持为开发者提供了更广阔的空间来构建高性能、功能丰富的应用。通过 UTS 插件，开发者可以轻松地将鸿蒙原生组件嵌入到 uni-app 应用中，充分利用鸿蒙系统的特性。未来，随着 uni-app 和鸿蒙系统的不断发展，我们有理由相信，这种结合将为开发者带来更多的创新机会和可能性。

## 开源项目地址

https://gitcode.com/nutpi/uniapp-harmony-map

## 参考

  * [UTS 语法](https://uniapp.dcloud.net.cn/tutorial/syntax-uts.html)
  * [UTS API 插件](https://uniapp.dcloud.net.cn/plugin/uts-plugin.html)
  * [UTS uni-app 兼容模式组件](https://uniapp.dcloud.net.cn/plugin/uts-component.html)
  * [UTS 标准模式组件](https://doc.dcloud.net.cn/uni-app-x/plugin/uts-vue-component.html)
  * [Hello UTS](https://gitcode.net/dcloud/hello-uts)
  * [uniapp 嵌入鸿蒙原生组件](https://uniapp.dcloud.net.cn/tutorial/harmony/native-component.html)
  * [调用鸿蒙原生 API](https://uniapp.dcloud.net.cn/tutorial/harmony/native-api.html)
  * [uniapp 同层渲染调用华为花瓣地图](https://ext.dcloud.net.cn/plugin?id=23082)

## **坚果派**

坚果派由坚果等人创建，团队拥有若干华为 HDE，以及若干其他领域的三十余位万粉博主运营。专注于分享的技术包括 HarmonyOS/OpenHarmony，ArkUI-X，元服务，服务卡片，华为自研语言，BlueOS 操作系统、团队成员聚集在北京、上海、广州、深圳、南京、杭州、苏州、宁夏等地。 聚焦“鸿蒙原生应用”、“智能物联”和“AI 赋能”、“人工智能”四大业务领域，依托华为开发者专家等强大的技术团队，以及涵盖需求、开发、测试、运维于一体的综合服务体系，赋能文旅、媒体、社交、家居、消费电子等行业客户，满足社区客户数字化升级转型的需求，帮助客户实现价值提升。 目前上架鸿蒙原生应用 18 款，三方库 72 个。欢迎大家加微信联系。

地址：https://atomgit.com/nutpi

https://gitcode.com/nutpi

