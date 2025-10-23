import 'package:flow_drawer/src/flow_drawer_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'flow_drawer_controller.dart';

class FlowDrawer extends HookWidget {
  // Main screen displayed inside the drawer
  final Widget child;

  // Menu item widgets (rendered in ListView)
  final List<Widget> drawerItems;

  // Controller to open/close the drawer
  final FlowDrawerController controller;

  // Drag to Open or Close
  final bool enableSwipeToClose;
  final bool enableSwipeToOpen;
  final bool enableTapScreenToClose;

  // ========== DRAWER BACKGROUND CONTROLS ==========
  final Gradient? drawerGradient; // Gradient background
  final Color? color; // Solid background (optional alternative to gradient)
  final DecorationImage?
  drawerImage; // Image background (optional alternative to color/gradient)
  final double drawerBackgroundDelta; // X-offset during animation
  final double drawerBackgroundScale; // Scale during animation
  final EdgeInsets drawerPadding; // Padding for drawer list

  // ========== DRAWER CARD SHADOW CONTROLS ==========
  final Color shadowCardColor; // Color of the shadow container
  final int shadowCardColorAlpha; // Alpha of shadow (0–255)
  final double shadowCardRadius; // Border radius of shadow
  final double shadowOffsetX; // X-offset of shadow
  final double shadowOffsetY; // Y-offset of shadow
  final double shadowCardScale; // Scale of shadow container

  // ========== MAIN CARD / CHILD CONTROLS ==========
  final double cardRadius; // Border radius of the child/card
  final double childOffsetX; // Translate X of child during animation
  final double childOffsetY; // Translate Y of child during animation
  final double childScale; // Scale of child during animation
  final double childRotationZ; // Z-axis rotation of child
  final double cardRotateY; // Y-axis 3D rotation of child
  final double cardRotateX; // X-axis 3D rotation of child

  // ========== DRAWER BEHAVIOR CONTROLS ==========
  final double maxSlide; // Max drawer slide width
  final int animationDuration; // Total duration of open/close animation in ms
  final Curve animationCurve; // Curve used for animation
  final int itemsEnterDelay; // Delay before menu items appear
  final int itemsExitDelay; // Delay before menu items disappear

  // ========== TOP MENU BAR =========

  final bool enableTopMenu;
  final Widget? topMenu;

  // ========== CONSTRUCTOR ==========
  const FlowDrawer({
    super.key,
    required this.child,
    required this.drawerItems,
    required this.controller,

    this.enableSwipeToClose = true,
    this.enableSwipeToOpen = true,
    this.enableTapScreenToClose = true,

    // ----- Drawer Background -----
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

    // ----- Shadow Card -----
    this.shadowCardColor = Colors.white,
    this.shadowCardColorAlpha = 100,
    this.shadowCardRadius = 50,
    this.shadowOffsetX = -50,
    this.shadowOffsetY = 35,
    this.shadowCardScale = 0.1,

    // ----- Main Card / Child -----
    this.cardRadius = 50,
    this.childOffsetX = 320,
    this.childOffsetY = 20,
    this.childScale = 0.45,
    this.childRotationZ = 0.04,
    this.cardRotateY = 0,
    this.cardRotateX = 0,

    // ----- Drawer Animation Behavior -----
    this.maxSlide = 250.0,
    this.animationDuration = 400,
    this.animationCurve = Curves.decelerate,
    this.itemsEnterDelay = 0,
    this.itemsExitDelay = 200,

    // ------- Top Menu Bar ---------
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

    useEffect(() {
      if (isOpen) {
        animationController.forward();
        Future.delayed(Duration(milliseconds: itemsEnterDelay), () {
          isItemsOpen.value = true;
        });
      } else {
        animationController.reverse();
        Future.delayed(Duration(milliseconds: itemsExitDelay), () {
          isItemsOpen.value = false;
        });
      }
      return null;
    }, [isOpen]);

    return Stack(
      children: [
        Positioned.fill(
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..translateByDouble(drawerBackgroundDelta * animation, 0, 0, 1.0)
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
                color: (drawerImage == null && color != null) ? color : null,
              ),
            ),
          ),
        ),

        FlowDrawerListWidget(
          drawerItems: drawerItems,
          controller: controller,
          isOpen: isItemsOpen.value,
          drawerPadding: drawerPadding,
        ),

        // Top Menu,
        if (enableTopMenu) topMenu ?? SizedBox.shrink(),
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, -0.0018)
            ..translateByDouble(
              childOffsetX * animation,
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
                    // Optional: track starting point
                  },
                  onHorizontalDragUpdate: (details) {
                    final isSwipingLeft = details.delta.dx < -5;

                    if (isSwipingLeft && enableSwipeToClose) {
                      controller.close();
                    }
                  },
                  child: AbsorbPointer(absorbing: isOpen, child: child),
                ),
              ),
              enableSwipeToOpen
                  ? Positioned(
                      left: 0,
                      top: 0,
                      bottom: 0,
                      width: 20,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onHorizontalDragUpdate: (details) {
                          if (details.delta.dx > 10) {
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
  }
}
