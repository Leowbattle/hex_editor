import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AppButton extends StatefulWidget {
  AppButton(
      {required this.child,
      required this.onPressed,
      this.padding = const EdgeInsets.symmetric(vertical: 3, horizontal: 10)});

  final Widget child;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry padding;

  @override
  _AppButtonState createState() => _AppButtonState();
}

enum _ButtonState { Normal, Hover, Pressed }

class _AppButtonState extends State<AppButton> {
  _ButtonState state = _ButtonState.Normal;

  void setButtonState(_ButtonState state) {
    setState(() {
      this.state = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setButtonState(_ButtonState.Pressed);
      },
      onTapUp: (_) {
        setButtonState(_ButtonState.Hover);
      },
      onTapCancel: () {
        print("cancel");
        setButtonState(_ButtonState.Normal);
      },
      onTap: () {
        widget.onPressed();
      },
      child: MouseRegion(
        onEnter: (_) {
          if (state == _ButtonState.Normal) {
            setButtonState(_ButtonState.Hover);
          }
        },
        onExit: (_) {
          setButtonState(_ButtonState.Normal);
        },
        child: _AppButtonRenderObjectWidget(
            child: widget.child, padding: widget.padding, state: state),
      ),
    );
  }
}

class _AppButtonRenderObjectWidget extends SingleChildRenderObjectWidget {
  _AppButtonRenderObjectWidget(
      {required Widget child, required this.padding, required this.state})
      : super(child: child);

  final EdgeInsetsGeometry padding;
  final _ButtonState state;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderAppButton(padding: padding)..state = state;
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant _RenderAppButton renderObject) {
    renderObject..state = state;
  }
}

class _RenderAppButton extends RenderPadding {
  _RenderAppButton({required EdgeInsetsGeometry padding})
      : super(padding: padding);

  _ButtonState _state = _ButtonState.Normal;
  _ButtonState get state => _state;
  set state(_ButtonState value) {
    if (_state != value) {
      markNeedsPaint();
      _state = value;
    }
  }

  final Paint buttonPaint = Paint()..color = Color(0xffe0e0e0);
  final Paint hoverPaint = Paint()..color = Color(0xffcccccc);
  final Paint pressedPaint = Paint()..color = Color(0xff999999);

  final Paint outlinePaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1
    ..color = Color(0xff808080);

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;

    canvas.save();
    canvas.translate(offset.dx, offset.dy);

    // Button rectangle
    final rect = Rect.fromLTRB(
      0,
      0,
      size.width,
      size.height,
    );

    // Draw button
    Paint paint;
    switch (state) {
      case _ButtonState.Normal:
        paint = buttonPaint;
        break;
      case _ButtonState.Hover:
        paint = hoverPaint;
        break;
      case _ButtonState.Pressed:
        paint = pressedPaint;
        break;
    }
    canvas.drawRect(rect, paint);

    // Draw outline
    canvas.drawRect(rect, outlinePaint);

    // Draw child
    super.paint(context, Offset.zero);

    canvas.restore();
  }
}
