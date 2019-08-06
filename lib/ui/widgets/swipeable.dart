import 'dart:math' as math;
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

const double _kDismissThreshold = 0.4;

/// The direction in which a [Dismissible] can be dismissed.
enum SwipeDirection {
  /// The [Swipeable] can be swiped by dragging in the reverse of the
  /// reading direction (e.g., from right to left in left-to-right languages).
  endToStart,

  /// The [Swipeable] can be swiped by dragging in the reading direction
  /// (e.g., from left to right in left-to-right languages).
  startToEnd,
}

class Swipeable extends StatefulWidget {
  const Swipeable({
    Key key,
    @required this.child,
    this.background,
    this.onSwiped,
    this.direction = SwipeDirection.startToEnd,
    this.swipeThresholds = const <SwipeDirection, double>{},
    this.movementDuration = const Duration(milliseconds: 200),
    this.crossAxisEndOffset = 0.0,
    this.dragStartBehavior = DragStartBehavior.start,
  })  : assert(background != null),
        assert(dragStartBehavior != null),
        super(key: key);

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.child}
  final Widget child;

  /// A widget that is stacked behind the child. If secondaryBackground is also
  /// specified then this widget only appears when the child has been dragged
  /// down or to the right.
  final Widget background;

  /// Called when the widget has been swiped, only once per drag.
  final VoidCallback onSwiped;

  /// The direction in which the widget can be swiped.
  final SwipeDirection direction;

  /// The offset threshold the item has to be dragged in order to be considered
  /// swiped.
  ///
  /// Represented as a fraction, e.g. if it is 0.4 (the default), then the item
  /// has to be dragged at least 40% towards one direction to be considered
  /// swiped. Clients can define different thresholds for each swipe
  /// direction.
  ///
  ///
  /// See also [direction], which controls the directions in which the items can
  /// be swiped. Setting a threshold of 1.0 (or greater) prevents a drag in
  /// the given [DismissDirection] even if it would be allowed by the
  /// [direction] property.
  final Map<SwipeDirection, double> swipeThresholds;

  /// Defines the duration for card to dismiss or to come back to original position.
  final Duration movementDuration;

  /// Defines the end offset across the main axis after the card is swiped.
  ///
  /// If non-zero value is given then widget moves in cross direction depending on whether
  /// it is positive or negative.
  final double crossAxisEndOffset;

  /// Determines the way that drag start behavior is handled.
  ///
  /// If set to [DragStartBehavior.start], the drag gesture used to dismiss a
  /// dismissible will begin upon the detection of a drag gesture. If set to
  /// [DragStartBehavior.down] it will begin when a down event is first detected.
  ///
  /// In general, setting this to [DragStartBehavior.start] will make drag
  /// animation smoother and setting it to [DragStartBehavior.down] will make
  /// drag behavior feel slightly more reactive.
  ///
  /// By default, the drag start behavior is [DragStartBehavior.start].
  ///
  /// See also:
  ///
  ///  * [DragGestureRecognizer.dragStartBehavior], which gives an example for the different behaviors.
  final DragStartBehavior dragStartBehavior;

  @override
  _SwipeableState createState() => _SwipeableState();
}

class _SwipeableClipper extends CustomClipper<Rect> {
  _SwipeableClipper({
    @required this.axis,
    @required this.moveAnimation,
  })  : assert(axis != null),
        assert(moveAnimation != null),
        super(reclip: moveAnimation);

  final Axis axis;
  final Animation<Offset> moveAnimation;

  @override
  Rect getClip(Size size) {
    assert(axis != null);
    switch (axis) {
      case Axis.horizontal:
        final double offset = moveAnimation.value.dx * size.width;
        if (offset < 0) return Rect.fromLTRB(size.width + offset, 0.0, size.width, size.height);
        return Rect.fromLTRB(0.0, 0.0, offset, size.height);
      case Axis.vertical:
        final double offset = moveAnimation.value.dy * size.height;
        if (offset < 0) return Rect.fromLTRB(0.0, size.height + offset, size.width, size.height);
        return Rect.fromLTRB(0.0, 0.0, size.width, offset);
    }
    return null;
  }

  @override
  Rect getApproximateClipRect(Size size) => getClip(size);

  @override
  bool shouldReclip(_SwipeableClipper oldClipper) {
    return oldClipper.axis != axis || oldClipper.moveAnimation.value != moveAnimation.value;
  }
}

class _SwipeableState extends State<Swipeable> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    _moveController = AnimationController(duration: widget.movementDuration, vsync: this);
    _updateMoveAnimation();
  }

  AnimationController _moveController;
  Animation<Offset> _moveAnimation;

  double _dragExtent = 0.0;
  bool _dragUnderway = false;
  bool _pastThreshold = false;

  @override
  bool get wantKeepAlive => _moveController?.isAnimating == true;

  @override
  void dispose() {
    _moveController.dispose();
    super.dispose();
  }

  bool get _isActive {
    return _dragUnderway || _moveController.isAnimating;
  }

  double get _overallDragAxisExtent {
    final Size size = context.size;
    return size.width;
  }

  void _handleDragStart(DragStartDetails details) {
    _dragUnderway = true;
    if (_moveController.isAnimating) {
      _dragExtent = _moveController.value * _overallDragAxisExtent * _dragExtent.sign;
      _moveController.stop();
    } else {
      _dragExtent = 0.0;
      _moveController.value = 0.0;
    }
    setState(() {
      _updateMoveAnimation();
    });
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (!_isActive || _moveController.isAnimating) return;

    final double delta = details.primaryDelta;
    final double oldDragExtent = _dragExtent;
    switch (widget.direction) {
      case SwipeDirection.endToStart:
        switch (Directionality.of(context)) {
          case TextDirection.rtl:
            if (_dragExtent + delta > 0) _dragExtent += delta;
            break;
          case TextDirection.ltr:
            if (_dragExtent + delta < 0) _dragExtent += delta;
            break;
        }
        break;

      case SwipeDirection.startToEnd:
        switch (Directionality.of(context)) {
          case TextDirection.rtl:
            if (_dragExtent + delta < 0) _dragExtent += delta;
            break;
          case TextDirection.ltr:
            if (_dragExtent + delta > 0) _dragExtent += delta;
            break;
        }
        break;
    }

    if (oldDragExtent.sign != _dragExtent.sign) {
      setState(() {
        _updateMoveAnimation();
        _pastThreshold = false;
      });
    }

    if (!_moveController.isAnimating) {
      var position = _dragExtent.abs() / _overallDragAxisExtent;

      if (position >= _kDismissThreshold) {
        final movePastThresholdPixels = _kDismissThreshold * _overallDragAxisExtent;

        // how many "thresholds" past the threshold we are.
        var n = _dragExtent.abs() / movePastThresholdPixels;

        // Take the number of thresholds past the threshold, and reduce this number
        var reducedThreshold = math.pow(n, 0.3);

        var adjustedPixelPos = movePastThresholdPixels * reducedThreshold;
        position = adjustedPixelPos / _overallDragAxisExtent;

        if (!_pastThreshold) {
          _pastThreshold = true;

          if (widget.onSwiped != null) {
            widget.onSwiped();
          }
        }
      }

      _moveController.value = position;
    }
  }

  void _updateMoveAnimation() {
    final double end = _dragExtent.sign;
    _moveAnimation = _moveController.drive(
      Tween<Offset>(
        begin: Offset.zero,
        end: Offset(end, widget.crossAxisEndOffset),
      ),
    );
  }

  Future<void> _handleDragEnd(DragEndDetails details) async {
    if (!_isActive || _moveController.isAnimating) return;

    _dragUnderway = false;

    if (_moveController.isCompleted) {
      return;
    }

    _moveController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // See AutomaticKeepAliveClientMixin.

    Widget background = widget.background;

    Widget content = SlideTransition(
      position: _moveAnimation,
      child: widget.child,
    );

    if (background != null) {
      final List<Widget> children = <Widget>[];

      if (!_moveAnimation.isDismissed) {
        children.add(
          Positioned.fill(
            child: ClipRect(
              clipper: _SwipeableClipper(
                axis: Axis.horizontal,
                moveAnimation: _moveAnimation,
              ),
              child: background,
            ),
          ),
        );
      }

      children.add(content);
      content = Stack(children: children);
    }
    // We are not resizing but we may be being dragging in widget.direction.
    return GestureDetector(
      onHorizontalDragStart: _handleDragStart,
      onHorizontalDragUpdate: _handleDragUpdate,
      onHorizontalDragEnd: _handleDragEnd,
      behavior: HitTestBehavior.opaque,
      child: content,
      dragStartBehavior: widget.dragStartBehavior,
    );
  }
}
