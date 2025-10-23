import 'package:flow_drawer/flow_drawer.dart';
import 'package:flutter/material.dart';

class FlowDrawerMenuItem extends StatelessWidget {
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

  final Icon icon;
  final String text;
  final double fontSize;
  final double spacing;
  final EdgeInsets padding;
  final VoidCallback? onTap;
  final int onTapDelay;
  final FlowDrawerController controller;

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
