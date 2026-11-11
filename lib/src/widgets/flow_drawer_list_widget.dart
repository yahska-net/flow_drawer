import 'package:flow_drawer/src/enums/flow_drawer_positions_enum.dart';
import 'package:flutter/material.dart';

/// Displays and animates the drawer's menu items.
class FlowDrawerListWidget extends StatelessWidget {
  /// Creates a list of animated drawer items.
  const FlowDrawerListWidget({
    super.key,
    required this.drawerItems,
    required this.isOpen,
    required this.drawerPadding,
    required this.shrinkWrap,
    required this.physics,
    required this.position,
    required this.itemsEnterAnimationDelay,
    this.disableAnimations = false,
  });

  /// Widgets displayed in the drawer.
  final List<Widget> drawerItems;

  /// Whether the items should be in their visible position.
  final bool isOpen;

  /// Whether the list should size itself to its contents.
  final bool shrinkWrap;

  /// Padding around the drawer items.
  final EdgeInsets drawerPadding;

  /// Scroll behavior for the item list.
  final ScrollPhysics physics;

  /// Physical edge where the items are aligned.
  final FlowDrawerPosition position;

  /// Additional animation duration applied to each successive item.
  final int itemsEnterAnimationDelay;

  /// Whether item transitions should complete without animation.
  final bool disableAnimations;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: drawerPadding,
          child: Align(
            alignment: position == FlowDrawerPosition.right
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: ListView.builder(
              itemCount: drawerItems.length,
              shrinkWrap: shrinkWrap,
              physics: physics,
              itemBuilder: (context, index) => AnimatedContainer(
                curve: Curves.decelerate,
                transform: Matrix4.translationValues(
                  isOpen
                      ? 0
                      : (position == FlowDrawerPosition.right ? 180 : -180),
                  0,
                  0,
                ),
                duration: disableAnimations
                    ? Duration.zero
                    : Duration(
                        milliseconds: 200 + (index * itemsEnterAnimationDelay),
                      ),
                child: drawerItems[index],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
