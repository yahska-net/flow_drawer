import 'package:flow_drawer/flow_drawer.dart';
import 'package:flutter/material.dart';

/// Sample Drawer menu list item for easy implementation of flow drawer. With this widget user can add drawer menu items easly with or without a cutsom widget.
class FlowDrawerMenuItem extends StatelessWidget {
  /// controlls of this widget
  const FlowDrawerMenuItem({
    super.key,
    required this.icon,
    required this.text,
    this.fontSize = 22,
    this.spacing = 18,
    this.padding = const EdgeInsets.all(8.0),
    this.onTap,
    this.onTapDelay = 400,
    required this.controller,
  });

  /// changes the icon
  final Icon icon;

  /// changes the text
  final String text;

  ///. changes the text font size
  final double fontSize;

  /// spacing between icon and text
  final double spacing;

  /// padding arouynd the icon and text
  final EdgeInsets padding;

  /// void call back function
  final VoidCallback? onTap;

  ///. controlls the delay for excecuting the ontap function, basically after the animation time
  final int onTapDelay;

  /// recieves flow conroller
  final FlowDrawerController controller;

  /// handles the menu iten
  void handleMenuClick({
    required FlowDrawerController controller,
    VoidCallback? onTap,
    required int delay,
  }) {
    controller.close();

    if (onTap != null) {
      Future.delayed(Duration(milliseconds: delay), onTap);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => handleMenuClick(
        controller: controller,
        onTap: onTap,
        delay: onTapDelay,
      ),
      child: Padding(
        padding: padding,
        child: Row(
          children: [
            icon,
            SizedBox(width: spacing),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
