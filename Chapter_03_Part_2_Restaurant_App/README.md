# Sample App 2 - Restaurant (Food Menu)

一个 Flutter 餐厅菜单应用，展示食物分类和健康食谱列表。

## 功能说明

### 首页 (HomePage)
- **自定义 AppBar**：显示 "Food Menu" 标题，右侧有菜单按钮
- **搜索栏**：圆角搜索框 UI（纯展示）
- **分类区域 (Category)**：水平滚动的食物分类卡片，使用 SVG 图标
  - Salad（沙拉）
  - Cake（蛋糕）
  - Pie（派）
- **食谱区域 (Healthy Recipes)**：垂直列表展示食谱卡片
  - Honey Pancake - Easy / 30mins / 180kcal
  - Canai Bread - Medium / 45mins / 230kcal

## 项目结构

```
lib/
├── main.dart              # 应用入口
├── homepage.dart           # 首页界面（AppBar、搜索栏、分类、食谱列表）
└── models/
    ├── category.dart       # 分类数据模型（CategoryModel）
    └── diet.dart           # 食谱数据模型（DietModel）

assets/
├── icons/                  # SVG 图标文件
│   ├── cake.svg
│   ├── pie.svg
│   └── salad.svg
└── images/                 # 食谱图片
    ├── canai-bread.jpg
    └── honey-pancake.jpg
```

## 依赖项

| 包名 | 版本 | 用途 |
|------|------|------|
| flutter_svg | ^2.2.4 | 渲染 SVG 图标 |
| cupertino_icons | ^1.0.8 | iOS 风格图标 |

## 运行方式

```bash
cd sample_app_2_restaurant
flutter pub get
flutter run
```

## 迁移说明

本项目的业务代码从 `sample_app_1` 迁移而来。`sample_app_1` 是一个 Flutter package 项目（非标准应用项目），无法直接运行。迁移过程中完成了以下调整：
- 将所有 Dart 源文件复制到本项目的 `lib/` 目录
- 将包名引用从 `smaple_app_1` 更新为 `sample_app_2_restaurant`
- 将资源文件（SVG 图标、图片）复制到本项目的 `assets/` 目录
- 在 `pubspec.yaml` 中添加了 `flutter_svg` 依赖和资源声明
- 入口文件使用标准的 `lib/main.dart`（原项目使用 `lib/mainrestaurant.dart`）
