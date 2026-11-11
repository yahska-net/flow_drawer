import 'dart:async';

import 'package:flow_drawer/src/enums/flow_drawer_positions_enum.dart';
import 'package:flow_drawer/src/widgets/flow_drawer_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../controllers/flow_drawer_controller.dart';

/// An animated drawer that wraps an application's main screen.
class FlowDrawer extends HookWidget {
  /// Main screen displayed above the drawer.
  final Widget child;

  /// Widgets rendered in the drawer's item list.
  final List<Widget> drawerItems;

  /// Controller used to open and close the drawer.
  final FlowDrawerController controller;

  /// Whether a swipe toward the drawer edge closes it.
  final bool enableSwipeToClose;

  /// Whether an inward swipe from the drawer edge opens it.
  final bool enableSwipeToOpen;

  /// Whether tapping the transformed main screen closes an open drawer.
  final bool enableTapScreenToClose;

  /// Gradient used for the drawer background when [color] and [drawerImage]
  /// are null.
  final Gradient? drawerGradient;

  /// Optional solid drawer background color.
  final Color? color;

  /// Optional image drawn behind the drawer.
  final DecorationImage? drawerImage;

  /// Horizontal travel applied to the drawer background.
  final double drawerBackgroundDelta;

  /// Scale applied to the drawer background.
  final double drawerBackgroundScale;

  /// Padding around the drawer item list.
  final EdgeInsets drawerPadding;

  /// Whether the drawer list sizes itself to its contents.
  final bool drawerShrinkWrap;

  /// Scroll behavior of the drawer item list.
  final ScrollPhysics drawerPhysics;

  /// Physical edge where the drawer is displayed.
  final FlowDrawerPosition drawerPosition;

  /// Color of the card behind the main screen.
  final Color shadowCardColor;

  /// Alpha of [shadowCardColor], from 0 to 255.
  final int shadowCardColorAlpha;

  /// Animated corner radius of the shadow card.
  final double shadowCardRadius;

  /// Horizontal travel of the shadow card.
  final double shadowOffsetX;

  /// Vertical travel of the shadow card.
  final double shadowOffsetY;

  /// Scale delta applied to the shadow card.
  final double shadowCardScale;

  /// Animated corner radius of the main screen.
  final double cardRadius;

  /// Horizontal travel of the main screen, clamped to the viewport.
  final double childOffsetX;

  /// Vertical travel of the main screen.
  final double childOffsetY;

  /// Scale delta applied to the main screen.
  final double childScale;

  /// Z-axis rotation applied to the main screen.
  final double childRotationZ;

  /// Y-axis rotation applied to the main screen.
  final double cardRotateY;

  /// X-axis rotation applied to the main screen.
  final double cardRotateX;

  /// Duration of the main open and close animation in milliseconds.
  final int animationDuration;

  /// Curve used by the main open and close animation.
  final Curve animationCurve;

  /// Delay before drawer items enter, in milliseconds.
  final int itemsEnterDelay;

  /// Delay before drawer items exit, in milliseconds.
  final int itemsExitDelay;

  /// Additional animation duration for each successive item, in milliseconds.
  final int itemsEnterAnimationDelay;

  /// Whether [topMenu] is displayed above the main screen.
  final bool enableTopMenu;

  /// Optional custom widget displayed at the top of the drawer.
  final Widget? topMenu;

  /// Creates a drawer docked to the left edge.
  const FlowDrawer({
    super.key,
    required this.child,
    required this.drawerItems,
    required this.controller,

    this.enableSwipeToClose = true,
    this.enableSwipeToOpen = true,
    this.enableTapScreenToClose = true,

    /// ----- Drawer Background -----
    this.drawerGradient = const LinearGradient(
      colors: [
        Color.fromARGB(255, 172, 0, 0),
        Color.fromARGB(255, 173, 86, 195),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    this.color,
    this.drawerImage,
    this.drawerBackgroundDelta = 100,
    this.drawerBackgroundScale = 1.7,
    this.drawerPadding = const EdgeInsets.only(top: 100, left: 30),
    this.drawerShrinkWrap = false,
    this.drawerPhysics = const NeverScrollableScrollPhysics(),
    this.drawerPosition = FlowDrawerPosition.left,

    /// ----- Shadow Card -----
    this.shadowCardColor = Colors.white,
    this.shadowCardColorAlpha = 100,
    this.shadowCardRadius = 50,
    this.shadowOffsetX = -50,
    this.shadowOffsetY = 35,
    this.shadowCardScale = 0.1,

    /// ----- Main Card / Child -----
    this.cardRadius = 50,
    this.childOffsetX = 320,
    this.childOffsetY = 20,
    this.childScale = 0.45,
    this.childRotationZ = 0.04,
    this.cardRotateY = 0,
    this.cardRotateX = 0,

    /// ----- Drawer Animation Behavior -----
    this.animationDuration = 400,
    this.animationCurve = Curves.decelerate,
    this.itemsEnterDelay = 50,
    this.itemsExitDelay = 150,
    this.itemsEnterAnimationDelay = 80,

    /// ------- Top Menu Bar ---------
    this.enableTopMenu = false,
    this.topMenu,
  });

  /// Creates a drawer docked to the right edge.
  const FlowDrawer.rightDocked({
    super.key,
    required this.child,
    required this.drawerItems,
    required this.controller,

    this.enableSwipeToClose = true,
    this.enableSwipeToOpen = true,
    this.enableTapScreenToClose = true,

    /// ----- Drawer Background -----
    this.drawerGradient = const LinearGradient(
      colors: [
        Color.fromARGB(255, 172, 0, 0),
        Color.fromARGB(255, 173, 86, 195),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    this.color,
    this.drawerImage,
    this.drawerBackgroundDelta = 100,
    this.drawerBackgroundScale = 1.7,
    this.drawerPadding = const EdgeInsets.only(top: 100, left: 30),
    this.drawerShrinkWrap = false,
    this.drawerPhysics = const NeverScrollableScrollPhysics(),
    this.drawerPosition = FlowDrawerPosition.right,

    /// ----- Shadow Card -----
    this.shadowCardColor = Colors.white,
    this.shadowCardColorAlpha = 100,
    this.shadowCardRadius = 50,
    this.shadowOffsetX = 100,
    this.shadowOffsetY = 35,
    this.shadowCardScale = 0.1,

    /// ----- Main Card / Child -----
    this.cardRadius = 50,
    this.childOffsetX = -370,
    this.childOffsetY = 20,
    this.childScale = 0.45,
    this.childRotationZ = -0.04,
    this.cardRotateY = 0,
    this.cardRotateX = 0,

    /// ----- Drawer Animation Behavior -----
    this.animationDuration = 400,
    this.animationCurve = Curves.decelerate,
    this.itemsEnterDelay = 50,
    this.itemsExitDelay = 150,
    this.itemsEnterAnimationDelay = 80,

    /// ------- Top Menu Bar ---------
    this.enableTopMenu = false,
    this.topMenu,
  });

  @override
  Widget build(BuildContext context) {
    final ticker = useSingleTickerProvider();
    final animationController = useMemoized(
      () => AnimationController(
        vsync: ticker,
        duration: Duration(milliseconds: animationDuration),
      ),
    );

    useEffect(() {
      return () => animationController.dispose();
    }, []);

    final animation = useAnimation(
      Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: animationController, curve: animationCurve),
      ),
    );

    final isOpen = useListenable(controller).isOpen;
    final isItemsOpen = useState(false);
    final disableAnimations =
        MediaQuery.maybeOf(context)?.disableAnimations ?? false;

    useEffect(() {
      Timer? itemTransitionTimer;

      if (isOpen) {
        if (disableAnimations) {
          animationController.value = 1;
          isItemsOpen.value = true;
        } else {
          animationController.forward();
          itemTransitionTimer = Timer(
            Duration(milliseconds: itemsEnterDelay),
            () => isItemsOpen.value = true,
          );
        }
      } else {
        if (disableAnimations) {
          animationController.value = 0;
          isItemsOpen.value = false;
        } else {
          animationController.reverse();
          itemTransitionTimer = Timer(
            Duration(milliseconds: itemsExitDelay),
            () => isItemsOpen.value = false,
          );
        }
      }
      return () => itemTransitionTimer?.cancel();
    }, [isOpen, disableAnimations, itemsEnterDelay, itemsExitDelay]);

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxHorizontalOffset = constraints.maxWidth.isFinite
            ? constraints.maxWidth * 0.82
            : childOffsetX.abs();
        final responsiveChildOffsetX = childOffsetX.clamp(
          -maxHorizontalOffset,
          maxHorizontalOffset,
        );

        return Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..translateByDouble(
                    drawerBackgroundDelta * animation,
                    0,
                    0,
                    1.0,
                  )
                  ..scaleByDouble(
                    drawerBackgroundScale,
                    drawerBackgroundScale,
                    1.0,
                    1.0,
                  ),
                child: Container(
                  decoration: BoxDecoration(
                    image: drawerImage,
                    gradient: (color == null && drawerImage == null)
                        ? drawerGradient
                        : null,
                    color: (drawerImage == null && color != null)
                        ? color
                        : null,
                  ),
                ),
              ),
            ),

            FlowDrawerListWidget(
              drawerItems: drawerItems,
              isOpen: isItemsOpen.value,
              drawerPadding: drawerPadding,
              shrinkWrap: drawerShrinkWrap,
              physics: drawerPhysics,
              position: drawerPosition,
              itemsEnterAnimationDelay: itemsEnterAnimationDelay,
              disableAnimations: disableAnimations,
            ),

            /// Top Menu,
            if (enableTopMenu) topMenu ?? SizedBox.shrink(),
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, -0.0018)
                ..translateByDouble(
                  responsiveChildOffsetX * animation,
                  childOffsetY * animation,
                  0,
                  1 + (animation * childScale),
                )
                ..rotateZ(childRotationZ * animation)
                ..rotateX(cardRotateX * animation)
                ..rotateY(cardRotateY * animation),
              child: Stack(
                children: [
                  Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, -0.0018)
                      ..translateByDouble(
                        shadowOffsetX * animation,
                        shadowOffsetY,
                        0,
                        1 + (animation * shadowCardScale),
                      ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: shadowCardColor.withAlpha(shadowCardColorAlpha),
                        borderRadius: BorderRadius.circular(
                          shadowCardRadius * animation,
                        ),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(cardRadius * animation),
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () =>
                          enableTapScreenToClose ? controller.close() : null,
                      onHorizontalDragStart: (details) {
                        /// Optional: track starting point
                      },
                      onHorizontalDragUpdate: (details) {
                        final isLeftDrawer =
                            drawerPosition == FlowDrawerPosition.left;
                        final shouldClose = isLeftDrawer
                            ? details.delta.dx <
                                  -5 // swipe left to close left drawer
                            : details.delta.dx >
                                  5; // swipe right to close right drawer

                        if (shouldClose && enableSwipeToClose) {
                          controller.close();
                        }
                      },
                      child: AbsorbPointer(absorbing: isOpen, child: child),
                    ),
                  ),
                  enableSwipeToOpen
                      ? drawerPosition == FlowDrawerPosition.left
                            ? Positioned(
                                left: 0,
                                top: 0,
                                bottom: 0,
                                width: 24,
                                child: GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onHorizontalDragUpdate: (details) {
                                    if (details.delta.dx > 10) {
                                      controller.open();
                                    }
                                  },
                                ),
                              )
                            : Positioned(
                                right: 0,
                                top: 0,
                                bottom: 0,
                                width: 24,
                                child: GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onHorizontalDragUpdate: (details) {
                                    if (details.delta.dx < -10) {
                                      controller.open();
                                    }
                                  },
                                ),
                              )
                      : SizedBox.shrink(),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
