import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const _height = 56.0;

/// {@template action_item_model}
/// Can be used to provide action buttons in the [AnimatedFab] using
/// instances of this class
/// {@endtemplate}
class ActionItemModel {
  /// Provide the text that is displayed in the action FAB
  final String text;

  /// Provide the icon that is shown as the child of the action FAB
  final IconData icon;

  /// Provide the callback function which will run when the action
  /// FAB is pressed
  final VoidCallback onPressed;

  /// {@macro action_item_model}
  const ActionItemModel({
    @required this.text,
    @required this.icon,
    @required this.onPressed,
  });
}

class _ActionItem extends StatelessWidget {
  final bool expanded;
  final double opacity;
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  _ActionItem({
    Key key,
    @required this.expanded,
    this.text,
    @required this.icon,
    @required this.onPressed,
    this.opacity,
  })  : assert(expanded != null),
        assert(icon != null),
        assert(onPressed != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final fab = Container(
      height: _height,
      width: _height,
      padding: EdgeInsets.all(8.0),
      child: FittedBox(
        child: FloatingActionButton(
          heroTag: 'Hero-${text ?? DateTime.now().microsecondsSinceEpoch}',
          backgroundColor: Colors.white,
          onPressed: onPressed,
          child: Icon(
            icon,
            size: 26,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );

    if (!expanded) {
      return fab;
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Opacity(
          opacity: opacity ?? 1.0,
          child: Text(
            text ?? "",
            style: TextStyle(
              fontSize: 16,
              letterSpacing: 0.5,
            ),
          ),
        ),
        SizedBox(width: 8.0),
        fab,
      ],
    );
  }
}

/// {@template animated_fab}
/// Can be used to provide action buttons in the [AnimatedFab] using
/// instances of this class
/// {@endtemplate}
class AnimatedFab extends StatefulWidget {
  /// [List] of [ActionItemModel] model that will be used to generate
  /// [FloatingActionButton]s
  final List<ActionItemModel> actions;

  /// Key to be used in Scaffold
  final GlobalKey<ScaffoldState> scaffoldKey;

  /// Drawer to be used in the Scaffold
  final Widget drawer;

  /// Body of the Scaffold. This is required
  final Widget body;

  /// AppBar of the Scaffold
  final PreferredSizeWidget appBar;

  /// Default icon of the main FAB
  final IconData icon1;

  /// Icon of the FAB on pressed
  final IconData icon2;

  /// {@macro animated_fab}
  const AnimatedFab({
    Key key,
    this.scaffoldKey,
    this.appBar,
    this.drawer,
    @required this.body,
    @required this.actions,
    this.icon1 = Icons.add,
    this.icon2 = Icons.close,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AnimatedFabState();
}

class _AnimatedFabState extends State<AnimatedFab>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  CurvedAnimation curvedAnimation;
  Animation<double> translationAnimation;
  bool isOpened = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    curvedAnimation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    );
    translationAnimation = Tween<double>(
      begin: _height,
      end: -8,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Interval(
        0.0,
        0.75,
        curve: Curves.easeOut,
      ),
    ));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void animate() {
    if (!isOpened) {
      controller.forward();
    } else {
      controller.reverse();
    }
    isOpened = !isOpened;
  }

  Widget fab() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        FloatingActionButton(
          onPressed: animate,
          heroTag: 'Menu',
          child: AnimatedBuilder(
              animation: curvedAnimation,
              builder: (context, _) {
                final thresh = 0.1;
                if (curvedAnimation.value > thresh) {
                  final rotation = Tween<double>(
                    begin: -0.25,
                    end: 0,
                  ).animate(
                    CurvedAnimation(
                      parent: curvedAnimation,
                      curve: Interval(
                        thresh,
                        1.0,
                      ),
                    ),
                  );
                  return ScaleTransition(
                    scale: curvedAnimation,
                    child: RotationTransition(
                      turns: rotation,
                      child: Icon(widget.icon2),
                    ),
                  );
                }

                final opacity = Tween<double>(
                  begin: 1.0,
                  end: 0.0,
                ).animate(
                  CurvedAnimation(
                    parent: curvedAnimation,
                    curve: Interval(
                      0.0,
                      thresh,
                    ),
                  ),
                );
                return FadeTransition(
                  opacity: opacity,
                  child: Icon(widget.icon1),
                );
              }),
        ),
      ],
    );
  }

  List<Widget> animatedChildren() {
    final children = <Widget>[];
    for (var i = 0; i < widget.actions.length; i++) {
      children.add(Transform(
        transform: Matrix4.translationValues(
          0,
          translationAnimation.value * (widget.actions.length - i),
          0,
        ),
        child: _ActionItem(
          text: widget.actions[i].text,
          icon: widget.actions[i].icon,
          onPressed: () {
            if (isOpened) {
              animate();
            }
            widget.actions[i].onPressed();
          },
          expanded: curvedAnimation.value >= 0.2,
          opacity: curvedAnimation.value,
        ),
      ));
    }
    return children;
  }

  @override
  Widget build(BuildContext context) {
    final fabs = AnimatedBuilder(
      animation: curvedAnimation,
      child: fab(),
      builder: (context, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ...animatedChildren(),
            child,
          ],
        );
      },
    );

    final backdrop = AnimatedBuilder(
      animation: curvedAnimation,
      child: InkWell(
        onTap: () {
          if (isOpened) {
            animate();
          }
        },
        child: Container(
          color: Colors.white60,
        ),
      ),
      builder: (context, child) {
        return BackdropFilter(
          filter: ui.ImageFilter.blur(
            sigmaX: curvedAnimation.value * 9,
            sigmaY: curvedAnimation.value * 9,
          ),
          child: FadeTransition(
            opacity: curvedAnimation,
            child: curvedAnimation.value >= 0.05 ? child : null,
          ),
        );
      },
    );

    return Scaffold(
      key: widget.scaffoldKey,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Scaffold(
            drawer: widget.drawer,
            appBar: widget.appBar,
            body: widget.body,
          ),
          Positioned.fill(
            child: backdrop,
          ),
        ],
      ),
      floatingActionButton: fabs,
    );
  }
}
