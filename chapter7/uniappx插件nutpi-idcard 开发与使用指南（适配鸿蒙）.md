# uniappx插件nutpi-idcard 开发与使用指南（适配鸿蒙）

## 前言

`nutpi-idcard` 是一个基于 UTS (uni-app TypeScript Syntax) 开发的 uni-app 插件适配鸿蒙，主要用于解析身份证号码，提取其中的关键信息，如地区、出生日期、性别等。本插件支持中国居民身份证、港澳台居民居住证以及外国人永久居留身份证。

本文将详细介绍 `nutpi-idcard` 插件的开发过程和使用方法，希望能为其他开发者提供一些参考。

## 插件功能

- **身份证号码解析**：能够从身份证号码中提取省市区（或国家/地区）、出生日期、性别等信息。
- **支持多种证件类型**：
  - 中国居民身份证
  - 港澳台居民居住证
  - 外国人永久居留身份证
- **纯 UTS 实现**：确保了插件在 uni-app x 及其他支持 UTS 的环境中的兼容性和性能。
- **跨平台支持**：理论上支持所有 uni-app 支持的平台，特别是针对 App (Android, iOS, HarmonyOS) 进行了适配。

## 开发过程

### 1. 项目初始化与环境搭建

插件的开发基于 HBuilderX，利用其对 uni-app 和 UTS 的良好支持。

- **创建 uni-app 项目**：首先，创建一个标准的 uni-app 项目（如果还没有的话）。
- **创建 uni_module**：在项目根目录下创建 `uni_modules` 文件夹（如果不存在），然后在其中创建 `nutpi-idcard` 文件夹作为插件的根目录。
- **配置文件 `package.json`**：在 `nutpi-idcard` 目录下创建 `package.json` 文件，用于定义插件的基本信息、依赖、平台支持等。关键配置项包括：
  - `id`: 插件的唯一标识。
  - `displayName`: 插件在 HBuilderX 中显示的名称。
  - `version`: 插件版本号。
  - `description`: 插件描述。
  - `author`: 作者信息-坚果派。
  - `contact`: 联系方式。
  - `repository`: 代码仓库地址。
  - `engines`: HBuilderX 版本要求。
  - `dcloudext`: DCloud 扩展配置，如插件类型 (`uts`)、销售信息等。
  - `uni_modules`: uni-app 模块配置，如依赖、加密、平台支持等。

### 2. 核心逻辑实现 (`utssdk`)

插件的核心代码位于 `utssdk` 目录下，针对不同平台可以有不同的实现，但本项目中主要关注通用的 UTS 实现，特别是针对 HarmonyOS 的适配。

- **目录结构**：

  ```
  nutpi-idcard/
  ├── utssdk/
  │   ├── app-harmony/         # HarmonyOS 平台特定代码
  │   │   ├── index.uts        # HarmonyOS 入口及核心逻辑
  │   │   ├── interfaces.uts   # TypeScript 接口定义
  │   │   └── module/
  │   │       └── data/        # 数据文件 (行政区划、国家代码)
  │   │           ├── china.uts
  │   │           └── international.uts
  │   ├── app-android/       # Android 平台 (如果需要特定实现)
  │   ├── app-ios/           # iOS 平台 (如果需要特定实现)
  │   ├── index.uts          # 插件主入口 (通常导出各平台实现)
  │   └── interfaces.uts     # 通用接口定义
  ├── package.json
  ├── readme.md
  └── changelog.md
  ```

- **数据准备 (`module/data/`)**：

  - `china.uts`: 存储中国行政区划代码与名称的映射。
  - `international.uts`: 存储 ISO 3166-1 国家代码与名称的映射。

- **接口定义 (`interfaces.uts`)**：
  定义了身份证解析结果的数据结构 `IDResult`。

  ```typescript
  export interface IDResult {
      type?: string;       // 证件类型
      sign?: string;       // 签发机关或地区
      country?: string;    // 国家或地区
      birthday?: string;   // 出生日期 (YYYY-MM-DD)
      sex?: string;        // 性别 ('男' 或 '女')
      isValid?: boolean;   // 校验结果 (当前版本简单返回 true)
  }
  ```

- **核心解析逻辑 (`app-harmony/index.uts`)**：
  这是插件的核心，包含了主要的解析函数。

  - `parseID(id: string): IDResult`: 公开的 API 函数，根据身份证号码的格式（通过正则表达式判断）调用相应的内部解析函数。
  - `parserChina(id: string): IDResult`: 解析中国居民身份证和港澳台居民居住证。
    - 通过身份证号码的前6位确定省市区。
    - 通过第7到14位确定出生日期。
    - 通过第17位（顺序码的最后一位）确定性别。
  - `parserInternational(id: string): IDResult`: 解析外国人永久居留身份证。
    - 通过第1到3位（国家或地区代码）和 `international.uts` 数据确定国家。
    - 通过第7到14位确定出生日期。
    - 通过第17位确定性别。
  - `isIdCardValidInternal(id: string): boolean`: 身份证号码有效性校验函数。目前简单返回 `true`，未来可以根据国家标准实现更复杂的校验逻辑（如校验码计算）。

  ```typescript
  // idcard/uni_modules/nutpi-idcard/utssdk/app-harmony/index.uts
  import { chinaData as _china } from './module/data/china.uts';
  import { internationalData as _international } from './module/data/international.uts';
  import type { IDResult } from './interfaces.uts';
  
  function parserInternational(id: string): IDResult { /* ... */ }
  function parserChina(id: string): IDResult { /* ... */ }
  function isIdCardValidInternal(id: string): boolean { /* ... */ }
  
  export function parseID(id: string): IDResult {
      if(id.match(/^9\d{16}[0-9xX]$/)){ // 外国人永久居留身份证特征 (假设以9开头)
          return parserInternational(id);
      }else if(id.match(/^\d{17}[0-9xX]$/)){ // 中国居民身份证特征
          return parserChina(id);
      }else{
          return { type: '未知类型' };
      }
  }
  ```

### 3. 插件入口 (`index.uts`)

在 `nutpi-idcard` 根目录下的 `index.uts` 文件通常作为插件的统一入口，它会根据当前运行平台导出相应平台的 `parseID` 函数。

```typescript
// idcard/uni_modules/nutpi-idcard/index.uts
// #ifdef APP-HARMONY
export * from './utssdk/app-harmony/index.uts';
// #endif

// #ifdef APP-PLUS || APP-VUE
// 假设 Android 和 iOS 使用相同的 UTS 逻辑，或者有单独的 app-android/index.uts 和 app-ios/index.uts
// 如果 utssdk/index.uts 包含了 Android 和 iOS 的通用逻辑，可以这样导出：
// export * from './utssdk/index.uts'; 
// 或者分别导出
// #ifdef APP-ANDROID
// export * from './utssdk/app-android/index.uts';
// #endif
// #ifdef APP-IOS
// export * from './utssdk/app-ios/index.uts';
// #endif
// #endif

// 默认导出 (如果需要在非特定App平台使用，或者作为H5等平台的兜底)
// export * from './utssdk/index.uts'; // 假设 utssdk/index.uts 包含通用或web实现
```

*注意：上述 `index.uts` 的条件编译部分需要根据实际支持的平台和代码组织来编写。如果主要目标是 HarmonyOS，则 `APP-HARMONY` 部分是关键。*

### 4. 文档编写

- **`readme.md`**: 提供插件的详细说明，包括功能特性、安装方法、API 文档、使用示例、作者信息等。
- **`changelog.md`**: 记录插件的版本更新历史和主要变更。

### 5. 测试与调试

- 在 HBuilderX 中创建测试页面，引入插件并调用 `parseID` 函数，传入不同的身份证号码进行测试。
- 关注控制台输出，确保解析结果的准确性。
- 针对不同平台（特别是 HarmonyOS）进行真机或模拟器测试。

### 遇到的问题与解决

- **UTS 模块导入路径**：UTS 中模块导入路径需要精确。最初可能因为 `method.uts` 和 `index.uts` 的拆分导致函数重复声明或找不到定义的问题。通过将 `method.uts` 的内容合并到 `index.uts` 中解决了此问题。
- **Git 推送标签失败**：在版本发布时，如果本地没有对应的 Git 标签，`git push origin <tagname>` 会失败。通过先执行 `git tag <tagname>` 创建本地标签，然后再推送解决。
- **函数未定义错误**：在页面中调用插件函数时，如果导入路径不正确或插件未正确导出函数，会导致 `xxx is not defined` 错误。仔细检查插件的 `index.uts` 导出逻辑和页面中的导入路径，确保一致。

## 如何使用 `nutpi-idcard` 插件

1. **安装插件**：

   - 从 DCloud 插件市场安装。插件地址：https://ext.dcloud.net.cn/plugin?id=23728
   - 或者，如果手动引入，将 `nutpi-idcard` 整个文件夹复制到你的 uni-app 项目的 `uni_modules` 目录下。

2. **引入插件**：在需要使用的页面或组件的 `<script setup lang="uts">` 或 `<script lang="uts">` 中引入插件。

   ```typescript
   // 示例：在页面的 <script setup lang="uts"> 中
   import { parseID } from '@/uni_modules/nutpi-idcard'; // HBuilderX 会自动处理路径映射
   // 如果在 uni-app x 项目的 .uvue 文件中，路径可能需要更明确，或者依赖 HBuilderX 的智能提示
   ```

3. **调用解析函数**：使用 `parseID` 函数解析身份证号码。

   ```typescript
   const idNumber = '110101199003070978'; // 替换为实际的身份证号码
   const idInfo = parseID(idNumber);
   
   if (idInfo) {
       console.log('证件类型:', idInfo.type);
       console.log('签发地/国家:', idInfo.sign ?? idInfo.country);
       console.log('出生日期:', idInfo.birthday);
       console.log('性别:', idInfo.sex);
       console.log('是否有效:', idInfo.isValid);
   }
   ```

## API 参考

### `parseID(id: string): IDResult`

解析身份证号码并返回包含详细信息的对象。

- **参数**：

  -   `id: string` - 需要解析的身份证号码（18位中国居民身份证，或外国人永久居留身份证等）。

- **返回值**：`IDResult` 对象，其结构如下：

  ```typescript
  interface IDResult {
      type?: string;       // 证件类型 (例如：'居民身份证', '外国人永久居留身份证', '港澳台居民居住证', '未知类型')
      sign?: string;       // 签发机关或地区信息 (例如：'北京市市辖区', '北京市朝阳区')
      country?: string;    // 国家或地区 (例如：'中国', '无国籍' 或其他国家名称，主要用于外国人身份证)
      birthday?: string;   // 出生日期，格式为 'YYYY-MM-DD'
      sex?: string;        // 性别 ('男' 或 '女')
      isValid?: boolean;   // 身份证号码是否有效 (当前版本简单返回true，待实现详细校验逻辑)
  }
  ```

## 未来展望

- **完善校验逻辑**：实现更严格的身份证号码校验，包括校验码的计算与验证。
- **更广泛的证件类型支持**：考虑支持更多国家或地区的身份证件类型。
- **性能优化**：对数据查找和字符串处理进行优化，提高解析效率。
- **更详细的错误提示**：当输入格式错误或无法解析时，提供更具体的错误信息。
- **单元测试**：为插件编写完善的单元测试，确保代码质量和稳定性。

## 作者与联系方式

- **作者**：坚果派
- **公众号**：nutpi
- **电话**：17752170152
- **官网**：[https://www.nutpi.net/](https://www.nutpi.net/)
- **代码仓库**：[https://gitcode.com/nutpi/uni-idcard](https://gitcode.com/nutpi/uni-idcard)

希望这个插件能对您有所帮助！如果您有任何问题或建议，欢迎联系。



## 坚果派

坚果派社区由小波、狼哥等人创建，团队拥有数位华为HDE及1000+HarmonyOS开发者，以及若干其他领域的三十余位万粉博主/UP主运营。

专注于分享的技术包括HarmonyOS/OpenHarmony、仓颉、ArkUI-X、元服务、AI、BlueOS操作系统等。团队成员主要聚集在北京，上海，南京，深圳，广州，苏州、长沙、宁夏等地，目前已为华为、vivo、腾讯、亚马逊以及三方技术社区提供各类开发咨询服务100+。累计粉丝100+w，孵化开发者10w+，高校20+、企业10+。自研应用40款，三方库80个，鸿蒙原生应用课程500+。持续助力鸿蒙仓颉等生态繁荣发展。


