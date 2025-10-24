import 'package:flow_drawer/src/controllers/flow_drawer_controller.dart';
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
  });

  /// drawer items
  final List<Widget> drawerItems;

  /// controller,
  final FlowDrawerController controller;

  /// recieves  vle bussy
  final bool isOpen;

  /// drawer padding
  final EdgeInsets drawerPadding;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: drawerPadding,
          // color: Colors.blue,
          child: ListView.builder(
            itemCount: drawerItems.length,
            itemBuilder: (context, index) => AnimatedContainer(
              curve: Curves.decelerate,
              transform: Matrix4.translationValues(isOpen ? 0 : -180, 0, 0),
              duration: Duration(milliseconds: 200 + (index * 20)),
              child: drawerItems[index],
            ),
          ),
        ),
      ),
    );
  }
}
