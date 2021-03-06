import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hex_editor/app_button.dart';

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
  static const double addressWidth = 80;
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

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: textStyle,
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
    );
  }
}
