import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders and opens the right-docked drawer', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Flow Drawer'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.menu_outlined));
    await tester.pumpAndSettle();

    expect(find.text('Security'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
