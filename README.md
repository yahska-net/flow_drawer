## 🎬 Demo

![Flow Drawer Demo - Left Docked Drawer](https://github.com/yahska-net/flow_drawer/blob/main/assets/flow_drawer_left_dock.gif?raw=true)

![Flow Drawer Demo - Right Docked Drawer](https://github.com/yahska-net/flow_drawer/blob/main/assets/flow_drawer_right_dock.gif?raw=true)

# flow_drawer

A flexible and animated side drawer package for Flutter.  
Easily add beautiful, responsive, and smooth-flowing drawers to your app — perfect for menus, sidebars, or custom navigation.

---

## ✨ Features

- 🎯 Smooth animated drawer transitions
- 🧱 Customizable drawer items
- 🎮 Controller to open/close programmatically
- 📐 Supports top menu layout
- 🧩 Easy integration with any app structure

---

## 🚀 Getting Started

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  flow_drawer: ^1.0.0
```

Then run:

```bash
flutter pub get
```

---

## 📦 Import

```dart
import 'package:flow_drawer/flow_drawer.dart';
```

---

## 🛠️ Usage

```dart
final controller = FlowDrawerController();

FlowDrawer(
  controller: controller,
  drawer: FlowDrawerListWidget(
    items: [
      FlowDrawerMenuItem(
        icon: Icon(Icons.home, color: Colors.white),
        text: "Home",
        onTap: () => print("Home tapped"),
        controller: controller,
      ),
      // Add more items...
    ],
  ),
  child: YourMainScreen(),
)
```

---

## 📄 Widgets

### ✅ `FlowDrawer`

Main drawer widget that wraps your screen.

### ✅ `FlowDrawerController`

Used to control drawer open/close programmatically.

### ✅ `FlowDrawerMenuItem`

Each item in the drawer list. Customizable with icon, text, and onTap.

### ✅ `FlowDrawerListWidget`

Vertical list layout for drawer items.

### ✅ `FlowDrawerTopMenuWidget`

Optional top widget to show user info, avatar, etc.

---

## 📂 Example

A full working example is available in the [`/example`](example) folder.

---

## 📸 Screenshots

<!-- ![Drawer Screenshot](assets/screenshot.png) -->

---

## 🧪 Testing

Run tests with:

```bash
flutter test
```

---

## 📄 License

MIT © [Akshay Kumar K M](https://github.com/akshaykumarkm)  
_Powered by: [www.yahska.net](https://www.yahska.net)_

---

## 🤝 Contribute

Pull requests and issues are welcome!  
If you find this package useful, please ⭐ it on [GitHub](https://github.com/akshaykumarkm/flow_drawer).
