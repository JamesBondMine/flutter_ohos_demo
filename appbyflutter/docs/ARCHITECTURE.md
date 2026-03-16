# 木兰 App - 项目架构说明

本文档描述正式化后的 Flutter 项目架构，便于多人协作、功能扩展与长期维护。

---

## 一、整体架构图

```
lib/
├── main.dart                 # 应用入口：GetStorage 初始化 + runApp(App())
├── app.dart                  # GetMaterialApp + 主题 + 普通/长辈模式（字体缩放）
│
├── core/                     # 核心层：与业务无关的公共能力
│   ├── config/               # 环境与配置
│   ├── constants/            # 常量、枚举
│   ├── auth/                 # 全局登录状态（AuthController）
│   ├── theme/                # 主题、颜色、字体、显示模式（普通/长辈）
│   │   ├── app_theme.dart
│   │   ├── display_mode.dart
│   │   └── display_mode_controller.dart  # GetX 全局控制器
│   ├── router/               # 路由与命名路由
│   ├── utils/                # 工具函数
│   └── extensions/           # Dart 扩展方法
│
├── features/                 # 功能层：按业务模块划分
│   ├── auth/                 # 登录/鉴权（一键登录、手机号验证码登录）
│   │   ├── data/             # 数据源、DTO、Repository 实现
│   │   ├── domain/           # 用例、实体、Repository 抽象（可选）
│   │   ├── presentation/     # 页面、GetX Controller（按需）
│   │   └── auth_routes.dart  # 本模块路由
│   └── home/                 # 首页（示例，后续按需添加）
│       └── ...
│
└── shared/                   # 共享层：跨功能复用的 UI 与能力
    ├── widgets/              # 通用组件（CustomButton、DisplayModeSwitch 等）
    ├── services/             # 全局服务（如易盾 SDK 封装）
    └── l10n/                 # 国际化（可选）
```

---

## 二、分层职责

### 1. 入口与 App 根

| 文件/目录 | 职责 |
|-----------|------|
| `main.dart` | `GetStorage.init()` 后 `runApp(App())`，可做崩溃收集、环境选择等初始化。 |
| `app.dart` | 使用 **GetMaterialApp**，注入 **DisplayModeController**、**AuthController**；根页面为 **AppEntry**，根据「是否已选显示模式」与「登录状态」决定首屏；按普通/长辈模式应用 **MediaQuery.textScaleFactor**。 |

### 2. core/ 核心层

- **config**：环境（dev/staging/prod）、API 基地址、易盾等第三方 AppKey 配置。
- **constants**：字符串常量、魔法数字、通用 key（如 `success`）。
- **theme**：`ThemeData`、主色、圆角、间距等设计 token；**DisplayMode**（普通/长辈）与 **DisplayModeController**（GetX，持久化字体缩放）。
- **router**：路由表、命名路由、未登录拦截、深链。
- **utils**：格式化、校验（手机号、验证码）、日期、安全存储等。
- **extensions**：如 `StringExtension`、`BuildContextExtension`（navigate、theme）等。

### 3. features/ 功能层

每个 feature 建议按「**数据 / 领域 / 展示**」拆分（可简化）：

- **data**：接口调用、本地存储、易盾等 SDK 的封装与 DTO。
- **domain**（可选）：业务实体、Repository 接口、UseCase。
- **presentation**：页面（Screen/Page）、GetX Controller（按需）、本模块内 Widget。

同一 feature 内通过「依赖注入」或「直接依赖抽象」引用 core 与 shared，避免 feature 间直接依赖。

### 4. shared/ 共享层

- **widgets**：如 `CustomButton`、`DisplayModeSwitch`（普通/长辈模式切换）、LoadingOverlay、通用表单输入框等。
- **services**：易盾一键登录的封装（init、preFetch、onePass、verifyPhone）、全局 Loading、Toast 等。
- **l10n**（可选）：多语言文案。

---

## 三、技术选型（当前采用）

| 类别 | 选型 | 说明 |
|------|------|------|
| **状态管理** | **GetX** | 全局/页面级 GetxController，Obx/GetBuilder 驱动 UI；路由、依赖注入一体。 |
| **显示模式** | **普通 / 长辈模式** | `DisplayModeController` 管理，通过 `MediaQuery.textScaleFactor` 放大字体，偏好持久化（GetStorage）。 |
| 路由 | GetX 路由 或 go_router | 命名路由 + 未登录重定向到登录页。 |
| 网络 | dio（建议） | 统一封装请求/响应/错误、Token 注入。 |
| 本地存储 | get_storage / shared_preferences | 显示模式、Token、用户信息等。 |
| 依赖注入 | Get.put() / Get.lazyPut() | 与 GetX 配套，页面级可用 GetView\<XxxController>。 |
| 环境配置 | --dart-define 或 flavor | dev / staging / prod 不同 API 与 AppKey。 |

---

## 四、GetX 与普通/长辈模式

### 4.1 GetX 在 app 中的使用

- **根容器**：使用 `GetMaterialApp`（在 `app.dart` 中），以支持 GetX 路由、SnackBar、依赖注入等。
- **全局控制器**：在 `App.build()` 中通过 `Get.put(DisplayModeController())` 注入，整个应用内可用 `Get.find<DisplayModeController>()` 或子页面通过 `GetView`/Obx 使用。
- **响应式更新**：`DisplayModeController.mode` 为 `Rx<DisplayMode>`，切换模式后通过 `Obx` 包裹的 `GetMaterialApp` 的 `builder` 重建，从而更新 `MediaQuery.textScaleFactor`，实现全局字体缩放。

### 4.2 普通模式 / 长辈模式

- **定义**：`core/theme/display_mode.dart` 中枚举 `DisplayMode`（`normal` / `elder`），长辈模式对应更大字体（当前为 1.25 倍）。
- **持久化**：选择结果通过 `get_storage` 写入本地，下次启动自动恢复。
- **首次选择**：未选过时（`hasChosenDisplayMode == false`）首屏为 **DisplayModeSelectionPage**，用户选择后调用 `selectAndConfirm(mode)`，再根据登录状态进入登录页或首页。
- **切换入口**：在设置页或个人中心放置 `DisplayModeSwitch()`（见 `shared/widgets/display_mode_switch.dart`），或任意处调用 `Get.find<DisplayModeController>().toggleMode()` / `setMode(DisplayMode.elder)`。

### 4.3 即时通讯 APP 启动流程（AppEntry）

1. **首次启动或未选过显示模式**：展示「普通模式 / 长辈模式」选择页（`DisplayModeSelectionPage`），用户选择后调用 `DisplayModeController.selectAndConfirm(mode)`，再根据登录状态进入下一步。
2. **已选过显示模式**：根据 **AuthController.isLoggedIn**（持久化）决定：
   - 未登录或登录失效 → 进入 **LoginPage**；
   - 已登录 → 进入 **HomePage**（即时通讯首页）。
3. 登录成功（一键登录或手机号验证码）后调用 `AuthController.setLoggedIn(true)`，由 `AppEntry` 的 Obx 自动切到首页；登出调用 `AuthController.logout()` 后回到登录页。

---

## 五、命名与规范

- **页面**：`XxxPage` 或 `XxxScreen`，与路由名一致便于查找。
- **状态/逻辑**：GetX 下使用 `XxxController` 继承 `GetxController`，与页面一一对应或按用例拆分；全局单例可用 `Get.put()`。
- **Widget**：组件用名词，如 `CustomButton`、`PhoneLoginForm`。
- **文件**：小写 + 下划线，如 `phone_login_page.dart`、`auth_repository.dart`。
- **路由名**：常量集中放在 `core/router/app_routes.dart`，如 `/login`、`/home`。

---

## 六、当前迁移顺序建议

1. **建立目录**：按上述结构创建 `core/`、`features/auth/`、`shared/` 及子目录。
2. **抽离 core**：把主题、常量、易盾 AppKey 等移到 core；`main.dart` 只保留 `runApp(App())`，`app.dart` 配置 MaterialApp。
3. **抽离 shared**：将 `CustomButton`、全局 Loading 等移到 `shared/widgets`；易盾调用封装到 `shared/services` 或 `features/auth/data`。
4. **拆登录 feature**：在 `features/auth/presentation` 下实现「一键登录页」与「手机号验证码登录页」，状态可用 GetX Controller 管理，数据层调用 shared 或 auth 的 data。
5. **路由**：在 `app.dart` 中配置路由表，登录成功跳转首页；未登录访问需鉴权页时重定向到登录。
6. **后续**：按业务增加 `features/home`、`features/user` 等，并接入接口、状态管理、错误处理与埋点。

---

## 七、与现有代码的对应关系

| 当前 main.dart 内容 | 迁移目标 |
|--------------------|----------|
| `main()` + `MaterialApp` | `main.dart` + `app.dart` |
| 主题、标题 | `core/theme/app_theme.dart` |
| 易盾 init / preFetch / onePass / verifyPhone | `shared/services/quick_login_service.dart` 或 `features/auth/data/` |
| 一键登录 UI + 手机号登录 UI | `features/auth/presentation/` 下的 Page + 状态类 |
| `CustomButton` | `shared/widgets/custom_button.dart` |
| 成功/失败 key、AppKey 等 | `core/constants/`、`core/config/` |

按此架构逐步迁移，可在不影响现有功能的前提下，将「木兰 App」改为结构清晰、易于扩展的正式项目。
