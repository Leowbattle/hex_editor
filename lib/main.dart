import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(HexEditorApp());
}

class HexEditorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Theme.of(context).copyWith(),
      home: Scaffold(
        body: HexEditor(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HexEditor extends StatefulWidget {
  @override
  _HexEditorState createState() => _HexEditorState();
}

class _HexEditorState extends State<HexEditor> {
  static const double bytePadding = 5;

  static const TextStyle textStyle = TextStyle(
    color: Colors.black,
    fontFamily: "Consolas",
  );

  static Uint8List randomData(int length) {
    Random rng = Random();
    Uint8List list = Uint8List(length);
    for (int i = 0; i < length; i++) {
      list[i] = rng.nextInt(255);
    }
    return list;
  }

  // Uint8List data = Uint8List.fromList(
  //     "Hello there blah blah blah weee I am filling up the space with random text"
  //         .codeUnits);
  Uint8List data = randomData(16 * 1000);

  // Is it printable ASCII?
  bool isPrintable(int c) => (c >= 32) && (c <= 126);

  Widget createHeader() {
    return Row(
      children: [
        // The monospace font means it is valid to insert 8 spaces to align the text.
        Text("        "),
        for (int i = 0; i < 16; i++)
          Padding(
            padding: EdgeInsets.all(bytePadding),
            child: Text(
              i.toRadixString(16).toUpperCase().padLeft(2, '0'),
              style: TextStyle(
                color: Colors.blue[900],
              ),
            ),
          ),
      ],
    );
  }

  TextSpan decodeText(int start, int length) {
    return TextSpan(children: [
      for (int i = start; i < start + length; i++)
        isPrintable(data[i])
            ? TextSpan(text: String.fromCharCode(data[i]))
            : TextSpan(
                text: ".",
                style: TextStyle(
                  color: Colors.grey[400],
                ),
              ),
    ]);
  }

  Widget createRow(BuildContext _, int i) {
    return Row(
      children: [
        Text(
          (i * 16).toRadixString(16).toUpperCase().padLeft(8, '0'),
          style: TextStyle(color: Colors.blue[900]),
        ),
        for (int j = 0; j < 16; j++)
          Padding(
            padding: EdgeInsets.all(bytePadding),
            child: Text(
              data[i * 16 + j].toRadixString(16).toUpperCase().padLeft(2, '0'),
            ),
          ),
        Text.rich(decodeText(i * 16, 16))
      ],
    );
  }

  OverlayEntry? oe;
  void pointerDown(PointerDownEvent event) async {
    oe?.remove();
    oe = null;

    if (event.buttons == kSecondaryButton) {
      final overlay = Overlay.of(context)!;

      GlobalKey key = GlobalKey();
      GlobalKey key2 = GlobalKey();

      oe = OverlayEntry(
        builder: (_) {
          return Positioned(
            width: 150,
            top: event.position.dy,
            left: event.position.dx,
            child: Material(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Blah blah"),
                  MouseRegion(
                    key: key,
                    onEnter: (event) {
                      var rb =
                          key.currentContext?.findRenderObject() as RenderBox?;
                      if (rb == null) {
                        return;
                      }
                      var pos = rb.localToGlobal(Offset.zero);

                      var oe2 = OverlayEntry(builder: (_) {
                        return Positioned(
                          top: pos.dy,
                          left: pos.dx + rb.size.width,
                          width: 150,
                          child: Material(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Blah blah blah"),
                                MouseRegion(
                                  key: key2,
                                  onEnter: (event) {
                                    var rb = key2.currentContext
                                        ?.findRenderObject() as RenderBox?;
                                    if (rb == null) {
                                      return;
                                    }
                                    var pos = rb.localToGlobal(Offset.zero);

                                    overlay.insert(OverlayEntry(builder: (_) {
                                      return Positioned(
                                        top: pos.dy,
                                        left: pos.dx + rb.size.width,
                                        width: 150,
                                        child: Material(
                                          child: Text("Submenu 2"),
                                          elevation: 4,
                                          shape: Border.fromBorderSide(
                                              BorderSide(color: Colors.blue)),
                                        ),
                                      );
                                    }));
                                  },
                                  child: Row(
                                    children: [
                                      Text("Submenu"),
                                      Spacer(),
                                      Icon(Icons.arrow_forward)
                                    ],
                                  ),
                                )
                              ],
                            ),
                            elevation: 4,
                            shape: Border.fromBorderSide(
                                BorderSide(color: Colors.blue)),
                          ),
                        );
                      });

                      overlay.insert(oe2);
                    },
                    child: Row(
                      children: [
                        Text("Hello"),
                        Spacer(),
                        Icon(Icons.arrow_forward)
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.blue,
                  ),
                  MaterialButton(
                    child: Text("Click me"),
                    onPressed: () {
                      print("I was clicked :)");
                    },
                  )
                ],
              ),
              elevation: 4,
              shape: Border.fromBorderSide(BorderSide(color: Colors.blue)),
            ),
          );
        },
      );

      overlay.insert(oe!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: textStyle,
      child: Listener(
        onPointerDown: pointerDown,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            createHeader(),
            Expanded(
              child: Scrollbar(
                isAlwaysShown: true,
                thickness: 20,
                radius: Radius.zero,
                child: ListView.builder(
                  itemBuilder: createRow,
                  itemCount: 1000,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
