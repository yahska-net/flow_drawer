import 'package:flow_drawer/src/controllers/flow_drawer_controller.dart';
import 'package:flow_drawer/src/enums/flow_drawer_positions_enum.dart';
import 'package:flutter/material.dart';

/// this items lists the drawer menu items // not the top bar
class FlowDrawerListWidget extends StatelessWidget {
  /// flow controlls
  const FlowDrawerListWidget({
    super.key,
    required this.drawerItems,
    required this.controller,
    required this.isOpen,
    required this.drawerPadding,
    required this.shrinkWrap,
    required this.physics,
    required this.position,
    required this.itemsEnterAnimationDelay,
  });

  /// drawer items
  final List<Widget> drawerItems;

  /// controller,
  final FlowDrawerController controller;

  /// recieves  vle bussy
  final bool isOpen;

  /// Shrin warp for drawer menu item list
  final bool shrinkWrap;

  /// drawer padding
  final EdgeInsets drawerPadding;

  /// Scrolls physics of list
  final ScrollPhysics physics;

  /// define alignment of list
  final FlowDrawerPosition position;

  /// each items enter animation delay
  final int itemsEnterAnimationDelay;

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
                      ? (position == FlowDrawerPosition.right ? 200 : 0)
                      : (position == FlowDrawerPosition.right ? 350 : -180),
                  0,
                  0,
                ),
                duration: Duration(
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
