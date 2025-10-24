import 'package:flow_drawer/flow_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Top Bar Menu inside Flow Drawer
class FlowTopMenu extends HookWidget {
  /// Top bar Menu Controlls
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

  /// controlls width of top bar menu
  final double menuWidth;

  /// controlls the duration of animation
  final int animationDuration;

  /// controlls the animation curve
  final Curve animationCurve;

  /// controller for animation open, close and toggle
  final FlowDrawerController controller;

  // Left Menu Controls
  /// moves the left menu button in x axis
  final double leftMenuOffsetX;

  /// moves the left menu button in y axis
  final double leftMenuOffsetY;

  /// uses to scale up and down view size
  final double leftMenuScale;

  /// uses to rotate leftside menu button in x axis
  final double leftMenuRotateX;

  /// uses to rotate leftside menu button in y axis
  final double leftMenuRotateY;

  /// uses to rotate leftside menu button in z axis
  final double leftMenuRotateZ;

  /// this set the position of left menu button when controller is in closed state
  final Offset leftMenuInitOffset;

  /// used to change icon of left menu
  final Icon leftMenuIcon;

  /// void callback function on tap
  final VoidCallback? onLeftTap;

  /// controlls the color of left button menu background
  final Color leftMenuBgColor;

  /// controlls the alpha value of the color
  final int leftMenuBgAlpha;

  /// controlls the left menu button radius
  final double leftMenuRadius;

  /// controlls the left menu button padding
  final EdgeInsets leftMenuPadding;

  // Right Menu Controls
  /// moves the right menu button in x axis
  final double rightMenuOffsetX;

  /// moves the right menu button in y axis
  final double rightMenuOffsetY;

  /// scale right menu bar button
  final double rightMenuScale;

  /// ratate right side menu bar in x axis
  final double rightMenuRotateX;

  /// rotate right side menu bar in y axis
  final double rightMenuRotateY;

  /// rotate right side menu bar in z axis
  final double rightMenuRotateZ;

  /// sets initial position of right side top bar menu button
  final Offset rightMenuInitOffset;

  /// changes the icon for right menu
  final Icon rightMenuIcon;

  /// void callback fn on tap right button
  final VoidCallback? onRightTap;

  /// changes the color of right menu bar
  final Color rightMenuBgColor;

  /// changes the alpha value of color
  final int rightMenuBgAlpha;

  /// change the radius of right side bar menu
  final double rightMenuRadius;

  /// controlls the padding
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
