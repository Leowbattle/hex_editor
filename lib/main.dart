import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(HexEditorApp());
}

class HexEditorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   home: Scaffold(
    //     body: Text("Hi"),
    //   ),
    //   debugShowCheckedModeBanner: false,
    // );

    return WidgetsApp(
      color: Colors.white,
      textStyle: TextStyle(color: Colors.black),
      builder: (_, __) {
        return Container(
          child: Wrap(
            alignment: WrapAlignment.spaceEvenly,
            children: [
              for (int i = 0; i < 10; i++) AppButton(child: Icon(Icons.star))
            ],
          ),
          color: Colors.white,
        );
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class AppButton extends SingleChildRenderObjectWidget {
  AppButton({
    required this.child,
    this.padding = const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderAppButton(padding: padding);
  }
}

class _RenderAppButton extends RenderPadding {
  _RenderAppButton({required EdgeInsetsGeometry padding})
      : super(padding: padding);

  final Paint blurPaint = Paint()
    ..color = Colors.black.withAlpha(127)
    ..maskFilter = MaskFilter.blur(BlurStyle.outer, 5);

  final Paint outlinePaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1
    ..color = Color(0xff808080);

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;

    canvas.save();
    canvas.translate(offset.dx, offset.dy);

    // Rounded rectangle of the button
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTRB(
        0,
        0,
        size.width,
        size.height,
      ),
      Radius.circular(5),
    );

    // Draw blur
    canvas.drawRRect(rrect, blurPaint);

    // Draw button
    canvas.drawRRect(
      rrect,
      Paint()
        ..shader = LinearGradient(
          colors: [
            Color(0xffe0e0e0),
            Color(0xffdbdbdb),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(rrect.outerRect),
    );

    // Draw outline
    canvas.drawRRect(rrect, outlinePaint);

    // Draw child
    super.paint(context, Offset.zero);

    canvas.restore();
  }
}
