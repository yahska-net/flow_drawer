import 'package:flow_drawer/flow_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FlowDrawerController', () {
    test('changes state and only notifies for real transitions', () {
      final controller = FlowDrawerController();
      addTearDown(controller.dispose);
      var notifications = 0;
      controller.addListener(() => notifications++);

      controller.open();
      controller.open();
      expect(controller.isOpen, isTrue);
      expect(notifications, 1);

      controller.close();
      controller.close();
      expect(controller.isOpen, isFalse);
      expect(notifications, 2);

      controller.toggle();
      expect(controller.isOpen, isTrue);
      expect(notifications, 3);
    });
  });

  group('FlowDrawer', () {
    testWidgets('opens and closes from its controller', (tester) async {
      final controller = FlowDrawerController();
      addTearDown(controller.dispose);
      await tester.pumpWidget(_testApp(controller: controller));

      expect(_itemTranslationX(tester), -180);

      controller.open();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 60));
      await tester.pump();
      expect(_itemTranslationX(tester), 0);

      controller.close();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 160));
      await tester.pump();
      expect(_itemTranslationX(tester), -180);
    });

    testWidgets('right-docked items settle at the visible position', (
      tester,
    ) async {
      final controller = FlowDrawerController();
      addTearDown(controller.dispose);
      await tester.pumpWidget(
        _testApp(controller: controller, position: FlowDrawerPosition.right),
      );

      expect(_itemTranslationX(tester), 180);
      controller.open();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 60));
      await tester.pump();
      expect(_itemTranslationX(tester), 0);
    });

    testWidgets('cancels stale item timers during rapid toggles', (
      tester,
    ) async {
      final controller = FlowDrawerController();
      addTearDown(controller.dispose);
      await tester.pumpWidget(_testApp(controller: controller));

      controller.open();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 25));
      controller.close();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 25));
      controller.open();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 250));
      await tester.pump();

      expect(controller.isOpen, isTrue);
      expect(_itemTranslationX(tester), 0);
      expect(tester.takeException(), isNull);
    });

    testWidgets('cancels pending timers when removed', (tester) async {
      final controller = FlowDrawerController();
      addTearDown(controller.dispose);
      await tester.pumpWidget(_testApp(controller: controller));

      controller.open();
      await tester.pump();
      await tester.pumpWidget(const SizedBox());
      await tester.pump(const Duration(seconds: 1));

      expect(tester.takeException(), isNull);
    });

    testWidgets('honors reduced-motion preferences immediately', (
      tester,
    ) async {
      final controller = FlowDrawerController();
      addTearDown(controller.dispose);
      await tester.pumpWidget(
        _testApp(controller: controller, disableAnimations: true),
      );

      controller.open();
      await tester.pump();
      expect(_itemTranslationX(tester), 0);
    });

    testWidgets('opens from the physical edge swipe', (tester) async {
      final controller = FlowDrawerController();
      addTearDown(controller.dispose);
      await tester.pumpWidget(_testApp(controller: controller));

      await tester.dragFrom(const Offset(5, 300), const Offset(80, 0));
      await tester.pump();

      expect(controller.isOpen, isTrue);
    });
  });

  group('FlowDrawerMenuItem', () {
    testWidgets('exposes button semantics and runs its delayed action', (
      tester,
    ) async {
      final controller = FlowDrawerController()..open();
      addTearDown(controller.dispose);
      var selected = false;
      final semantics = tester.ensureSemantics();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlowDrawerMenuItem(
              icon: const Icon(Icons.home),
              text: 'Home',
              onTapDelay: 100,
              onTap: () => selected = true,
              controller: controller,
            ),
          ),
        ),
      );

      expect(
        tester.getSemantics(find.text('Home')),
        matchesSemantics(
          label: 'Home',
          isButton: true,
          hasEnabledState: true,
          isEnabled: true,
          isFocusable: true,
          hasTapAction: true,
          hasFocusAction: true,
        ),
      );

      await tester.tap(find.text('Home'));
      expect(controller.isOpen, isFalse);
      expect(selected, isFalse);
      await tester.pump(const Duration(milliseconds: 100));
      expect(selected, isTrue);
      semantics.dispose();
    });
  });
}

Widget _testApp({
  required FlowDrawerController controller,
  FlowDrawerPosition position = FlowDrawerPosition.left,
  bool disableAnimations = false,
}) {
  final drawer = position == FlowDrawerPosition.left
      ? FlowDrawer(
          controller: controller,
          drawerItems: const [SizedBox(key: Key('drawer-item'), height: 48)],
          itemsEnterDelay: 50,
          itemsExitDelay: 150,
          child: const ColoredBox(key: Key('main-screen'), color: Colors.white),
        )
      : FlowDrawer.rightDocked(
          controller: controller,
          drawerItems: const [SizedBox(key: Key('drawer-item'), height: 48)],
          itemsEnterDelay: 50,
          itemsExitDelay: 150,
          child: const ColoredBox(key: Key('main-screen'), color: Colors.white),
        );

  return MaterialApp(
    home: MediaQuery(
      data: MediaQueryData(disableAnimations: disableAnimations),
      child: Scaffold(body: drawer),
    ),
  );
}

double _itemTranslationX(WidgetTester tester) {
  final animatedContainer = tester.widget<AnimatedContainer>(
    find.ancestor(
      of: find.byKey(const Key('drawer-item')),
      matching: find.byType(AnimatedContainer),
    ),
  );
  return animatedContainer.transform!.getTranslation().x;
}
