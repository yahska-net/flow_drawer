import 'package:flow_drawer/src/flow_drawer_controller.dart';
import 'package:flutter/material.dart';

class FlowDrawerListWidget extends StatelessWidget {
  const FlowDrawerListWidget({
    super.key,
    required this.drawerItems,
    required this.controller,
    required this.isOpen,
    required this.drawerPadding,
  });

  final List<Widget> drawerItems;
  final FlowDrawerController controller;
  final bool isOpen;
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
