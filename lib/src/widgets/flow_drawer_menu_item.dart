import 'package:flow_drawer/flow_drawer.dart';
import 'package:flutter/material.dart';

/// A ready-to-use, accessible menu item for a [FlowDrawer].
class FlowDrawerMenuItem extends StatelessWidget {
  /// Creates a drawer menu item.
  const FlowDrawerMenuItem({
    super.key,
    required this.icon,
    required this.text,
    this.fontSize = 22,
    this.spacing = 18,
    this.padding = const EdgeInsets.all(8.0),
    this.onTap,
    this.onTapDelay = 0,
    required this.controller,
  });

  /// Icon shown before [text].
  final Icon icon;

  /// Visible label for the item.
  final String text;

  /// Font size of [text].
  final double fontSize;

  /// Space between [icon] and [text].
  final double spacing;

  /// Padding around the item's contents.
  final EdgeInsets padding;

  /// Called when the item is selected, after any configured [onTapDelay].
  final VoidCallback? onTap;

  /// Optional delay before invoking [onTap]. Defaults to no delay.
  final int onTapDelay;

  /// Controller used to close the drawer when selected.
  final FlowDrawerController controller;

  /// Closes the drawer and invokes or schedules the item's callback.
  void handleMenuClick({
    required FlowDrawerController controller,
    VoidCallback? onTap,
    required int delay,
  }) {
    controller.close();

    if (onTap == null) return;
    if (delay <= 0) {
      onTap();
    } else {
      Future.delayed(Duration(milliseconds: delay), onTap);
    }
  }

  @override
  Widget build(BuildContext context) {
    void activate() => handleMenuClick(
      controller: controller,
      onTap: onTap,
      delay: onTapDelay,
    );

    return Semantics(
      button: true,
      enabled: onTap != null,
      label: text,
      onTap: onTap == null ? null : activate,
      child: InkWell(
        excludeFromSemantics: true,
        canRequestFocus: onTap != null,
        onTap: onTap == null ? null : activate,
        child: ExcludeSemantics(
          child: Padding(
            padding: padding,
            child: Row(
              children: [
                icon,
                SizedBox(width: spacing),
                Flexible(
                  child: Text(
                    text,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: fontSize,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
