import 'package:flow_drawer/flow_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Animated leading and trailing controls displayed above a [FlowDrawer].
class FlowTopMenu extends HookWidget {
  /// Creates an animated top menu.
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
    this.leftMenuTooltip,

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
    this.rightMenuTooltip,
  });

  /// Width of the top menu.
  final double menuWidth;

  /// Animation duration in milliseconds.
  final int animationDuration;

  /// Curve applied to the animation.
  final Curve animationCurve;

  /// Controller whose state drives the animation.
  final FlowDrawerController controller;

  // Left Menu Controls
  /// Horizontal travel of the left control.
  final double leftMenuOffsetX;

  /// Vertical travel of the left control.
  final double leftMenuOffsetY;

  /// Scale delta applied to the left control.
  final double leftMenuScale;

  /// X-axis rotation applied to the left control.
  final double leftMenuRotateX;

  /// Y-axis rotation applied to the left control.
  final double leftMenuRotateY;

  /// Z-axis rotation applied to the left control.
  final double leftMenuRotateZ;

  /// Initial translation of the left control.
  final Offset leftMenuInitOffset;

  /// Icon displayed by the left control.
  final Icon leftMenuIcon;

  /// Called when the left control is activated.
  final VoidCallback? onLeftTap;

  /// Background color of the left control.
  final Color leftMenuBgColor;

  /// Background alpha of the left control, from 0 to 255.
  final int leftMenuBgAlpha;

  /// Corner radius of the left control.
  final double leftMenuRadius;

  /// Padding within the left control.
  final EdgeInsets leftMenuPadding;

  /// Accessibility label and hover tooltip for the left control.
  final String? leftMenuTooltip;

  // Right Menu Controls
  /// Horizontal travel of the right control.
  final double rightMenuOffsetX;

  /// Vertical travel of the right control.
  final double rightMenuOffsetY;

  /// Scale delta applied to the right control.
  final double rightMenuScale;

  /// X-axis rotation applied to the right control.
  final double rightMenuRotateX;

  /// Y-axis rotation applied to the right control.
  final double rightMenuRotateY;

  /// Z-axis rotation applied to the right control.
  final double rightMenuRotateZ;

  /// Initial translation of the right control.
  final Offset rightMenuInitOffset;

  /// Icon displayed by the right control.
  final Icon rightMenuIcon;

  /// Called when the right control is activated.
  final VoidCallback? onRightTap;

  /// Background color of the right control.
  final Color rightMenuBgColor;

  /// Background alpha of the right control, from 0 to 255.
  final int rightMenuBgAlpha;

  /// Corner radius of the right control.
  final double rightMenuRadius;

  /// Padding within the right control.
  final EdgeInsets rightMenuPadding;

  /// Accessibility label and hover tooltip for the right control.
  final String? rightMenuTooltip;

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
    final disableAnimations =
        MediaQuery.maybeOf(context)?.disableAnimations ?? false;

    useEffect(() {
      if (disableAnimations) {
        animationController.value = isOpen ? 1 : 0;
      } else if (isOpen) {
        animationController.forward();
      } else {
        animationController.reverse();
      }
      return null;
    }, [isOpen, disableAnimations]);

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
                child: _FlowTopMenuButton(
                  onTap: onLeftTap,
                  tooltip: leftMenuTooltip,
                  backgroundColor: leftMenuBgColor.withAlpha(leftMenuBgAlpha),
                  radius: leftMenuRadius,
                  padding: leftMenuPadding,
                  icon: leftMenuIcon,
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
                child: _FlowTopMenuButton(
                  onTap: onRightTap,
                  tooltip: rightMenuTooltip,
                  backgroundColor: rightMenuBgColor.withAlpha(rightMenuBgAlpha),
                  radius: rightMenuRadius,
                  padding: rightMenuPadding,
                  icon: rightMenuIcon,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FlowTopMenuButton extends StatelessWidget {
  const _FlowTopMenuButton({
    required this.onTap,
    required this.tooltip,
    required this.backgroundColor,
    required this.radius,
    required this.padding,
    required this.icon,
  });

  final VoidCallback? onTap;
  final String? tooltip;
  final Color backgroundColor;
  final double radius;
  final EdgeInsets padding;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(radius);
    final button = Material(
      color: backgroundColor,
      borderRadius: borderRadius,
      child: InkWell(
        onTap: onTap,
        canRequestFocus: onTap != null,
        borderRadius: borderRadius,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
          child: Padding(
            padding: padding,
            child: Center(child: ExcludeSemantics(child: icon)),
          ),
        ),
      ),
    );

    final semanticButton = Semantics(
      button: true,
      enabled: onTap != null,
      label: tooltip,
      child: button,
    );

    return tooltip == null
        ? semanticButton
        : Tooltip(message: tooltip!, child: semanticButton);
  }
}
