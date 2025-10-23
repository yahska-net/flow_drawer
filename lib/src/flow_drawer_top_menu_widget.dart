import 'package:flow_drawer/flow_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FlowTopMenu extends HookWidget {
  const FlowTopMenu({
    super.key,
    this.menuWidth = double.infinity,
    required this.controller,
    this.animationDuration = 400,
    this.animationCurve = Curves.decelerate,

    // Left Menu Params
    this.leftMenuOffsetX = 80,
    this.leftMenuOffsetY = 0,
    this.leftMenuScale = 0,
    this.leftMenuRotateX = 0,
    this.leftMenuRotateY = 0,
    this.leftMenuRotateZ = 0,
    this.leftMenuInitOffset = const Offset(-30, 0),
    required this.leftMenuIcon,
    this.onLeftTap,
    this.leftMenuBgColor = Colors.white,
    this.leftMenuBgAlpha = 50,
    this.leftMenuRadius = 50,
    this.leftMenuPadding = const EdgeInsets.all(14),

    // Right Menu Params
    this.rightMenuOffsetX = -80,
    this.rightMenuOffsetY = 0,
    this.rightMenuScale = 0,
    this.rightMenuRotateX = 0,
    this.rightMenuRotateY = 0,
    this.rightMenuRotateZ = 0,
    this.rightMenuInitOffset = const Offset(30, 0),
    required this.rightMenuIcon,
    this.onRightTap,
    this.rightMenuBgColor = Colors.white,
    this.rightMenuBgAlpha = 50,
    this.rightMenuRadius = 50,
    this.rightMenuPadding = const EdgeInsets.all(14),
  });

  final double menuWidth;
  final int animationDuration;
  final Curve animationCurve;
  final FlowDrawerController controller;

  // Left Menu Controls
  final double leftMenuOffsetX;
  final double leftMenuOffsetY;
  final double leftMenuScale;
  final double leftMenuRotateX;
  final double leftMenuRotateY;
  final double leftMenuRotateZ;
  final Offset leftMenuInitOffset;
  final Icon leftMenuIcon;
  final VoidCallback? onLeftTap;
  final Color leftMenuBgColor;
  final int leftMenuBgAlpha;
  final double leftMenuRadius;
  final EdgeInsets leftMenuPadding;

  // Right Menu Controls
  final double rightMenuOffsetX;
  final double rightMenuOffsetY;
  final double rightMenuScale;
  final double rightMenuRotateX;
  final double rightMenuRotateY;
  final double rightMenuRotateZ;
  final Offset rightMenuInitOffset;
  final Icon rightMenuIcon;
  final VoidCallback? onRightTap;
  final Color rightMenuBgColor;
  final int rightMenuBgAlpha;
  final double rightMenuRadius;
  final EdgeInsets rightMenuPadding;

  @override
  Widget build(BuildContext context) {
    final ticker = useSingleTickerProvider();
    final animationController = useMemoized(
      () => AnimationController(
        vsync: ticker,
        duration: Duration(milliseconds: animationDuration),
      ),
    );

    useEffect(() => animationController.dispose, []);

    final isOpen = useListenable(controller).isOpen;

    useEffect(() {
      if (isOpen) {
        animationController.forward();
      } else {
        animationController.reverse();
      }
      return null;
    }, [isOpen]);

    final animation = useAnimation(
      Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: animationController, curve: animationCurve),
      ),
    );

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
        width: menuWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left Animated Menu Button
            Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, -0.0018)
                ..translateByDouble(
                  leftMenuOffsetX * animation,
                  leftMenuOffsetY * animation,
                  0,
                  1 + (animation * leftMenuScale),
                )
                ..rotateZ(leftMenuRotateZ * animation)
                ..rotateX(leftMenuRotateX * animation)
                ..rotateY(leftMenuRotateY * animation),
              child: Transform.translate(
                offset: leftMenuInitOffset,
                child: GestureDetector(
                  onTap: onLeftTap,
                  child: Container(
                    padding: leftMenuPadding,
                    decoration: BoxDecoration(
                      color: leftMenuBgColor.withAlpha(leftMenuBgAlpha),
                      borderRadius: BorderRadius.circular(leftMenuRadius),
                    ),
                    child: leftMenuIcon,
                  ),
                ),
              ),
            ),

            // Right Close Button (Animated)
            Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, -0.0018)
                ..translateByDouble(
                  rightMenuOffsetX * animation,
                  rightMenuOffsetY * animation,
                  0,
                  1 + (animation * rightMenuScale),
                )
                ..rotateZ(rightMenuRotateZ * animation)
                ..rotateX(rightMenuRotateX * animation)
                ..rotateY(rightMenuRotateY * animation),
              child: Transform.translate(
                offset: rightMenuInitOffset,
                child: GestureDetector(
                  onTap: onRightTap,
                  child: Container(
                    padding: rightMenuPadding,
                    decoration: BoxDecoration(
                      color: rightMenuBgColor.withAlpha(rightMenuBgAlpha),
                      borderRadius: BorderRadius.circular(rightMenuRadius),
                    ),
                    child: rightMenuIcon,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
