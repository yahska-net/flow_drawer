# Flow Drawer

A customizable animated drawer for Flutter with left- and right-docked layouts, controller-driven state, swipe gestures, reduced-motion support, and accessible menu controls.

![Left-docked Flow Drawer](https://github.com/yahska-net/flow_drawer/blob/main/assets/flow_drawer_left_dock.gif?raw=true)

![Right-docked Flow Drawer](https://github.com/yahska-net/flow_drawer/blob/main/assets/flow_drawer_right_dock.gif?raw=true)

## Features

- Animated left- and right-docked drawers
- Programmatic `open`, `close`, and `toggle` control
- Edge swipe to open and directional swipe to close
- Custom drawer backgrounds, transforms, shadows, and item widgets
- Optional animated top controls
- Reduced-motion support through Flutter's `MediaQuery`
- Semantic, keyboard-focusable prebuilt menu items

## Installation

Add the current package version to your `pubspec.yaml`:

```yaml
dependencies:
  flow_drawer: ^0.0.4
```

Then run `flutter pub get` and import the package:

```dart
import 'package:flow_drawer/flow_drawer.dart';
```

## Usage

Create and dispose a controller with the lifecycle of your screen:

```dart
class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final _drawerController = FlowDrawerController();

  @override
  void dispose() {
    _drawerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlowDrawer(
      controller: _drawerController,
      drawerItems: [
        FlowDrawerMenuItem(
          icon: const Icon(Icons.home, color: Colors.white),
          text: 'Home',
          controller: _drawerController,
          onTap: () {
            // Navigate after the drawer's closing animation.
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flow Drawer'),
          leading: IconButton(
            tooltip: 'Open navigation',
            icon: const Icon(Icons.menu),
            onPressed: _drawerController.open,
          ),
        ),
        body: const Center(child: Text('Main content')),
      ),
    );
  }
}
```

Use `FlowDrawer.rightDocked(...)` for a drawer attached to the right edge.

## Optional top menu

Pass a `FlowTopMenu` through `topMenu` when `enableTopMenu` is enabled:

```dart
FlowTopMenu(
  controller: _drawerController,
  leftMenuIcon: const Icon(Icons.person, color: Colors.white),
  leftMenuTooltip: 'Profile',
  onLeftTap: () {},
  rightMenuIcon: const Icon(Icons.close, color: Colors.white),
  rightMenuTooltip: 'Close navigation',
  onRightTap: _drawerController.close,
)
```

## Testing

```bash
flutter analyze
flutter test
```

See the complete runnable application in [`example/`](example).

## License

MIT © [Akshay Kumar K M](https://github.com/akshaykumarkm). Powered by [Yahska](https://www.yahska.net).
